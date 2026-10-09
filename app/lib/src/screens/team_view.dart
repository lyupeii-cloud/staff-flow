import 'package:flutter/material.dart';

import '../i18n.dart';
import '../models.dart';
import '../session.dart';
import 'home_screen.dart';
import 'people_widgets.dart';

/// Équipe de l'entreprise : membres, rôles, ajout par code, transfert.
class TeamView extends StatefulWidget {
  final Session session;
  final Membership membership;

  /// Appelé quand la liste des membres a pu changer.
  final VoidCallback onChanged;

  const TeamView(
      {super.key, required this.session, required this.membership, required this.onChanged});

  @override
  State<TeamView> createState() => _TeamViewState();
}

class _TeamViewState extends State<TeamView> {
  late Future<List<Member>> _members;

  Company get company => widget.membership.company;
  Role get role => widget.membership.role;
  L10n get t => context.l10n;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void didUpdateWidget(TeamView old) {
    super.didUpdateWidget(old);
    if (old.membership.role != role) _load();
  }

  void _load() {
    _members = widget.session.sync
        .read('members:${company.id}', '/companies/${company.id}/members')
        .then((j) => [for (final m in j['members']) Member.fromJson(m)]);
  }

  Future<void> _act(Future<void> Function() action, {String? success}) async {
    await runAction(context, widget.session, action, success: success);
    if (mounted) setState(_load);
    widget.onChanged();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final me = widget.session.me!.user;
    return RefreshIndicator(
      onRefresh: () async => setState(_load),
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16),
        children: [
          Row(
            children: [
              Expanded(child: Text(t.team, style: theme.textTheme.titleMedium)),
              if (role.canManage && !company.readOnly)
                TextButton.icon(
                  onPressed: _addWithCode,
                  icon: const Icon(Icons.person_add, size: 18),
                  label: Text(t.add),
                ),
              if (role.canManage && !company.readOnly)
                TextButton.icon(
                  onPressed: _rename,
                  icon: const Icon(Icons.edit, size: 18),
                  label: Text(t.rename),
                ),
            ],
          ),
          FutureBuilder(
            future: _members,
            builder: (context, snap) {
              if (snap.hasError) return Text('${snap.error}');
              if (!snap.hasData) {
                return const Padding(
                    padding: EdgeInsets.all(24), child: Center(child: CircularProgressIndicator()));
              }
              return Column(
                children: [for (final m in snap.data!) _memberTile(m, isMe: m.user.id == me.id)],
              );
            },
          ),
          if (role != Role.owner) ...[
            const SizedBox(height: 24),
            OutlinedButton.icon(
              onPressed: _leave,
              icon: const Icon(Icons.logout),
              label: Text(t.leaveCompany),
            ),
          ],
        ],
      ),
    );
  }

  Widget _memberTile(Member m, {required bool isMe}) {
    final actions = isMe || company.readOnly ? const <_MemberAction>[] : _actionsFor(m);
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        backgroundImage: m.user.photoUrl == null ? null : NetworkImage(m.user.photoUrl!),
        child: m.user.photoUrl == null ? Text(m.user.name.characters.first.toUpperCase()) : null,
      ),
      title: Text(isMe ? t.meSuffix(m.user.name) : m.user.name),
      subtitle: Text('${m.role.label(t)} · ${m.user.publicId}'),
      trailing: actions.isEmpty
          ? null
          : PopupMenuButton<_MemberAction>(
              onSelected: (a) => _run(a, m),
              itemBuilder: (_) => [
                for (final a in actions) PopupMenuItem(value: a, child: Text(a.label(t, m))),
              ],
            ),
    );
  }

  /// Mêmes règles que le serveur : le propriétaire gère les responsables,
  /// un responsable gère les salariés et les extras.
  List<_MemberAction> _actionsFor(Member m) {
    if (m.role == Role.owner) return const [];
    final isOwner = role == Role.owner;
    final isManager = role == Role.manager;
    final targetIsStaff = m.role == Role.employee || m.role == Role.extra;
    return [
      if (isOwner || (isManager && targetIsStaff)) _MemberAction.rename,
      if (isOwner && targetIsStaff) _MemberAction.makeManager,
      if (isOwner && m.role == Role.manager) _MemberAction.makeEmployee,
      if ((isOwner || isManager) && targetIsStaff) _MemberAction.toggleExtra,
      if (isOwner && m.role == Role.manager) _MemberAction.transfer,
      if (isOwner || (isManager && targetIsStaff)) _MemberAction.remove,
    ];
  }

  Future<void> _run(_MemberAction a, Member m) async {
    final api = widget.session.api;
    switch (a) {
      case _MemberAction.rename:
        final name = await askName(
          context,
          title: t.renameMemberTitle(m.user.name),
          current: m.user.name,
          hint: '${t.renameMemberHint}\n${t.googleName(m.user.googleName)}',
          resetLabel: t.useOwnName,
          canReset: m.nameInCompany != null,
        );
        if (name != null) {
          await _act(() => api.renameMember(company.id, m.user.id, name.isEmpty ? null : name));
        }
      case _MemberAction.makeManager:
        await _act(() => api.setRole(company.id, m.user.id, Role.manager));
      case _MemberAction.makeEmployee:
        await _act(() => api.setRole(company.id, m.user.id, Role.employee));
      case _MemberAction.toggleExtra:
        final to = m.role == Role.extra ? Role.employee : Role.extra;
        await _act(() => api.setRole(company.id, m.user.id, to));
      case _MemberAction.transfer:
        if (await _confirm(t.transferConfirmTitle(m.user.name), t.transferConfirmBody)) {
          await _act(() => api.proposeTransfer(company.id, m.user.id),
              success: t.transferSent(m.user.name));
        }
      case _MemberAction.remove:
        if (await _confirm(t.removeConfirmTitle(m.user.name), t.removeConfirmBody)) {
          await _act(() => api.removeMember(company.id, m.user.id));
        }
    }
  }

  /// Ajout d'une personne : le responsable scanne son QR code permanent
  /// (menu du compte, « Mon QR code »), ou saisit le code à 6 chiffres
  /// qu'elle a généré. Elle doit ensuite accepter l'invitation.
  Future<void> _addWithCode() async {
    final code = TextEditingController();
    var role = Role.employee;
    final choice = await showDialog<_AddWith>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: Text(t.addPersonTitle),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SegmentedButton<Role>(
                  segments: [
                    ButtonSegment(value: Role.employee, label: Text(Role.employee.label(t))),
                    ButtonSegment(value: Role.extra, label: Text(Role.extra.label(t))),
                  ],
                  selected: {role},
                  onSelectionChanged: (s) => setState(() => role = s.first),
                ),
                const SizedBox(height: 16),
                // Le plus simple avec les mains occupées : un grand bouton.
                FilledButton.icon(
                  style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(64)),
                  onPressed: () => Navigator.pop(context, _AddWith.qr),
                  icon: const Icon(Icons.qr_code_scanner, size: 32),
                  label: Text(t.scanQrCode, style: const TextStyle(fontSize: 18)),
                ),
                const SizedBox(height: 20),
                Text(t.orEnterCode, style: Theme.of(context).textTheme.titleSmall),
                const SizedBox(height: 4),
                Text(t.addPersonHint, style: Theme.of(context).textTheme.bodySmall),
                TextField(
                  controller: code,
                  keyboardType: TextInputType.number,
                  maxLength: 6,
                  style: const TextStyle(fontSize: 24, letterSpacing: 8),
                  decoration: InputDecoration(labelText: t.sixDigitCode, counterText: ''),
                  onSubmitted: (_) => Navigator.pop(context, _AddWith.code),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: Text(t.cancel)),
            FilledButton(onPressed: () => Navigator.pop(context, _AddWith.code), child: Text(t.validate)),
          ],
        ),
      ),
    );
    if (choice == null || !mounted) return;
    final api = widget.session.api;
    String? name;
    if (choice == _AddWith.qr) {
      final qr = await scanQrCode(context);
      if (qr == null || !mounted) return;
      await _act(() async => name = await api.inviteByQr(company.id, qr, role));
    } else {
      await _act(() async => name = await api.redeemJoinCode(company.id, code.text, role));
    }
    if (name != null && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(t.invitationSent(name!))));
    }
  }

  Future<void> _leave() async {
    if (await _confirm(t.leaveConfirmTitle(company.name), t.leaveConfirmBody)) {
      await _act(() => widget.session.api.removeMember(company.id, widget.session.me!.user.id));
    }
  }

  Future<void> _rename() async {
    final name = TextEditingController(text: company.name);
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(t.renameCompany),
        content: TextField(controller: name, autofocus: true),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: Text(t.cancel)),
          FilledButton(onPressed: () => Navigator.pop(context, true), child: Text(t.save)),
        ],
      ),
    );
    if (ok == true) await _act(() => widget.session.api.updateCompany(company.id, name: name.text));
  }

  Future<bool> _confirm(String title, String body) async =>
      await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(title),
          content: Text(body),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context, false), child: Text(t.cancel)),
            FilledButton(onPressed: () => Navigator.pop(context, true), child: Text(t.confirm)),
          ],
        ),
      ) ??
      false;
}

enum _MemberAction {
  rename,
  makeManager,
  makeEmployee,
  toggleExtra,
  transfer,
  remove;

  String label(L10n t, Member m) => switch (this) {
        rename => t.rename,
        makeManager => t.actionMakeManager,
        makeEmployee => t.actionMakeEmployee,
        toggleExtra => m.role == Role.extra ? t.actionToEmployee : t.actionToExtra,
        transfer => t.actionTransfer,
        remove => t.actionRemove,
      };
}

enum _AddWith { qr, code }
