import 'dart:convert';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api.dart';
import '../i18n.dart';
import '../models.dart';
import '../session.dart';

/// Image de l'entreprise, gardée sur l'appareil : elle n'est téléchargée
/// qu'une fois par version (le patron en change → nouvelle version).
class LogoCache {
  static final _memory = <String, Uint8List?>{};

  static String _key(Company c) => 'logo:${c.id}';

  static Future<Uint8List?> get(Session session, Company company) async {
    if (company.logoVersion == 0) return null;
    final memoKey = '${company.id}:${company.logoVersion}';
    if (_memory.containsKey(memoKey)) return _memory[memoKey];
    final prefs = await SharedPreferences.getInstance();
    final stored = prefs.getString(_key(company));
    if (stored != null && stored.startsWith('${company.logoVersion}:')) {
      return _memory[memoKey] = base64Decode(stored.substring(stored.indexOf(':') + 1));
    }
    try {
      final bytes = await session.api.bytes('/companies/${company.id}/logo');
      if (bytes == null) return null;
      final data = Uint8List.fromList(bytes);
      await prefs.setString(_key(company), '${company.logoVersion}:${base64Encode(data)}');
      return _memory[memoKey] = data;
    } on OfflineException {
      // Hors connexion : l'ancienne image si on l'a.
      return stored == null ? null : base64Decode(stored.substring(stored.indexOf(':') + 1));
    }
  }
}

/// Petite image ronde de l'entreprise (rien si elle n'en a pas).
class CompanyLogo extends StatelessWidget {
  final Session session;
  final Company company;
  final double size;

  const CompanyLogo({super.key, required this.session, required this.company, this.size = 22});

  @override
  Widget build(BuildContext context) {
    if (company.logoVersion == 0) return const SizedBox.shrink();
    return FutureBuilder(
      future: LogoCache.get(session, company),
      builder: (context, snap) => snap.data == null
          ? SizedBox(width: size, height: size)
          : ClipRRect(
              borderRadius: BorderRadius.circular(size / 4),
              child: Image.memory(snap.data!, width: size, height: size, fit: BoxFit.cover),
            ),
    );
  }
}

/// Patron : choisir l'image de l'entreprise (PNG seulement) ou l'enlever.
class CompanyLogoSettings extends StatefulWidget {
  final Session session;
  final Company company;

  const CompanyLogoSettings({super.key, required this.session, required this.company});

  @override
  State<CompanyLogoSettings> createState() => _CompanyLogoSettingsState();
}

class _CompanyLogoSettingsState extends State<CompanyLogoSettings> {
  bool _busy = false;

  Future<void> _send(Uint8List? png) async {
    final t = context.l10n;
    final messenger = ScaffoldMessenger.of(context);
    setState(() => _busy = true);
    try {
      await widget.session.api
          .send('PUT', '/companies/${widget.company.id}/logo', body: {'png': png == null ? null : base64Encode(png)});
      await widget.session.refresh();
    } on OfflineException {
      messenger.showSnackBar(SnackBar(content: Text(t.offlineUnavailable)));
    } on ApiException catch (e) {
      messenger.showSnackBar(SnackBar(content: Text(e.describe(t))));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _pick() async {
    final t = context.l10n;
    final messenger = ScaffoldMessenger.of(context);
    final file = await FilePicker.pickFile(type: FileType.custom, allowedExtensions: ["png"]);
    final bytes = file == null ? null : await file.readAsBytes();
    if (bytes == null) return;
    // PNG seulement (le serveur le vérifie aussi et réduit l'image).
    const signature = [0x89, 0x50, 0x4E, 0x47];
    if (bytes.length < 8 || bytes.length > 1024 * 1024 || [for (var i = 0; i < 4; i++) bytes[i]].join() != signature.join()) {
      messenger.showSnackBar(SnackBar(content: Text(t.logoPngOnly)));
      return;
    }
    await _send(bytes);
  }

  @override
  Widget build(BuildContext context) {
    final t = context.l10n;
    final theme = Theme.of(context);
    final company = widget.company;
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Text(t.customization, style: theme.textTheme.titleMedium),
      const SizedBox(height: 4),
      Text(t.logoHint, style: theme.textTheme.bodySmall),
      const SizedBox(height: 8),
      Row(children: [
        if (company.logoVersion > 0) ...[
          CompanyLogo(session: widget.session, company: company, size: 56),
          const SizedBox(width: 12),
        ],
        Expanded(
          child: Wrap(spacing: 8, runSpacing: 8, children: [
            FilledButton.tonalIcon(
              onPressed: _busy || company.readOnly ? null : _pick,
              icon: const Icon(Icons.image_outlined),
              label: Text(t.chooseLogo),
            ),
            if (company.logoVersion > 0)
              TextButton.icon(
                onPressed: _busy || company.readOnly ? null : () => _send(null),
                icon: const Icon(Icons.delete_outline),
                label: Text(t.removeLogo),
              ),
          ]),
        ),
      ]),
    ]);
  }
}
