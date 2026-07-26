import 'package:cleanarch/core/theming/app_theme.dart';
import 'package:cleanarch/core/util/validators.dart';
import 'package:cleanarch/features/auth/presentation/widgets/auth_field.dart';
import 'package:cleanarch/features/auth/presentation/blocs/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResetPasswordForm extends StatefulWidget {
  final double parentWidth;
  final double parentHeight;
  const ResetPasswordForm({
    super.key,
    required this.parentWidth,
    required this.parentHeight,
  });

  @override
  State<ResetPasswordForm> createState() => _ResetPasswordFormState();
}

class _ResetPasswordFormState extends State<ResetPasswordForm> {
  final _key = GlobalKey<FormState>();
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
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
          Text("Reset your password", style: context.heading),
          AuthField(
            hintText: 'enter your current email ',
            icon: Icons.email,
            parentWidth: widget.parentWidth,
            controller: _emailController,
            validator: (email) => Validators.validateEmail(email),
          ),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                if (_key.currentState?.validate() ?? false) {
                  context.read<AuthBloc>().add(
                    ResetPasswordEvent(email: _emailController.text),
                  );
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
