import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

@immutable
class AppColorsExtension extends ThemeExtension<AppColorsExtension> {
  const AppColorsExtension({
    required this.background,
    required this.surface,
    required this.primary,
    required this.onBackground,
    required this.hintText,
    required this.onSurface,
  });

  final Color? background;
  final Color? surface;
  final Color? primary;
  final Color? onBackground;
  final Color? hintText;
  final Color? onSurface;

  @override
  ThemeExtension<AppColorsExtension> copyWith({
    Color? background,
    Color? surface,
    Color? primary,
    Color? onBackground,
    Color? hintText,
    Color? onSurface,
  }) {
    return AppColorsExtension(
      background: background ?? this.background,
      surface: surface ?? this.surface,
      primary: primary ?? this.primary,
      onBackground: onBackground ?? this.onBackground,
      hintText: hintText ?? this.hintText,
      onSurface: onSurface ?? this.onSurface,
    );
  }

  @override
  ThemeExtension<AppColorsExtension> lerp(
    covariant ThemeExtension<AppColorsExtension>? other,
    double t,
  ) {
    if (other is! AppColorsExtension) {
      return this;
    }
    return AppColorsExtension(
      background: Color.lerp(background, other.background, t),
      surface: Color.lerp(surface, other.surface, t),
      primary: Color.lerp(primary, other.primary, t),
      onBackground: Color.lerp(onBackground, other.onBackground, t),
      hintText: Color.lerp(hintText, other.hintText, t),
      onSurface: Color.lerp(onSurface, other.onSurface, t),
    );
  }
}

const _darkAppColors = AppColorsExtension(
  background: Color(0xFF1E1E1E),
  surface: Color(0xFF2A2D3A),
  primary: Color(0xFF00BFFF),
  onBackground: Color(0xFFF5F5F5),
  hintText: Color(0xFF888888),
  onSurface: Color(0xFFF5F5F5),
);

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: _darkAppColors.background,
  colorScheme: ColorScheme.dark(
    surface: _darkAppColors.surface!,
    primary: _darkAppColors.primary!,
    onSurface: _darkAppColors.onSurface!,
  ),

  textTheme: GoogleFonts.jetBrainsMonoTextTheme(ThemeData.dark().textTheme)
      .copyWith(
        displayLarge: const TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
        ),
        headlineMedium: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
        ),
        titleLarge: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        titleMedium: const TextStyle(fontSize: 16),
        bodyLarge: const TextStyle(fontSize: 16),
        bodyMedium: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
        ),
        labelLarge: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
      ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: _darkAppColors.primary,
      foregroundColor: _darkAppColors.background,
      minimumSize: const Size(double.infinity, 56),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: _darkAppColors.surface,
    hintStyle: TextStyle(color: _darkAppColors.hintText),
    border: InputBorder.none,
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: _darkAppColors.primary!, width: 1.5),
    ),
  ),
  extensions: const <ThemeExtension<dynamic>>[_darkAppColors],
);
