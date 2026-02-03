

import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:cleanarch/core/constants/app_sizes.dart';
import 'package:cleanarch/core/theming/colors.dart';
import 'package:cleanarch/core/theming/cubit/theme_cubit_cubit.dart';
import 'package:cleanarch/core/theming/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SwitchThemeWidget extends StatelessWidget {
  const SwitchThemeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, newMode) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text (newMode == ThemeMode.light ? 'Light Mode' 
              : 'Dark Mode', style: AppTextStyle.normalText),
            AnimatedToggleSwitch.dual(
              current: newMode,
              first: ThemeMode.light,
              second: ThemeMode.dark,
              spacing: AppSizes.s8,
              style: const ToggleStyle(
                borderColor: Colors.transparent,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: Offset(0, 1.5),
                  ),
                ],
              ),
              borderWidth: 5.0,
              height: 40,
              onChanged: (mode) => context.read<ThemeCubit>().changeTheme(mode),
              iconBuilder: (mode) => mode == ThemeMode.light
                  ? const Icon(Icons.sunny, color: Colors.white)
                  : const Icon(Icons.dark_mode, color: Colors.white),
              styleBuilder: (mode) => ToggleStyle(
                indicatorColor: AppColors.primaryColor,
                backgroundColor: mode == ThemeMode.light ? Colors.white : Colors.blueGrey,
              ),
            ),
          ],
        );
      },
    );
  }
}
