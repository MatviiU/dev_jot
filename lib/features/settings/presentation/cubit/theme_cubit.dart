import 'package:dev_jot/features/settings/domain/repositories/settings_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit({required SettingsRepository settingsRepository})
    : _settingsRepository = settingsRepository,
      super(ThemeMode.dark) {
    _loadTheme();
  }

  final SettingsRepository _settingsRepository;

  Future<void> _loadTheme() async {
    final themeMode = await _settingsRepository.loadThemeMode();
    emit(themeMode == 'light' ? ThemeMode.light : ThemeMode.dark);
  }

  Future<void> setTheme(ThemeMode themeMode) async {
    await _settingsRepository.saveThemeMode(
      themeMode == ThemeMode.light ? 'light' : 'dark',
    );
    emit(themeMode);
  }
}
