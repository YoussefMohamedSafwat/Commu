import 'package:cleanarch/core/constants/app_sizes.dart';
import 'package:cleanarch/core/theming/app_theme.dart';
import 'package:cleanarch/core/util/confirm_dialog.dart';
import 'package:cleanarch/features/Posts/presentation/blocs/add_delete_update/bloc/add_delete_update_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class PostDropDown extends StatelessWidget {
  final int postId;
  const PostDropDown({super.key, required this.postId});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      icon: Icon(Icons.more_horiz, size: AppSizes.s24),
      offset: const Offset(0, 40),
      color: context.surfaceColor,
      surfaceTintColor: Colors.transparent,
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      onSelected: (value) {
        if (value == 0) {
          context.pushNamed(
            'editpost',
            pathParameters: {'id': postId.toString()},
          );
        } else if (value == 1) {
          _handleDelete(context, postId);
        }
      },
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 0,
          child: Row(
            children: [
              Icon(Icons.edit, color: AppColors.primary, size: 20),
              const SizedBox(width: 12),
              Text("Edit Post", style: context.normalText),
            ],
          ),
        ),
        const PopupMenuDivider(),
        PopupMenuItem(
          value: 1,
          child: Row(
            children: [
              Icon(Icons.delete, color: AppColors.deleteBtnColor, size: 20),
              const SizedBox(width: 12),
              Text("Delete Post", style: context.normalText),
            ],
          ),
        ),
      ],
    );
  }

  void _handleDelete(BuildContext context, int postID) async {
    final confirm = await openConfirmDialog(
      context,
      "are you sure you want to delete this message?",
    );
    if (confirm && context.mounted) {
      context.read<AddDeleteUpdateBloc>().add(DeleteEvent(postID));
    }
  }
}
