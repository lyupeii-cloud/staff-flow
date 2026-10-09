import 'package:flutter/material.dart';

import '../api.dart';
import '../i18n.dart';
import '../models.dart';
import '../session.dart';

/// Création ou modification d'un groupe de discussion par un responsable :
/// un nom et les personnes choisies. Renvoie l'identifiant du groupe, ou
/// `null` si rien n'a été enregistré.
class GroupEditorPage extends StatefulWidget {
  final Session session;
  final Company company;
  final List<Member> members;

  /// Groupe à modifier ; `null` : nouveau groupe.
  final Conversation? existing;

  const GroupEditorPage(
      {super.key, required this.session, required this.company, required this.members, this.existing});

  static Future<String?> open(BuildContext context,
          {required Session session,
          required Company company,
          required List<Member> members,
          Conversation? existing}) =>
      Navigator.of(context).push<String>(MaterialPageRoute(
        builder: (_) => GroupEditorPage(session: session, company: company, members: members, existing: existing),
      ));

  @override
  State<GroupEditorPage> createState() => _GroupEditorPageState();
}

class _GroupEditorPageState extends State<GroupEditorPage> {
  late final _name = TextEditingController(text: widget.existing?.name ?? '');
  late final Set<String> _chosen = {...?widget.existing?.memberIds};
  bool _saving = false;

  String get _me => widget.session.me!.user.id;

  Future<void> _save() async {
    final t = context.l10n;
    final messenger = ScaffoldMessenger.of(context);
    if (_name.text.trim().isEmpty) return;
    // À la création, le responsable fait partie du groupe d'office.
    if (_chosen.where((id) => id != _me).isEmpty) {
      messenger.showSnackBar(SnackBar(content: Text(t.chooseAtLeastOne)));
      return;
    }
    setState(() => _saving = true);
    try {
      final api = widget.session.api;
      final String id;
      if (widget.existing == null) {
        final j = await api.send('POST', '/companies/${widget.company.id}/groups',
            body: {'name': _name.text.trim(), 'userIds': _chosen.toList()});
        id = j['id'] as String;
      } else {
        id = widget.existing!.id;
        await api.send('PATCH', '/conversations/$id', body: {'name': _name.text.trim(), 'userIds': _chosen.toList()});
      }
      if (mounted) Navigator.pop(context, id);
    } on OfflineException {
      messenger.showSnackBar(SnackBar(content: Text(t.offlineUnavailable)));
    } on ApiException catch (e) {
      messenger.showSnackBar(SnackBar(content: Text(e.describe(t))));
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = context.l10n;
    // À la modification, le responsable peut aussi se retirer.
    final people = [
      for (final m in widget.members)
        if (widget.existing != null || m.user.id != _me) m,
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.existing == null ? t.newGroup : t.editGroup),
        actions: [
          TextButton(
            onPressed: _saving ? null : _save,
            child: Text(t.save, style: const TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              controller: _name,
              autofocus: widget.existing == null,
              maxLength: 120,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(labelText: t.groupName),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
            child: Text(t.groupMembersHint, style: Theme.of(context).textTheme.bodySmall),
          ),
          for (final m in people)
            CheckboxListTile(
              value: _chosen.contains(m.user.id),
              onChanged: (v) => setState(() => v == true ? _chosen.add(m.user.id) : _chosen.remove(m.user.id)),
              secondary: CircleAvatar(
                backgroundImage: m.user.photoUrl == null ? null : NetworkImage(m.user.photoUrl!),
                child: m.user.photoUrl == null ? Text(m.user.name.characters.first.toUpperCase()) : null,
              ),
              title: Text(m.user.id == _me ? t.meSuffix(m.user.name) : m.user.name),
              subtitle: Text(m.role.label(t)),
            ),
        ],
      ),
    );
  }
}
