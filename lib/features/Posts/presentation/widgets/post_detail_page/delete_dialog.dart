import 'package:cleanarch/features/Posts/presentation/blocs/add_delete_update/bloc/add_delete_update_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeleteDialogWidget extends StatelessWidget {
  final int postId;
  const DeleteDialogWidget({super.key, required this.postId});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Are you Sure ?"),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text("No"),
        ),
        TextButton(
          onPressed: () {
            BlocProvider.of<AddDeleteUpdateBloc>(
              context,
            ).add(DeleteEvent(postId));
          },
          child: Text("Yes"),
        ),
      ],
    );
  }
}
