import 'package:cleanarch/core/theming/text_styles.dart';
import 'package:cleanarch/core/widgets/loading_widget.dart';
import 'package:cleanarch/features/Posts/domain/entities/posts.dart';
import 'package:cleanarch/features/Posts/presentation/blocs/add_delete_update/bloc/add_delete_update_bloc.dart';
import 'package:cleanarch/features/Posts/presentation/widgets/add_update_page/form_submit_btn.dart';
import 'package:cleanarch/features/Posts/presentation/widgets/add_update_page/form_widget.dart'
    show FormWidget, FormWidgetState;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AddPostUpdatePage extends StatefulWidget {
  final Posts? post;

  const AddPostUpdatePage({super.key, this.post});

  @override
  State<AddPostUpdatePage> createState() => _AddPostUpdatePageState();
}

class _AddPostUpdatePageState extends State<AddPostUpdatePage> {
  final _formWidgetKey = GlobalKey<FormWidgetState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _buildappbar(context), body: _buildbody());
  }

  AppBar _buildappbar(BuildContext context) {
    return AppBar(
      title: Text(
        widget.post != null ? "Edit Post" : "Create Post",
        style: context.appBarTextStyle,
      ),
      actionsPadding: EdgeInsetsGeometry.symmetric(
        horizontal: 20,
        vertical: 7.5,
      ),
      actions: [
        FormSubmitBtn(
          onPressed: () => _formWidgetKey.currentState?.submitForm(),
          label: widget.post == null ? "Create" : "Edit",
        ),
      ],
    );
  }

  Widget _buildbody() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: BlocConsumer<AddDeleteUpdateBloc, AddDeleteUpdateState>(
          listener: (context, state) {
            if (state is AddDeleteUpdateMessage) {
              context.goNamed("posts");
            }
          },
          builder: (context, state) {
            if (state is AddDeleteUpdateLoading) {
              return LoadingWidget();
            }

            return FormWidget(key: _formWidgetKey, post: widget.post);
          },
        ),
      ),
    );
  }
}
