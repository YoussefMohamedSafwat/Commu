import 'dart:io';
import 'package:cleanarch/core/cubit/current_user_cubit.dart';
import 'package:cleanarch/core/theming/colors.dart';
import 'package:cleanarch/core/theming/text_styles.dart';
import 'package:cleanarch/core/util/image_picker_handler.dart';
import 'package:cleanarch/core/util/validators.dart';
import 'package:cleanarch/core/widgets/loading_widget.dart';
import 'package:cleanarch/features/user/presentation/blocs/bloc/user_bloc.dart';
import 'package:cleanarch/features/user/presentation/widgets/ink_well_container.dart';
import 'package:cleanarch/features/user/presentation/widgets/labeled_text.dart';
import 'package:cleanarch/features/user/presentation/widgets/profile_background.dart';
import 'package:cleanarch/features/user/presentation/widgets/profile_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:cleanarch/features/user/domain/entities/user.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late final GlobalKey<FormState> _formKey;
  late final TextEditingController _nameController;
  late final TextEditingController _usernameController;
  late final TextEditingController _bioController;
  late final User currentUser;
  File? _profileImage;
  File? _backgroundImage;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    currentUser = context.read<CurrentUserCubit>().state!;
    _nameController = TextEditingController(text: currentUser.name ?? "");
    _usernameController = TextEditingController(text: currentUser.username);
    _bioController = TextEditingController(text: currentUser.bio ?? "");
  }

  @override
  void dispose() {
    _nameController.dispose();
    _usernameController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      debugPrint("Form is valid!");
      debugPrint("Name: ${_nameController.text}");
      debugPrint("Username: ${_usernameController.text}");
      debugPrint("Bio: ${_bioController.text}");
      debugPrint("ProfileImage: ${_profileImage?.path}");
      debugPrint("BackgroundImage: ${_backgroundImage?.path}");
      context.read<UserBloc>().add(
        UpdateUserEvent(
          userid: currentUser.id,
          name: _nameController.text,
          username: _usernameController.text,
          bio: _bioController.text,
          profileAvatar: _profileImage,
          backgroundUrl: _backgroundImage,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Define heights to calculate the overlap perfectly
    const double coverHeight = 200;
    const double profileHeight = 120;

    return Scaffold(
      appBar: AppBar(
        actionsPadding: const EdgeInsets.all(8),
        actions: [
          TextButton(
            onPressed: _submitForm, // Assuming this is defined
            child: Text(
              "Confirm",
              style: context.buttonTextStyle.copyWith(color: AppColors.primary),
            ),
          ),
        ],
      ),
      body: BlocConsumer<UserBloc, UserState>(
        listener: (context, state) {
          if (state is UserLoadedState) {
            context.read<CurrentUserCubit>().setUser(state.user);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("updated info successfully"),
                backgroundColor: AppColors.primary,
              ),
            );
            context.go('/user-profile');
          } else if (state is UserErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is UserLoadingState) return LoadingWidget();
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  // Constrain the Stack's height so it pushes the text fields down
                  SizedBox(
                    height: coverHeight + (profileHeight / 2),
                    child: Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment
                          .topCenter, // Centers the avatar horizontally
                      children: [
                        // 1. Cover Photo
                        ProfileBackground(
                          heroTag: 'edit_profile_background',
                          height: coverHeight,
                          isEdit: true,
                          imageUrl: currentUser.backgroundUrl,
                          localImage: _backgroundImage,
                          onCameraTap: () async {
                            final picked = await ImagePickerHandler.pickImage(
                              context: context,
                            );
                            if (picked != null) {
                              setState(() {
                                _backgroundImage = picked;
                              });
                            }
                          },
                        ),

                        // 2. Profile Picture (pushed down to overlap)
                        Positioned(
                          top: coverHeight - (profileHeight / 2),
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              ProfileContainer(
                                heroTag: 'edit_profile_image',
                                width: profileHeight,
                                height: profileHeight,
                                borderWidth: 4,
                                imageUrl: currentUser.imageUrl ?? "",
                                localImage: _profileImage,
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: InkWellContainer(
                                  onTap: () async {
                                    final picked =
                                        await ImagePickerHandler.pickImage(
                                          context: context,
                                        );
                                    if (picked != null) {
                                      setState(() {
                                        _profileImage = picked;
                                      });
                                    }
                                  },
                                  icon: Icons.camera_alt,
                                  containerSize: 45,
                                  iconSize: 24,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // We can reduce this spacing since the SizedBox already accounts for the avatar height
                  const SizedBox(height: 16),

                  LabeledText(
                    label: 'Name',
                    hintText: 'Enter your name',
                    controller: _nameController,
                  ),
                  const SizedBox(height: 16),
                  LabeledText(
                    label: 'Username',
                    hintText: 'Enter your username',
                    controller: _usernameController,
                    validator: (value) => Validators.validateUsername(value),
                  ),
                  const SizedBox(height: 16),
                  LabeledText(
                    label: 'Bio',
                    hintText: 'Write something about yourself',
                    controller: _bioController,
                    maxLines: 4,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
