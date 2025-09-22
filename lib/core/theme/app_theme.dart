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
    required this.onPrimary,
    required this.error,
    required this.onError,
  });

  final Color? background;
  final Color? surface;
  final Color? primary;
  final Color? onBackground;
  final Color? hintText;
  final Color? onSurface;
  final Color? onPrimary;
  final Color? error;
  final Color? onError;

  @override
  ThemeExtension<AppColorsExtension> copyWith({
    Color? background,
    Color? surface,
    Color? primary,
    Color? onBackground,
    Color? hintText,
    Color? onSurface,
    Color? onPrimary,
    Color? error,
    Color? onError,
  }) {
    return AppColorsExtension(
      background: background ?? this.background,
      surface: surface ?? this.surface,
      primary: primary ?? this.primary,
      onBackground: onBackground ?? this.onBackground,
      hintText: hintText ?? this.hintText,
      onSurface: onSurface ?? this.onSurface,
      onPrimary: onPrimary ?? this.onPrimary,
      error: error ?? this.error,
      onError: onError ?? this.onError,
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
      onPrimary: Color.lerp(onPrimary, other.onPrimary, t),
      error: Color.lerp(error, other.error, t),
      onError: Color.lerp(onError, other.onError, t),
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
  onPrimary: Color(0xFF1E1E1E),
  error: Color(0xFFFFB4AB),
  onError: Color(0xFF690005),
);

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: _darkAppColors.background,
  colorScheme: ColorScheme.dark(
    surface: _darkAppColors.surface!,
    primary: _darkAppColors.primary!,
    onPrimary: _darkAppColors.onPrimary!,
    onSurface: _darkAppColors.onSurface!,
    error: _darkAppColors.error!,
    onError: _darkAppColors.onError!,
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
