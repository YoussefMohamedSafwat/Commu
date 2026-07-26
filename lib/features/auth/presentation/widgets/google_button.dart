import 'package:cleanarch/core/theming/app_theme_extension.dart';
import 'package:cleanarch/features/auth/presentation/blocs/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GoogleButton extends StatelessWidget {
  final double parentWidth;
  const GoogleButton({super.key, required this.parentWidth});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: parentWidth,
      child: OutlinedButton.icon(
        onPressed: () {
          context.read<AuthBloc>().add(GoogleLoginEvent());
          if (!context.mounted) return;
        },
        icon: SvgPicture.asset(
          'assets/images/google.svg',
          width: 24,
          height: 24,
        ),
        label: Text(
          "Sign in with Google",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: context.textPrimaryColor,
          ),
        ),
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 14),
          backgroundColor: context.isDark
              ? Colors.white.withValues(alpha: 0.05)
              : Colors.white.withValues(alpha: 0.5),
          side: BorderSide(
            color: context.isDark
                ? Colors.white.withValues(alpha: 0.1)
                : const Color(0xFFE2E8F0),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }
}
