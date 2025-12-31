import 'package:cleanarch/core/util/validators.dart';
import 'package:cleanarch/features/auth/presentation/widgets/auth_field.dart';
import 'package:flutter/material.dart';

class PasswordConfirmDesktop extends StatelessWidget {
  final double parentWidth;
  final TextEditingController passwordController;
  final TextEditingController passwordConfirmController;
  const PasswordConfirmDesktop({
    super.key,
    required this.parentWidth,
    required this.passwordConfirmController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.min,
      children: [
        AuthField(
          hintText: "Password",
          icon: Icons.lock,
          ispass: true,
          parentWidth: parentWidth * 0.45,
          controller: passwordController,
          validator: Validators.validatePassword,
        ),
        AuthField(
          hintText: "Confirm Password",
          controller: passwordConfirmController,
          icon: Icons.lock,
          ispass: true,
          parentWidth: parentWidth * 0.45,
          validator: Validators.confirmPassword,
        ),
      ],
    );
  }
}
