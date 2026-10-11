import 'package:flutter/material.dart';

import '../api.dart';
import '../i18n.dart';
import '../models.dart';
import '../session.dart';
import 'home_screen.dart';

/// Figures proposées pour l'avatar (mêmes noms que le serveur).
const avatarIcons = <String, IconData>{
  'pets': Icons.pets,
  'cruelty_free': Icons.cruelty_free,
  'emoji_nature': Icons.emoji_nature,
  'local_florist': Icons.local_florist,
  'park': Icons.park,
  'spa': Icons.spa,
  'eco': Icons.eco,
  'bolt': Icons.bolt,
  'star': Icons.star,
  'favorite': Icons.favorite,
  'rocket_launch': Icons.rocket_launch,
  'flight': Icons.flight,
  'sailing': Icons.sailing,
  'directions_bike': Icons.directions_bike,
  'sports_soccer': Icons.sports_soccer,
  'music_note': Icons.music_note,
  'headphones': Icons.headphones,
  'palette': Icons.palette,
  'camera_alt': Icons.camera_alt,
  'coffee': Icons.coffee,
  'local_pizza': Icons.local_pizza,
  'icecream': Icons.icecream,
  'cake': Icons.cake,
  'beach_access': Icons.beach_access,
};

/// Couleurs de fond (le serveur garde l'indice).
const avatarColors = <Color>[
  Color(0xFF1A8CFC), Color(0xFF061440), Color(0xFF14B8A6), Color(0xFF22C55E),
  Color(0xFF84CC16), Color(0xFFF59E0B), Color(0xFFF97316), Color(0xFFEF4444),
  Color(0xFFEC4899), Color(0xFFA855F7), Color(0xFF6366F1), Color(0xFF64748B),
];

/// Avatar d'une personne : son avatar choisi, sinon sa photo Google (si
/// l'entreprise ne la masque pas), sinon son initiale.
class UserAvatar extends StatelessWidget {
  final String name;
  final String? photoUrl;
  final Map<String, dynamic>? avatar;
  final double radius;

  const UserAvatar({super.key, required this.name, this.photoUrl, this.avatar, this.radius = 20});

  UserAvatar.of(User user, {super.key, this.radius = 20})
      : name = user.name,
        photoUrl = user.photoUrl,
        avatar = user.avatar;

  @override
  Widget build(BuildContext context) {
    final icon = avatarIcons[avatar?['icon']];
    final color = avatar?['color'];
    if (icon != null && color is int && color >= 0 && color < avatarColors.length) {
      return CircleAvatar(
        radius: radius,
        backgroundColor: avatarColors[color],
        child: Icon(icon, color: Colors.white, size: radius * 1.1),
      );
    }
    return CircleAvatar(
      radius: radius,
      backgroundImage: photoUrl == null ? null : NetworkImage(photoUrl!),
      child: photoUrl == null
          ? Text(name.isEmpty ? '?' : name.characters.first.toUpperCase(), style: TextStyle(fontSize: radius * 0.8))
          : null,
    );
  }
}

/// Choisir son avatar : une figure et une couleur, ou revenir à la photo Google.
Future<void> showAvatarPicker(BuildContext context, Session session) async {
  final t = context.l10n;
  final user = session.me!.user;
  var icon = user.avatar?['icon'] as String? ?? 'pets';
  var color = user.avatar?['color'] as int? ?? 0;
  final result = await showDialog<(bool, Map<String, Object>?)>(
    context: context,
    builder: (context) => StatefulBuilder(
      builder: (context, setState) => AlertDialog(
        title: Text(t.avatarTitle),
        content: SizedBox(
          width: 340,
          child: SingleChildScrollView(
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              UserAvatar(name: user.name, avatar: {'icon': icon, 'color': color}, radius: 40),
              const SizedBox(height: 16),
              Wrap(spacing: 6, runSpacing: 6, alignment: WrapAlignment.center, children: [
                for (final e in avatarIcons.entries)
                  IconButton.filledTonal(
                    isSelected: e.key == icon,
                    onPressed: () => setState(() => icon = e.key),
                    icon: Icon(e.value),
                  ),
              ]),
              const SizedBox(height: 16),
              Align(alignment: Alignment.centerLeft, child: Text(t.avatarColor)),
              const SizedBox(height: 8),
              Wrap(spacing: 8, runSpacing: 8, children: [
                for (final (i, c) in avatarColors.indexed)
                  InkWell(
                    customBorder: const CircleBorder(),
                    onTap: () => setState(() => color = i),
                    child: CircleAvatar(
                      radius: 16,
                      backgroundColor: c,
                      child: i == color ? const Icon(Icons.check, color: Colors.white, size: 18) : null,
                    ),
                  ),
              ]),
            ]),
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, (true, null)), child: Text(t.avatarUseGoogle)),
          FilledButton(
            onPressed: () => Navigator.pop(context, (true, {'icon': icon, 'color': color})),
            child: Text(t.save),
          ),
        ],
      ),
    ),
  );
  if (result == null || !context.mounted) return;
  await runAction(context, session, () => session.api.send('PUT', '/me/avatar', body: {'avatar': result.$2}));
}

/// Patron : masquer les photos Google dans l'entreprise (avatars ou
/// initiales à la place).
class CompanyPhotosSetting extends StatefulWidget {
  final Session session;
  final Company company;

  const CompanyPhotosSetting({super.key, required this.session, required this.company});

  @override
  State<CompanyPhotosSetting> createState() => _CompanyPhotosSettingState();
}

class _CompanyPhotosSettingState extends State<CompanyPhotosSetting> {
  bool _busy = false;

  Future<void> _set(bool hidden) async {
    final t = context.l10n;
    final messenger = ScaffoldMessenger.of(context);
    setState(() => _busy = true);
    try {
      await widget.session.api.send('PUT', '/companies/${widget.company.id}/photos', body: {'hidden': hidden});
      await widget.session.refresh();
    } on OfflineException {
      messenger.showSnackBar(SnackBar(content: Text(t.offlineUnavailable)));
    } on ApiException catch (e) {
      messenger.showSnackBar(SnackBar(content: Text(e.describe(t))));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = context.l10n;
    return SwitchListTile(
      contentPadding: EdgeInsets.zero,
      secondary: const Icon(Icons.no_photography_outlined),
      title: Text(t.hidePhotosTitle),
      subtitle: Text(t.hidePhotosSub),
      value: widget.company.hidePhotos,
      onChanged: _busy || widget.company.readOnly ? null : _set,
    );
  }
}
