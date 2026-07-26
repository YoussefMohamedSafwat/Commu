import 'package:cleanarch/core/theming/app_theme_extension.dart';
import 'package:cleanarch/core/theming/text_styles.dart';
import 'package:cleanarch/features/Reacts/presentation/cubit/react_cubit.dart';
import 'package:cleanarch/features/Reacts/presentation/cubit/react_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReactContainer extends StatelessWidget {
  final int postId;
  const ReactContainer({super.key, required this.postId});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        BlocSelector<ReactCubit, ReactState, bool>(
          selector: (state) => state.likedByMe.contains(postId),
          builder: (context, liked) => IconButton(
            onPressed: () => context.read<ReactCubit>().toggle(postId),
            icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation) =>
                  ScaleTransition(scale: animation, child: child),
              switchInCurve: Curves.elasticOut,
              switchOutCurve: Curves.easeOut,
              child: Icon(
                liked ? Icons.favorite : Icons.favorite_border_outlined,
                key: ValueKey<bool>(liked),
                color: liked ? Colors.red : context.iconBtnColor,
                size: 25,
              ),
            ),
          ),
        ),

        BlocSelector<ReactCubit, ReactState, int>(
          selector: (state) => state.reactCounts[postId] ?? 0,
          builder: (context, counts) {
            return Text(
              counts.toString(),
              style: context.subTitleText.copyWith(fontSize: 16),
            );
          },
        ),
      ],
    );
  }
}
