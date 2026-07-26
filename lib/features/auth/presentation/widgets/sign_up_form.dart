import 'package:cleanarch/core/responsive/responsive.dart';
import 'package:cleanarch/core/theming/app_theme_extension.dart';
import 'package:cleanarch/core/theming/colors.dart';
import 'package:cleanarch/core/util/validators.dart';
import 'package:cleanarch/features/auth/presentation/blocs/bloc/auth_bloc.dart';
import 'package:cleanarch/features/auth/presentation/widgets/auth_field.dart';
import 'package:cleanarch/features/auth/presentation/widgets/google_button.dart';
import 'package:cleanarch/features/auth/presentation/widgets/or_divider.dart';
import 'package:cleanarch/features/auth/presentation/widgets/password_confirm_desktop.dart';
import 'package:cleanarch/features/auth/presentation/widgets/password_confirm_mobile.dart';
import 'package:cleanarch/core/widgets/app_logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SignUpForm extends StatefulWidget {
  final double parentHeight;
  final double parentWidth;
  const SignUpForm({
    super.key,
    required this.parentWidth,
    required this.parentHeight,
  });

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _key = GlobalKey<FormState>();
  late final TextEditingController _usernameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _passwordConfirmController;

  @override
  void initState() {
    _usernameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _passwordConfirmController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _passwordConfirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 8),
          _header(),
          const SizedBox(height: 28),
          AuthField(
            icon: Icons.person,
            hintText: "Username",
            parentWidth: widget.parentWidth,
            controller: _usernameController,
            validator: Validators.validateUsername,
          ),
          AuthField(
            icon: Icons.email,
            hintText: "Email Address",
            parentWidth: widget.parentWidth,
            controller: _emailController,
            validator: Validators.validateEmail,
          ),
          Responsive.isMobile(context)
              ? PasswordConfirmMobile(
                  parentWidth: widget.parentWidth,
                  passwordController: _passwordController,
                  passwordConfirmController: _passwordConfirmController,
                )
              : PasswordConfirmDesktop(
                  parentWidth: widget.parentWidth,
                  passwordController: _passwordController,
                  passwordConfirmController: _passwordConfirmController,
                ),
          const SizedBox(height: 6),
          _signUpButton(),
          const SizedBox(height: 20),
          OrDivider(parentWidth: widget.parentWidth),
          const SizedBox(height: 20),
          GoogleButton(parentWidth: widget.parentWidth),
          const SizedBox(height: 24),
          _loginLink(),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _header() {
    return Column(
      children: [
        const AppLogo(size: 140),
        const SizedBox(height: 16),
        Text(
          "Create Account",
          style: TextStyle(
            fontSize: Responsive.isMobile(context) ? 26 : 30,
            fontWeight: FontWeight.bold,
            color: context.textPrimaryColor,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          "Join our community",
          style: TextStyle(fontSize: 14, color: context.textSecondaryColor),
        ),
      ],
    );
  }

  Widget _signUpButton() {
    return SizedBox(
      width: widget.parentWidth,
      height: 52,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [context.primaryColor, AppColors.mint500],
          ),
          boxShadow: [
            BoxShadow(
              color: context.primaryColor.withValues(alpha: 0.2),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () {
              if (_key.currentState!.validate()) {
                BlocProvider.of<AuthBloc>(context).add(
                  SignUpEvent(
                    username: _usernameController.text,
                    email: _emailController.text,
                    password: _passwordController.text,
                  ),
                );
              }
            },
            child: Center(
              child: Text(
                "Create Account",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: AppColors.surface,
                  letterSpacing: 1.2,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _loginLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Already have an account?",
          style: TextStyle(fontSize: 14, color: context.textSecondaryColor),
        ),
        TextButton(
          onPressed: () => context.goNamed('login'),
          style: TextButton.styleFrom(
            padding: const EdgeInsets.only(left: 4),
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Text(
            "Log in",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: context.primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
