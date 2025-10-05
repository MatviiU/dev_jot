abstract interface class SettingsRepository {
  Future<void> saveThemeMode(String themeMode);

  Future<String> loadThemeMode();
}
