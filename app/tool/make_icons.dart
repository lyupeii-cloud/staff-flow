// ignore_for_file: avoid_print
// Génère les icônes de l'application à partir de assets/brand/icon-source.webp.
// Lancer depuis app/ : dart run tool/make_icons.dart
// puis : dart run flutter_launcher_icons   (icônes Android)
import 'dart:io';
import 'dart:math';

import 'package:image/image.dart' as img;

// Repères mesurés sur l'image source (1254 × 1254).
const _square = (x: 58, y: 51, size: 1144); // carré arrondi bleu nuit, 3 px à l'intérieur du bord clair
const _inner = (x: 147, y: 137, size: 960); // intérieur sans les coins arrondis
const _mark = (x: 215, y: 125, w: 880, h: 690); // calendrier + personnes + flèche, sans le texte

void main() {
  final src = img.decodeWebP(File('assets/brand/icon-source.webp').readAsBytesSync())!;

  // Carré arrondi, coins transparents : favicon et icônes web.
  final rounded = _roundCorners(
      img.copyResize(img.copyCrop(src, x: _square.x, y: _square.y, width: _square.size, height: _square.size),
          width: 1024, height: 1024, interpolation: img.Interpolation.cubic),
      radius: 262); // rayon des coins de la source : ≈ 290 px, soit 258 à cette échelle
  _save('assets/brand/icon-rounded.png', rounded);

  // Plein cadre bleu nuit : icône Android d'avant la version 8 (sans découpe en cercle).
  final full = img.copyResize(img.copyCrop(src, x: _inner.x, y: _inner.y, width: _inner.size, height: _inner.size),
      width: 1024, height: 1024, interpolation: img.Interpolation.cubic);
  _save('assets/brand/icon-full.png', full);

  // Icône adaptative Android : le dessin tient dans la zone sûre (cercle de 61 %). Le fond reprend le
  // dégradé bleu nuit de l'image, et les bords du dessin sont fondus pour ne pas marquer de cadre.
  // Les coins du texte doivent rester dans le cercle sûr (diamètre 626 sur 1024) : 500 px.
  const side = 500, inset = (1024 - side) ~/ 2;
  final fg = img.Image(width: 1024, height: 1024, numChannels: 4)..clear(img.ColorRgba8(0, 0, 0, 0));
  img.compositeImage(
      fg, _featherEdges(img.copyResize(full, width: side, height: side, interpolation: img.Interpolation.cubic), 14),
      dstX: inset, dstY: inset);
  _save('assets/brand/icon-foreground.png', fg);
  final bg = _background(full, inset: inset, side: side);
  _save('assets/brand/icon-background.png', bg);
  // Même composition pour les icônes web « maskable », elles aussi découpées en cercle.
  final maskable = img.compositeImage(img.Image.from(bg), fg);

  // Logo sans le texte, pour l'en-tête et l'écran de connexion (fond bleu nuit).
  _save('assets/brand/logo-mark.png',
      img.copyResize(img.copyCrop(src, x: _mark.x, y: _mark.y, width: _mark.w, height: _mark.h),
          width: 430, interpolation: img.Interpolation.cubic));

  // Web.
  for (final s in [192, 512]) {
    _save('web/icons/Icon-$s.png', img.copyResize(rounded, width: s, height: s, interpolation: img.Interpolation.average));
    _save('web/icons/Icon-maskable-$s.png', img.copyResize(maskable, width: s, height: s, interpolation: img.Interpolation.average));
  }
  _save('web/favicon.png', img.copyResize(rounded, width: 64, height: 64, interpolation: img.Interpolation.average));
  print('Icônes générées.');
}

/// Rend transparents les pixels hors d'un carré aux coins arrondis (anticrénelé).
img.Image _roundCorners(img.Image im, {required double radius}) {
  final out = img.Image.from(im).convert(numChannels: 4);
  final w = out.width, h = out.height;
  for (var y = 0; y < h; y++) {
    for (var x = 0; x < w; x++) {
      final cx = x < radius ? radius : (x > w - 1 - radius ? w - 1 - radius : x.toDouble());
      final cy = y < radius ? radius : (y > h - 1 - radius ? h - 1 - radius : y.toDouble());
      final d = sqrt(pow(x - cx, 2) + pow(y - cy, 2));
      final a = (radius + 0.5 - d).clamp(0.0, 1.0);
      if (a < 1) out.getPixel(x, y).a = (out.getPixel(x, y).a * a).round();
    }
  }
  return out;
}

void _save(String path, img.Image im) {
  File(path)
    ..createSync(recursive: true)
    ..writeAsBytesSync(img.encodePng(im));
  print('  $path  ${im.width}×${im.height}');
}

/// Fond 1024 × 1024 : pour chaque ligne et colonne, la couleur moyenne du bord de [full],
/// prolongée au-delà de la zone où le dessin est posé.
img.Image _background(img.Image full, {required int inset, required int side}) {
  final scaled = img.copyResize(full, width: side, height: side, interpolation: img.Interpolation.average);
  final bg = img.Image(width: 1024, height: 1024);
  num at(int x, int y, int c) => scaled.getPixel(x.clamp(0, side - 1), y.clamp(0, side - 1))[c];
  for (var y = 0; y < 1024; y++) {
    for (var x = 0; x < 1024; x++) {
      // Point du bord le plus proche dans le dessin, moyenné sur quelques pixels pour lisser.
      final sx = (x - inset).clamp(0, side - 1), sy = (y - inset).clamp(0, side - 1);
      final rgb = [
        for (var c = 0; c < 3; c++)
          ([for (var d = -6; d <= 6; d += 3) at(sx + d, sy, c) + at(sx, sy + d, c)].reduce((a, b) => a + b) / 10).round(),
      ];
      bg.setPixelRgb(x, y, rgb[0], rgb[1], rgb[2]);
    }
  }
  return bg;
}

/// Rend les [width] derniers pixels du bord progressivement transparents.
img.Image _featherEdges(img.Image im, int width) {
  final out = img.Image.from(im).convert(numChannels: 4);
  for (var y = 0; y < out.height; y++) {
    for (var x = 0; x < out.width; x++) {
      final d = [x, y, out.width - 1 - x, out.height - 1 - y].reduce(min);
      if (d < width) out.getPixel(x, y).a = (255 * (d + 1) / (width + 1)).round();
    }
  }
  return out;
}
