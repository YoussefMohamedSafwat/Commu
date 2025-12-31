import 'package:cleanarch/core/util/validators.dart';
import 'package:cleanarch/features/auth/presentation/widgets/auth_field.dart';
import 'package:flutter/material.dart';

class PasswordConfirmMobile extends StatelessWidget {
  final double parentWidth;
  final TextEditingController passwordController;
  final TextEditingController passwordConfirmController;
  const PasswordConfirmMobile({
    super.key,
    required this.parentWidth,
    required this.passwordConfirmController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AuthField(
          hintText: "Password",
          icon: Icons.lock,
          ispass: true,
          parentWidth: parentWidth,
          controller: passwordController,
          validator: Validators.validatePassword,
        ),
        AuthField(
          hintText: "Confirm Password",
          icon: Icons.lock,
          ispass: true,
          parentWidth: parentWidth,
          controller: passwordConfirmController,
          validator: Validators.confirmPassword,
        ),
      ],
    );
  }
}
