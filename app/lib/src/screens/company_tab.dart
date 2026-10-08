import 'package:flutter/material.dart';

import '../models.dart';
import '../session.dart';
import 'home_screen.dart';

/// Contenu de l'onglet d'une entreprise. Phase 1 : informations et membres ;
/// le planning arrive en phase 2.
class CompanyTab extends StatefulWidget {
  final Session session;
  final Membership membership;

  const CompanyTab({super.key, required this.session, required this.membership});

  @override
  State<CompanyTab> createState() => _CompanyTabState();
}

class _CompanyTabState extends State<CompanyTab> {
  late Future<List<Member>> _members;

  Company get company => widget.membership.company;
  Role get role => widget.membership.role;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void didUpdateWidget(CompanyTab old) {
    super.didUpdateWidget(old);
    if (old.membership.role != role) _load();
  }

  void _load() => _members = widget.session.api.members(company.id);

  Future<void> _act(Future<void> Function() action, {String? success}) async {
    await runAction(context, widget.session, action, success: success);
    if (mounted) setState(_load);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final me = widget.session.me!.user;
    return RefreshIndicator(
      onRefresh: () async => setState(_load),
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Row(
            children: [
              Expanded(child: Text(company.name, style: theme.textTheme.headlineSmall)),
              Chip(label: Text(role.label)),
            ],
          ),
          Text(company.timezone, style: theme.textTheme.bodySmall),
          if (company.readOnly)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text('Entreprise en lecture seule.',
                  style: TextStyle(color: theme.colorScheme.error)),
            ),
          const SizedBox(height: 16),
          Card(
            child: ListTile(
              leading: const Icon(Icons.calendar_view_week),
              title: const Text('Planning'),
              subtitle: const Text('Disponible dans la prochaine version.'),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: Text('Équipe', style: theme.textTheme.titleMedium)),
              if (role.canManage && !company.readOnly)
                TextButton.icon(
                  onPressed: _rename,
                  icon: const Icon(Icons.edit, size: 18),
                  label: const Text('Renommer'),
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
              label: const Text('Quitter cette entreprise'),
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
      title: Text(isMe ? '${m.user.name} (vous)' : m.user.name),
      subtitle: Text('${m.role.label} · ${m.user.publicId}'),
      trailing: actions.isEmpty
          ? null
          : PopupMenuButton<_MemberAction>(
              onSelected: (a) => _run(a, m),
              itemBuilder: (_) => [
                for (final a in actions) PopupMenuItem(value: a, child: Text(a.label(m))),
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
      case _MemberAction.makeManager:
        await _act(() => api.setRole(company.id, m.user.id, Role.manager));
      case _MemberAction.makeEmployee:
        await _act(() => api.setRole(company.id, m.user.id, Role.employee));
      case _MemberAction.toggleExtra:
        final to = m.role == Role.extra ? Role.employee : Role.extra;
        await _act(() => api.setRole(company.id, m.user.id, to));
      case _MemberAction.transfer:
        if (await _confirm('Transférer l\'entreprise à ${m.user.name} ?',
            'Une fois qu\'il aura accepté, il deviendra propriétaire (abonnement, factures, '
                'responsables) et vous deviendrez responsable.')) {
          await _act(() => api.proposeTransfer(company.id, m.user.id),
              success: 'Proposition envoyée à ${m.user.name}.');
        }
      case _MemberAction.remove:
        if (await _confirm('Retirer ${m.user.name} ?', 'Son historique est conservé.')) {
          await _act(() => api.removeMember(company.id, m.user.id));
        }
    }
  }

  Future<void> _leave() async {
    if (await _confirm('Quitter ${company.name} ?', 'Vous ne verrez plus son planning.')) {
      await _act(() => widget.session.api.removeMember(company.id, widget.session.me!.user.id));
    }
  }

  Future<void> _rename() async {
    final name = TextEditingController(text: company.name);
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Renommer l\'entreprise'),
        content: TextField(controller: name, autofocus: true),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Annuler')),
          FilledButton(onPressed: () => Navigator.pop(context, true), child: const Text('Enregistrer')),
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
            TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Annuler')),
            FilledButton(onPressed: () => Navigator.pop(context, true), child: const Text('Confirmer')),
          ],
        ),
      ) ??
      false;
}

enum _MemberAction {
  makeManager,
  makeEmployee,
  toggleExtra,
  transfer,
  remove;

  String label(Member m) => switch (this) {
        makeManager => 'Nommer responsable',
        makeEmployee => 'Repasser salarié',
        toggleExtra => m.role == Role.extra ? 'Passer salarié' : 'Passer extra',
        transfer => 'Transférer la propriété',
        remove => 'Retirer de l\'entreprise',
      };
}
