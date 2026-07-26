import 'dart:ui';
import 'package:cleanarch/core/theming/app_theme_extension.dart';
import 'package:cleanarch/core/theming/colors.dart';
import 'package:cleanarch/core/util/snackbar_message.dart';
import 'package:cleanarch/features/auth/presentation/blocs/bloc/auth_bloc.dart';
import 'package:cleanarch/features/auth/presentation/widgets/auth_container.dart';
import 'package:cleanarch/features/auth/presentation/widgets/reset_password_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PasswordResetPage extends StatelessWidget {
  const PasswordResetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
      extendBodyBehindAppBar: true,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthPasswordResetSuccess) {
            SnackBarMessage().showSuccessSnackBar(
              message: "Password reset link sent to your email ",
              context: context,
            );
          } else if (state is AuthError) {
            SnackBarMessage().showErrorSnackBar(
              message: state.message,
              context: context,
            );
          }
        },
        child: Stack(
          children: [
            _background(context),
            _decorativeCircles(context),
            Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 24,
                ),
                child: AuthContainer(
                  child: (parentWidth, parentHeight) {
                    return ResetPasswordForm(
                      parentWidth: parentWidth,
                      parentHeight: parentHeight,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _background(BuildContext context) {
    return Positioned.fill(
      child: DecoratedBox(decoration: context.authBackground),
    );
  }

  Widget _decorativeCircles(BuildContext context) {
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
}
