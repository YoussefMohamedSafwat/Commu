import 'package:cleanarch/core/util/snackbar_message.dart';
import 'package:cleanarch/core/widgets/loading_widget.dart';
import 'package:cleanarch/features/Posts/domain/entities/posts.dart';
import 'package:cleanarch/features/Posts/presentation/blocs/add_delete_update/bloc/add_delete_update_bloc.dart';
import 'package:cleanarch/features/Posts/presentation/widgets/add_update_page/form_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AddPostUpdatePage extends StatelessWidget {
  final Posts? post;

  const AddPostUpdatePage({super.key, this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _buildappbar(), body: _buildbody());
  }

  AppBar _buildappbar() {
    return AppBar(title: Text(post != null ? "Edit Post" : "Add Post"));
  }

  Widget _buildbody() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: BlocConsumer<AddDeleteUpdateBloc, AddDeleteUpdateState>(
          listener: (context, state) {
            if (state is AddDeleteUpdateMessage) {
              SnackBarMessage().showSuccessSnackBar(
                message: state.message,
                context: context,
              );
              context.goNamed("posts");
            } else if (state is AddDeleteUpdateError) {
              SnackBarMessage().showErrorSnackBar(
                message: state.message,
                context: context,
              );
            }
          },
          builder: (context, state) {
            if (state is AddDeleteUpdateLoading) {
              return LoadingWidget();
            }

            return FormWidget(post: post ?? post);
          },
        ),
      ),
    );
  }
}
