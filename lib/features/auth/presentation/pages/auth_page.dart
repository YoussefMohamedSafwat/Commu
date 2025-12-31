
import 'package:cleanarch/core/responsive/responsive.dart';
import 'package:cleanarch/core/theming/text_styles.dart';
import 'package:cleanarch/core/util/snackbar_message.dart';
import 'package:cleanarch/core/widgets/loading_widget.dart';
import 'package:cleanarch/features/auth/presentation/blocs/bloc/auth_bloc.dart';
import 'package:cleanarch/features/auth/presentation/widgets/auth_container.dart';
import 'package:cleanarch/features/auth/presentation/widgets/log_in_form.dart';
import 'package:cleanarch/features/auth/presentation/widgets/sign_up_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

          if (state is AuthLogIn) {
            SnackBarMessage().showSuccessSnackBar(
              message: "Logged in successfully",
              context: context,
            );
          }
        },
        child: Stack(
          children: [
            _background(),
            if (Responsive.isDesktop(context)) _welcomeText(),
            _formContainer(),
          ],
        ),
      ),
    );
  }

  Widget _background() {
    return Positioned.fill(
      child: Image.asset("assets/images/auth_back.jpg", fit: BoxFit.cover),
    );
  }

  Widget _welcomeText() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Text(
          widget.isSignUp ? "Welcome!" : "Welcome Back!",
          style: AppTextStyle.titleText.copyWith(
            fontSize: 60,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _formContainer() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Align(
        alignment: Responsive.isDesktop(context)
            ? Alignment.topRight
            : Alignment.center,
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
