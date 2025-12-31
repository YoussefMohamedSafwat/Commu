import 'package:cleanarch/core/constants/app_sizes.dart';
import 'package:cleanarch/core/theming/text_styles.dart';
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
    return Padding(
      // Use the same horizontal padding as your AuthField widgets
      padding: EdgeInsets.symmetric(horizontal: widget.parentWidth * 0.1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Checkbox(
                value: context.watch<RememberMeCubit>().state,
                onChanged: (bool? value) =>
                    context.read<RememberMeCubit>().toggle(value ?? false),
              ),
              Text(
                "Remember me",
                style: AppTextStyle.subTitleText.copyWith(
                  fontSize: AppSizes.s12,
                ),
              ),
            ],
          ),
          InkWell(
            onTap: () {},
            child: Text(
              "Forgot password?",
              style: AppTextStyle.subTitleText.copyWith(fontSize: AppSizes.s12),
            ),
          ),
        ],
      ),
    );
  }
}
