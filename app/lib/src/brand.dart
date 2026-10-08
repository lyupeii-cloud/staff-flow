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
