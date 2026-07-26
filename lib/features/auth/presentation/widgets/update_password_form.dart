import 'package:cleanarch/core/theming/app_theme.dart';
import 'package:cleanarch/core/util/validators.dart';
import 'package:cleanarch/features/auth/presentation/widgets/auth_field.dart';
import 'package:cleanarch/features/auth/presentation/blocs/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdatePasswordForm extends StatefulWidget {
  final double parentWidth;
  final double parentHeight;
  const UpdatePasswordForm({
    super.key,
    required this.parentWidth,
    required this.parentHeight,
  });

  @override
  State<UpdatePasswordForm> createState() => _UpdatePasswordFormState();
}

class _UpdatePasswordFormState extends State<UpdatePasswordForm> {
  final _key = GlobalKey<FormState>();
  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 20,
        children: [
          Text("Update your password", style: context.heading),
          AuthField(
            hintText: 'enter your new password ',
            icon: Icons.lock,
            parentWidth: widget.parentWidth,
            controller: _passwordController,
            ispass: true,
            validator: Validators.validatePassword,
          ),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                if (_key.currentState?.validate() ?? false) {
                  context.read<AuthBloc>().add(UpdatePasswordEvent(password: _passwordController.text));
                }
              },
              child: const Text("Submit"),
            ),
          ),
        ],
      ),
    );
  }
}
