import 'package:dev_jot/features/app/widgets/gap.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator(),
          const Gap(height: 8),
          Text('Loading...', style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
}
