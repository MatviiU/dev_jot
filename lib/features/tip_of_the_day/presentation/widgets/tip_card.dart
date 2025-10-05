import 'package:dev_jot/core/theme/app_theme.dart';
import 'package:dev_jot/features/app/widgets/gap.dart';
import 'package:dev_jot/features/app/widgets/splash_screen.dart';
import 'package:dev_jot/features/tip_of_the_day/presentation/cubit/tip_cubit.dart';
import 'package:dev_jot/features/tip_of_the_day/presentation/cubit/tip_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class TipCard extends StatelessWidget {
  const TipCard({super.key});

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context).extension<AppColorsExtension>()!;
    final textTheme = Theme.of(context).textTheme;
    return BlocBuilder<TipCubit, TipState>(
      builder: (context, state) {
        return switch (state) {
          TipInitial() || TipLoading() => const SplashScreen(),
          TipLoaded() => Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: appTheme.surface,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PhosphorIcon(
                  PhosphorIcons.lightbulb(PhosphorIconsStyle.fill),
                  color: appTheme.primary,
                  size: 24,
                ),
                const Gap(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Tip of the day',
                        style: textTheme.labelLarge?.copyWith(
                          color: appTheme.hintText,
                        ),
                      ),
                      const Gap(height: 4),
                      Text(
                        state.tip.text,
                        style: textTheme.bodyMedium?.copyWith(
                          color: appTheme.onSurface,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          TipFailure() => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              PhosphorIcon(
                PhosphorIcons.warningCircle(PhosphorIconsStyle.regular),
                color: appTheme.error,
              ),
              const Gap(width: 8),
              Text(
                state.message,
                style: textTheme.bodyMedium?.copyWith(color: appTheme.hintText),
              ),
            ],
          ),
        };
      },
    );
  }
}
