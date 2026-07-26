import 'package:cleanarch/core/theming/app_theme_extension.dart';
import 'package:cleanarch/features/auth/presentation/blocs/cubit/remember_me_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RememberMeWidget extends StatefulWidget {
  final double parentWidth;
  const RememberMeWidget({super.key, required this.parentWidth});

  @override
  State<RememberMeWidget> createState() => _RememberMeWidgetState();
}

class _RememberMeWidgetState extends State<RememberMeWidget> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 20,
            width: 20,
            child: Checkbox(
              value: context.watch<RememberMeCubit>().state,
              onChanged: (bool? value) =>
                  context.read<RememberMeCubit>().toggle(value ?? false),
              side: BorderSide(
                color: context.isDark
                    ? Colors.white.withValues(alpha: 0.2)
                    : const Color(0xFFE2E8F0),
                width: 1.5,
              ),
              fillColor: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.selected)) {
                  return context.primaryColor;
                }
                return Colors.transparent;
              }),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            "Remember me",
            style: TextStyle(fontSize: 13, color: context.textSecondaryColor),
          ),
        ],
      ),
    );
  }
}
