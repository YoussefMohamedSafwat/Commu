import 'package:cleanarch/features/Posts/domain/entities/posts.dart';
import 'package:cleanarch/features/Posts/presentation/blocs/add_delete_update/bloc/add_delete_update_bloc.dart';
import 'package:cleanarch/features/Posts/presentation/widgets/add_update_page/form_submit_btn.dart';
import 'package:cleanarch/features/Posts/presentation/widgets/add_update_page/text_form_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FormWidget extends StatefulWidget {
  final Posts? post;
  const FormWidget({super.key, this.post});

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();

  @override
  void initState() {
    if (widget.post != null) {
      _titleController.text = widget.post!.title;
      _bodyController.text = widget.post!.body;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextFormFieldWidget(
            name: "Title",
            multiLines: false,
            controller: _titleController,
          ),
          TextFormFieldWidget(
            name: "Body",
            multiLines: true,
            controller: _bodyController,
          ),
          FormSubmitBtn(
            label: widget.post == null ? "Add" : "Edit",
            icon: widget.post == null ? Icon(Icons.add) : Icon(Icons.edit),
            onPressed: validateFormThenUpdateOrAddPost,
          ),
        ],
      ),
    );
  }

  void validateFormThenUpdateOrAddPost() {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      final post = Posts(
        id: widget.post!.id,
        title: _titleController.text,
        body: _bodyController.text,
        tags: widget.post?.tags ?? [],
        views: widget.post?.views ?? 0,
        userId: widget.post?.userId ?? 0,
      );

      if (widget.post != null) {
        BlocProvider.of<AddDeleteUpdateBloc>(context).add(UpdateEvent(post));
      } else {
        BlocProvider.of<AddDeleteUpdateBloc>(context).add(AddEvent(post));
      }
    }
  }
}
