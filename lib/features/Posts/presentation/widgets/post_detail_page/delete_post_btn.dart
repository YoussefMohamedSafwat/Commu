import 'package:cleanarch/core/theming/text_styles.dart';
import 'package:cleanarch/core/theming/app_theme_extension.dart';
import 'package:cleanarch/core/util/snackbar_message.dart';
import 'package:cleanarch/core/widgets/loading_widget.dart';
import 'package:cleanarch/features/Posts/presentation/blocs/add_delete_update/bloc/add_delete_update_bloc.dart';
import 'package:cleanarch/features/Posts/presentation/widgets/post_detail_page/delete_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class DeletePostBtn extends StatelessWidget {
  final int postId;
  const DeletePostBtn({super.key, required this.postId});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: context.elevatedbuttonstyle.copyWith(
        backgroundColor: WidgetStatePropertyAll(context.deleteBtnColor),
      ),
      onPressed: () => deleteDialog(context, postId),
      icon: Icon(Icons.delete_outline),

      label: Text("Delete", style: context.buttonTextStyle),
    );
  }

  void deleteDialog(BuildContext context, int postId) {
    showDialog(
      context: context,
      builder: (context) {
        return BlocConsumer<AddDeleteUpdateBloc, AddDeleteUpdateState>(
          listener: (context, state) {
            if (state is AddDeleteUpdateMessage) {
              SnackBarMessage().showSuccessSnackBar(
                message: state.message,
                context: context,
              );

              context.goNamed("posts");
            } else if (state is AddDeleteUpdateError) {
              context.pop();
              SnackBarMessage().showErrorSnackBar(
                message: state.message,
                context: context,
              );
            }
          },
          builder: (context, state) {
            if (state is AddDeleteUpdateLoading) {
              return AlertDialog(title: LoadingWidget());
            }
            return DeleteDialogWidget(postId: postId);
          },
        );
      },
    );
  }
}
