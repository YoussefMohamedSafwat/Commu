import 'dart:ui';
import 'package:cleanarch/core/theming/app_theme_extension.dart';
import 'package:cleanarch/core/theming/colors.dart';
import 'package:cleanarch/core/util/snackbar_message.dart';
import 'package:cleanarch/core/widgets/loading_widget.dart';
import 'package:cleanarch/features/auth/presentation/blocs/bloc/auth_bloc.dart';
import 'package:cleanarch/features/auth/presentation/widgets/auth_container.dart';
import 'package:cleanarch/features/auth/presentation/widgets/log_in_form.dart';
import 'package:cleanarch/features/auth/presentation/widgets/sign_up_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AuthPage extends StatefulWidget {
  final bool isSignUp;
  const AuthPage({super.key, this.isSignUp = false});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthLoading) return;

          if (state is AuthError) {
            SnackBarMessage().showErrorSnackBar(
              message: state.message,
              context: context,
            );
          }

          if (state is AuthSignUpRequiresVerification) {
            SnackBarMessage().showSuccessSnackBar(
              message: "Please check your email to verify your account",
              context: context,
            );
            context.goNamed('login');
          }

          if (state is AuthLogIn) {
            try {
              SnackBarMessage().showSuccessSnackBar(
                message: "Logged in successfully",
                context: context,
              );
            } catch (_) {}
          }
        },
        child: Stack(
          children: [_background(), _decorativeCircles(), _formContainer()],
        ),
      ),
    );
  }

  Widget _background() {
    return Positioned.fill(
      child: DecoratedBox(decoration: context.authBackground),
    );
  }

  Widget _decorativeCircles() {
    return IgnorePointer(
      child: Stack(
        children: [
          Positioned(
            top: MediaQuery.of(context).size.height * -0.1,
            right: MediaQuery.of(context).size.width * -0.1,
            width: 260,
            height: 260,
            child: ClipRect(
              child: ImageFiltered(
                imageFilter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: context.primaryColor.withValues(alpha: 0.1),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height * -0.05,
            left: MediaQuery.of(context).size.width * -0.05,
            width: 320,
            height: 320,
            child: ClipRect(
              child: ImageFiltered(
                imageFilter: ImageFilter.blur(sigmaX: 60, sigmaY: 60),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.mint500.withValues(alpha: 0.05),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _formContainer() {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        child: AuthContainer(
          child: (parentWidth, parentHeight) {
            return Stack(
              children: [
                widget.isSignUp
                    ? SignUpForm(
                        parentWidth: parentWidth,
                        parentHeight: parentHeight,
                      )
                    : LogInForm(
                        parentWidth: parentWidth,
                        parentHeight: parentHeight,
                      ),
                _loadingOverlay(),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _loadingOverlay() {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthLoading) {
          return Container(
            color: Colors.black54,
            child: const Center(child: LoadingWidget()),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
