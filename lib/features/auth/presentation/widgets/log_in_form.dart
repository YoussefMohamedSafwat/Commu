import 'package:cleanarch/core/theming/colors.dart';
import 'package:cleanarch/core/theming/text_styles.dart';
import 'package:cleanarch/core/util/validators.dart';
import 'package:cleanarch/features/auth/presentation/blocs/bloc/auth_bloc.dart';
import 'package:cleanarch/features/auth/presentation/blocs/cubit/remember_me_cubit.dart';
import 'package:cleanarch/features/auth/presentation/widgets/auth_field.dart';
import 'package:cleanarch/features/auth/presentation/widgets/or_divider.dart';
import 'package:cleanarch/features/auth/presentation/widgets/remember_me.dart';
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
  late final TextEditingController _usernameController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    // Initialize controllers once - they persist across rebuilds
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    // Clean up controllers when widget is disposed
    _usernameController.dispose();
    _passwordController.dispose();
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
                      "Log in ",
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
                  hintText: "Password",
                  icon: Icons.lock,
                  ispass: true,
                  parentWidth: widget.parentWidth,
                  controller: _passwordController,
                  validator: Validators.validatePassword,
                ),
                RememberMeWidget(parentWidth: widget.parentWidth),
                const SizedBox(height: 40),
                SizedBox(
                  width: widget.parentWidth * 0.8,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_key.currentState!.validate()) {
                        context.read<AuthBloc>().add(
                          LogInEvent(
                            username: _usernameController.text,
                            password: _passwordController.text,
                            rememberMe: context.read<RememberMeCubit>().state,
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      padding: const EdgeInsets.all(15),
                    ),
                    child: Text("Log in", style: AppTextStyle.buttonText),
                  ),
                ),
                const SizedBox(height: 10),
                OrDivider(parentWidth: widget.parentWidth),
                const SizedBox(height: 10),
                SizedBox(
                  width: widget.parentWidth * 0.8,
                  child: ElevatedButton(
                    onPressed: () => context.goNamed('signup'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.iconBtnColor,
                      padding: const EdgeInsets.all(15),
                    ),
                    child: Text("Sign up", style: AppTextStyle.buttonText),
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
