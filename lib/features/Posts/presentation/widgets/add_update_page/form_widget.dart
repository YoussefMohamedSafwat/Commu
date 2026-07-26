import 'package:cleanarch/core/cubit/current_user_cubit.dart';
import 'package:cleanarch/core/theming/app_theme.dart';
import 'package:cleanarch/core/util/image_picker_handler.dart';
import 'package:cleanarch/core/util/post_image.dart';
import 'package:cleanarch/core/util/snackbar_message.dart';
import 'package:cleanarch/core/widgets/dashed_image.dart';
import 'package:cleanarch/features/Posts/domain/entities/posts.dart';
import 'package:cleanarch/features/Posts/presentation/blocs/add_delete_update/bloc/add_delete_update_bloc.dart';
import 'package:cleanarch/features/Posts/presentation/widgets/add_update_page/text_form_field_widget.dart';
import 'package:cleanarch/features/Posts/presentation/widgets/tags/tags_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class FormWidgetController {
  void submitForm();
}

class FormWidget extends StatefulWidget {
  final Posts? post;
  const FormWidget({super.key, this.post});

  @override
  State<FormWidget> createState() => FormWidgetState();
}

class FormWidgetState extends State<FormWidget>
    implements FormWidgetController {
  List<String> _tags = [];
  List<PostImage> _images = [];
  late final GlobalKey<FormState> _formKey;
  late final TextEditingController _titleController;
  late final TextEditingController _bodyController;

  @override
  void submitForm() => validateFormThenUpdateOrAddPost(context);

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    _titleController = TextEditingController();
    _bodyController = TextEditingController();
    if (widget.post != null) {
      _titleController.text = widget.post!.title;
      _bodyController.text = widget.post!.body;
      _tags = widget.post?.tags ?? [];
      _images = (widget.post?.imagesUrl ?? [])
          .map((url) => PostImage.remote(url))
          .toList();
    }
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsetsGeometry.all(12),
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Column(
            spacing: 30,
            children: [
              SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Whats on your mind today?",
                  style: context.titleText,
                ),
              ),
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
              DashedImage(
                images: _images,
                onTap: _onTap,
                onRemove: _removeImage,
              ),
              TagsContainer(
                initialTags: _tags,
                onTagsChanged: (tags) => _tags = tags,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _removeImage(PostImage image) {
    setState(() {
      _images.remove(image);
    });
  }

  void _onTap() async {
    final returnedImages = await ImagePickerHandler.pickMultiImage(
      context: context,
    );
    if (returnedImages != null) {
      debugPrint("image returned : ${returnedImages[0].path}");
      setState(() {
        _images.addAll(returnedImages.map((image) => PostImage.local(image)));
      });
    }
  }

  void validateFormThenUpdateOrAddPost(BuildContext context) {
    if (_titleController.text.trim().isEmpty &&
        _bodyController.text.trim().isEmpty) {
      SnackBarMessage().showErrorSnackBar(
        message: "At least title or body must not be empty",
        context: context,
      );
      return;
    }

    final currentUser = context.read<CurrentUserCubit>().state;
    debugPrint("currentuser cubit : $currentUser");

    if (widget.post != null) {
      BlocProvider.of<AddDeleteUpdateBloc>(context).add(
        UpdateEvent(
          existingPost: widget.post!,
          title: _titleController.text,
          body: _bodyController.text,
          tags: _tags,
          images: _images,
        ),
      );
    } else {
      BlocProvider.of<AddDeleteUpdateBloc>(context).add(
        AddEvent(
          title: _titleController.text,
          body: _bodyController.text,
          tags: _tags,
          images: _images,
          userId: currentUser!.id,
        ),
      );
    }
  }
}
