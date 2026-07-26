import 'package:cleanarch/core/responsive/responsive.dart';
import 'package:cleanarch/core/theming/app_theme_extension.dart';
import 'package:cleanarch/core/theming/colors.dart';
import 'package:cleanarch/core/util/validators.dart';
import 'package:cleanarch/features/auth/presentation/blocs/bloc/auth_bloc.dart';
import 'package:cleanarch/features/auth/presentation/blocs/cubit/remember_me_cubit.dart';
import 'package:cleanarch/features/auth/presentation/widgets/auth_field.dart';
import 'package:cleanarch/features/auth/presentation/widgets/google_button.dart';
import 'package:cleanarch/features/auth/presentation/widgets/or_divider.dart';
import 'package:cleanarch/features/auth/presentation/widgets/remember_me.dart';
import 'package:cleanarch/core/widgets/app_logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LogInForm extends StatefulWidget {
  final double parentWidth;
  final double parentHeight;

  const LogInForm({
    super.key,
    required this.parentWidth,
    required this.parentHeight,
  });

  @override
  State<LogInForm> createState() => _LogInFormState();
}

class _LogInFormState extends State<LogInForm> {
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
        children: [
          const SizedBox(height: 8),
          _header(),
          const SizedBox(height: 28),
          AuthField(
            icon: Icons.email,
            hintText: "Email",
            parentWidth: widget.parentWidth,
            controller: _emailController,
            validator: (value) => Validators.validateEmail(value),
          ),
          AuthField(
            hintText: "Password",
            icon: Icons.lock,
            ispass: true,
            parentWidth: widget.parentWidth,
            controller: _passwordController,
            validator: Validators.validatePassword,
          ),
          _forgotPassword(),
          RememberMeWidget(parentWidth: widget.parentWidth),
          const SizedBox(height: 16),
          _loginButton(),
          const SizedBox(height: 20),
          OrDivider(parentWidth: widget.parentWidth),
          const SizedBox(height: 20),
          GoogleButton(parentWidth: widget.parentWidth),

          const SizedBox(height: 24),
          _signupLink(),
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
          "Welcome Back",
          style: TextStyle(
            fontSize: Responsive.isMobile(context) ? 26 : 30,
            fontWeight: FontWeight.bold,
            color: context.textPrimaryColor,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          "Sign in to continue your journey",
          style: TextStyle(fontSize: 14, color: context.textSecondaryColor),
        ),
      ],
    );
  }

  Widget _forgotPassword() {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 6),
        child: TextButton(
          onPressed: () => context.pushNamed('resetPassword'),
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Text(
            "Forgot password?",
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: context.primaryColor,
            ),
          ),
        ),
      ),
    );
  }

  Widget _loginButton() {
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
                context.read<AuthBloc>().add(
                  LogInEvent(
                    username: _emailController.text,
                    password: _passwordController.text,
                    rememberMe: context.read<RememberMeCubit>().state,
                  ),
                );
              }
            },
            child: Center(
              child: Text(
                "Log In",
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

  Widget _signupLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't have an account?",
          style: TextStyle(fontSize: 14, color: context.textSecondaryColor),
        ),
        TextButton(
          onPressed: () => context.goNamed('signup'),
          style: TextButton.styleFrom(
            padding: const EdgeInsets.only(left: 4),
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Text(
            "Sign up",
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
