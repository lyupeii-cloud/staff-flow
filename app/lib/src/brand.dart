import 'package:flutter/material.dart';

/// Couleurs et lettrage de l'icône Staff Flow.
class Brand {
  static const navy = Color(0xFF061440);
  static const navyLight = Color(0xFF0B2160);
  static const blue = Color(0xFF1A8CFC);
  static const sky = Color(0xFF29AEFE);
  static const cyan = Color(0xFF2DEDD5);

  /// Dégradé du mot « Flow » et de la flèche.
  static const flow = LinearGradient(colors: [blue, sky, cyan], stops: [0, 0.45, 1]);

  /// Nunito très gras, comme le texte de l'icône.
  static TextStyle display(double size, {Color color = Colors.white}) => TextStyle(
    fontFamily: 'Nunito',
    fontSize: size,
    fontWeight: FontWeight.w900,
    fontVariations: const [FontVariation('wght', 900)],
    letterSpacing: -0.5,
    height: 1.1,
    color: color,
  );

  static ThemeData theme(Brightness brightness) {
    final dark = brightness == Brightness.dark;
    final scheme = ColorScheme.fromSeed(
      seedColor: blue,
      brightness: brightness,
      primary: dark ? sky : blue,
      tertiary: dark ? cyan : const Color(0xFF00897B),
      // Bannières (modifications à publier…) : turquoise de la flèche, adouci.
      tertiaryContainer: dark ? const Color(0xFF0E3B45) : const Color(0xFFD5F7F2),
      onTertiaryContainer: dark ? const Color(0xFFCFFAF3) : navy,
    );
    return ThemeData(
      colorScheme: scheme,
      fontFamily: 'Nunito',
      appBarTheme: const AppBarTheme(
        backgroundColor: navy,
        foregroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
      ),
      tabBarTheme: const TabBarThemeData(
        labelColor: Colors.white,
        unselectedLabelColor: Color(0xB3FFFFFF),
        indicatorColor: cyan,
        dividerColor: Colors.transparent,
        labelStyle: TextStyle(fontFamily: 'Nunito', fontWeight: FontWeight.w800),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: blue,
        foregroundColor: Colors.white,
      ),
    );
  }
}

/// « Staff » en blanc et « Flow » en dégradé bleu → turquoise, précédé du logo.
class BrandTitle extends StatelessWidget {
  final double size;
  final bool showLogo;

  const BrandTitle({super.key, this.size = 24, this.showLogo = true});

  @override
  Widget build(BuildContext context) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      if (showLogo) ...[
        Image.asset('assets/brand/logo-mark.png', height: size * 1.35, filterQuality: FilterQuality.medium),
        SizedBox(width: size * 0.35),
      ],
      Text('Staff', style: Brand.display(size)),
      ShaderMask(
        blendMode: BlendMode.srcIn,
        shaderCallback: (bounds) => Brand.flow.createShader(bounds),
        child: Text('Flow', style: Brand.display(size)),
      ),
    ],
  );
}

/// Sur un grand écran (site web), l'application devient une colonne centrée
/// d'environ 60 % de la largeur, entre 900 et 1100 points, posée sur le fond
/// bleu nuit de la marque : plus agréable à lire qu'une page étirée d'un bord
/// à l'autre. Sur un téléphone, rien ne change.
class FramedApp extends StatelessWidget {
  final Widget child;

  const FramedApp({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final width = media.size.width;
    if (width <= 1000) return child;
    final inner = (width * 0.6).clamp(900.0, 1100.0);
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Brand.navy, Color(0xFF0B2A6B)],
        ),
      ),
      child: Center(
        child: Container(
          width: inner,
          decoration: const BoxDecoration(
            boxShadow: [BoxShadow(color: Color(0x66000000), blurRadius: 32)],
          ),
          // Les écrans calculent leurs tailles sur la colonne, pas sur la fenêtre.
          child: MediaQuery(
            data: media.copyWith(size: Size(inner, media.size.height)),
            child: child,
          ),
        ),
      ),
    );
  }
}
