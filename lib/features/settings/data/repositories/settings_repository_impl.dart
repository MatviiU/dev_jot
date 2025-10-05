import 'package:dev_jot/features/settings/domain/repositories/settings_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  const SettingsRepositoryImpl({required SharedPreferences sharedPreferences})
    : _sharedPreferences = sharedPreferences;

  final SharedPreferences _sharedPreferences;

  @override
  Future<String> loadThemeMode() async{
    final themeMode = _sharedPreferences.getString('theme_mode');
    return themeMode ?? 'dark';
  }

  @override
  Future<void> saveThemeMode(String themeMode) async {
    await _sharedPreferences.setString('theme_mode', themeMode);
  }
}
