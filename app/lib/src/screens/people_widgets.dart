import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../brand.dart';
import '../i18n.dart';
import '../models.dart';

/// Adresse contenue dans le QR code permanent d'une personne. Le serveur n'en
/// lit que l'identifiant SF-… ; l'adresse ouvre le site si on le scanne avec
/// un appareil photo ordinaire.
String qrPayload(User user) => 'https://app.staff-flow.cloud/u/${user.publicId}';

final _publicId = RegExp(r'SF-[A-Z2-9]{8}');

/// QR code permanent de l'utilisateur (menu du compte) : un responsable le
/// scanne pour l'ajouter à son entreprise, puis l'utilisateur confirme.
Future<void> showMyQrCode(BuildContext context, User user) {
  final t = context.l10n;
  return showDialog<void>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(t.myQrCode),
      content: SizedBox(
        width: 280,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Fond blanc même en thème sombre : les lecteurs le préfèrent.
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
              child: QrImageView(
                data: qrPayload(user),
                size: 240,
                eyeStyle: const QrEyeStyle(eyeShape: QrEyeShape.square, color: Brand.navy),
                dataModuleStyle:
                    const QrDataModuleStyle(dataModuleShape: QrDataModuleShape.square, color: Brand.navy),
              ),
            ),
            const SizedBox(height: 12),
            Text(user.name, style: Theme.of(context).textTheme.titleMedium),
            Text(user.publicId, style: Theme.of(context).textTheme.bodySmall),
            const SizedBox(height: 12),
            Text(t.myQrCodeHint, textAlign: TextAlign.center),
          ],
        ),
      ),
      actions: [TextButton(onPressed: () => Navigator.pop(context), child: Text(t.close))],
    ),
  );
}

/// Ouvre la caméra et renvoie le contenu du premier QR code Staff Flow lu,
/// ou `null` si l'utilisateur abandonne.
Future<String?> scanQrCode(BuildContext context) =>
    Navigator.of(context).push<String>(MaterialPageRoute(builder: (_) => const _ScannerPage()));

class _ScannerPage extends StatefulWidget {
  const _ScannerPage();

  @override
  State<_ScannerPage> createState() => _ScannerPageState();
}

class _ScannerPageState extends State<_ScannerPage> {
  bool _done = false;
  bool _wrongCode = false;

  void _onDetect(BarcodeCapture capture) {
    if (_done) return;
    for (final code in capture.barcodes) {
      final value = code.rawValue;
      if (value == null) continue;
      if (_publicId.hasMatch(value.toUpperCase())) {
        _done = true;
        Navigator.pop(context, value);
        return;
      }
      if (!_wrongCode) setState(() => _wrongCode = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = context.l10n;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: Text(t.scanQrCode)),
      body: Stack(
        fit: StackFit.expand,
        children: [
          MobileScanner(
            onDetect: _onDetect,
            errorBuilder: (context, error) => Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(t.cameraUnavailable(error.errorCode.name),
                    textAlign: TextAlign.center, style: const TextStyle(color: Colors.white)),
              ),
            ),
          ),
          // Cadre de visée.
          Center(
            child: Container(
              width: 240,
              height: 240,
              decoration: BoxDecoration(
                border: Border.all(color: Brand.cyan, width: 4),
                borderRadius: BorderRadius.circular(24),
              ),
            ),
          ),
          Positioned(
            left: 16,
            right: 16,
            bottom: 32,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(12)),
              child: Text(_wrongCode ? t.qrInvalid : t.scanQrHint,
                  textAlign: TextAlign.center, style: const TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}

/// Saisie d'un nom. Renvoie le nom saisi, `''` pour revenir au nom
/// d'origine ([resetLabel]), ou `null` si l'utilisateur annule.
Future<String?> askName(
  BuildContext context, {
  required String title,
  required String current,
  required String hint,
  required String resetLabel,
  bool canReset = true,
}) {
  final t = context.l10n;
  // Texte sélectionné : on tape directement le nouveau nom.
  final name = TextEditingController(text: current)
    ..selection = TextSelection(baseOffset: 0, extentOffset: current.length);
  return showDialog<String>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: name,
            autofocus: true,
            maxLength: 120,
            textCapitalization: TextCapitalization.words,
            decoration: InputDecoration(labelText: t.name),
            onSubmitted: (v) => Navigator.pop(context, v.trim()),
          ),
          Text(hint, style: Theme.of(context).textTheme.bodySmall),
        ],
      ),
      actions: [
        if (canReset) TextButton(onPressed: () => Navigator.pop(context, ''), child: Text(resetLabel)),
        TextButton(onPressed: () => Navigator.pop(context), child: Text(t.cancel)),
        FilledButton(
          onPressed: () {
            if (name.text.trim().isNotEmpty) Navigator.pop(context, name.text.trim());
          },
          child: Text(t.save),
        ),
      ],
    ),
  );
}
