import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HyperOSTheme {
  // Tipografía similar a MiSans de HyperOS
  static TextStyle _buildTextStyle({
    required double fontSize,
    required FontWeight fontWeight,
    required Color color,
    double? letterSpacing,
    double? height,
  }) {
    return GoogleFonts.inter(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      letterSpacing: letterSpacing,
      height: height,
    );
  }

  static ThemeData lightTheme(ColorScheme colorScheme) {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: colorScheme.copyWith(
        brightness: Brightness.light,
        primary: colorScheme.primary,
        surface: const Color(0xFFFAFAFA),
        surfaceContainer: const Color(0xFFF5F5F5),
      ),
      textTheme: _buildTextTheme(Brightness.light),
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.surface,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: _buildTextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: colorScheme.onSurface,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          elevation: 2,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          textStyle: _buildTextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: colorScheme.onPrimary,
          ),
        ),
      ),
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          foregroundColor: colorScheme.primary,
          highlightColor: colorScheme.primary.withOpacity(0.1),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
      sliderTheme: SliderThemeData(
        activeTrackColor: colorScheme.primary,
        inactiveTrackColor: colorScheme.primary.withOpacity(0.2),
        thumbColor: colorScheme.primary,
        trackHeight: 5,
        overlayColor: colorScheme.primary.withOpacity(0.2),
      ),
      cardTheme: CardThemeData(
        color: colorScheme.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }

  static ThemeData darkTheme(ColorScheme colorScheme) {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: colorScheme.copyWith(
        brightness: Brightness.dark,
        primary: _adjustColorForDark(colorScheme.primary),
        surface: const Color(0xFF1A1A1A),
        surfaceContainer: const Color(0xFF262626),
      ),
      textTheme: _buildTextTheme(Brightness.dark),
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.surface,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: _buildTextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: colorScheme.onSurface,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: _adjustColorForDark(colorScheme.primary),
          foregroundColor: colorScheme.onPrimary,
          elevation: 2,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          textStyle: _buildTextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: colorScheme.onPrimary,
          ),
        ),
      ),
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          foregroundColor: _adjustColorForDark(colorScheme.primary),
          highlightColor: _adjustColorForDark(colorScheme.primary).withOpacity(0.1),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
      sliderTheme: SliderThemeData(
        activeTrackColor: _adjustColorForDark(colorScheme.primary),
        inactiveTrackColor: _adjustColorForDark(colorScheme.primary).withOpacity(0.2),
        thumbColor: _adjustColorForDark(colorScheme.primary),
        trackHeight: 5,
        overlayColor: _adjustColorForDark(colorScheme.primary).withOpacity(0.2),
      ),
      cardTheme: CardThemeData(
        color: colorScheme.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }

  static TextTheme _buildTextTheme(Brightness brightness) {
    final textColor = brightness == Brightness.light
        ? const Color(0xFF1A1A1A)
        : const Color(0xFFFFFFFF);

    return TextTheme(
      displayLarge: _buildTextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        color: textColor,
        letterSpacing: -0.5,
      ),
      displayMedium: _buildTextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        color: textColor,
        letterSpacing: -0.5,
      ),
      displaySmall: _buildTextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: textColor,
      ),
      headlineLarge: _buildTextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: textColor,
      ),
      headlineMedium: _buildTextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: textColor,
      ),
      headlineSmall: _buildTextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: textColor,
      ),
      titleLarge: _buildTextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: textColor,
        letterSpacing: 0.15,
      ),
      titleMedium: _buildTextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: textColor,
        letterSpacing: 0.1,
      ),
      titleSmall: _buildTextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: textColor,
      ),
      bodyLarge: _buildTextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: textColor,
        letterSpacing: 0.15,
      ),
      bodyMedium: _buildTextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: textColor,
        letterSpacing: 0.25,
      ),
      bodySmall: _buildTextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: textColor.withOpacity(0.7),
        letterSpacing: 0.4,
      ),
      labelLarge: _buildTextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: textColor,
        letterSpacing: 0.1,
      ),
      labelMedium: _buildTextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: textColor,
        letterSpacing: 0.5,
      ),
      labelSmall: _buildTextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        color: textColor,
        letterSpacing: 0.5,
      ),
    );
  }

  // Aumentar saturación de colores para darles un look más vibrante como HyperOS
  static Color _adjustColorForDark(Color color) {
    final hslColor = HSLColor.fromColor(color);
    return hslColor
        .withSaturation((hslColor.saturation * 1.2).clamp(0, 1))
        .withLightness((hslColor.lightness * 1.15).clamp(0, 1))
        .toColor();
  }

  // Paleta de colores HyperOS predeterminada
  static const Color hyperOSBlue = Color(0xFF0077FF);
  static const Color hyperOSGreen = Color(0xFF00D084);
  static const Color hyperOSRed = Color(0xFFFF5A5A);
  static const Color hyperOSYellow = Color(0xFFFFD60A);
  static const Color hyperOSPurple = Color(0xFF9D5FFF);
  static const Color hyperOSPink = Color(0xFFFF6B9D);
}
