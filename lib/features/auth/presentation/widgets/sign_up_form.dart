import 'package:cleanarch/core/responsive/responsive.dart';
import 'package:cleanarch/core/theming/colors.dart';
import 'package:cleanarch/core/theming/text_styles.dart';
import 'package:cleanarch/core/util/validators.dart';
import 'package:cleanarch/features/auth/presentation/blocs/bloc/auth_bloc.dart';
import 'package:cleanarch/features/auth/presentation/widgets/auth_field.dart';
import 'package:cleanarch/features/auth/presentation/widgets/or_divider.dart';
import 'package:cleanarch/features/auth/presentation/widgets/password_confirm_desktop.dart';
import 'package:cleanarch/features/auth/presentation/widgets/password_confirm_mobile.dart';
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
      child: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: widget.parentHeight),
          child: IntrinsicHeight(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(50.0),
                    child: Text(
                      "Sign Up ",
                      style: AppTextStyle.titleText.copyWith(
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ),
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

                const SizedBox(height: 40),
                SizedBox(
                  width: widget.parentWidth * 0.8,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_key.currentState!.validate()) {
                        BlocProvider.of<AuthBloc>(context).add(
                          (SignUpEvent(
                            username: _usernameController.text,
                            email: _emailController.text,
                            password: _passwordController.text,
                          )),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      padding: EdgeInsets.all(15),
                    ),
                    child: Text(
                      "Create Account",
                      style: AppTextStyle.buttonText,
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                OrDivider(parentWidth: widget.parentWidth),

                const SizedBox(height: 10),

                SizedBox(
                  width: widget.parentWidth * 0.8,
                  child: ElevatedButton(
                    onPressed: () => context.goNamed('login'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.iconBtnColor,
                      padding: EdgeInsets.all(15),
                    ),
                    child: Text("Log In", style: AppTextStyle.buttonText),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
