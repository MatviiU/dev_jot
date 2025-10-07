import 'package:dev_jot/features/settings/presentation/widgets/appearance_settings.dart';
import 'package:dev_jot/features/settings/presentation/widgets/settings_app_bar.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(appBar: SettingsAppBar(), body: AppearanceSettings());
  }
}
