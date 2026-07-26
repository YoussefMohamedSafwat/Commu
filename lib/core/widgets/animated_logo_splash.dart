import 'package:cleanarch/core/theming/app_theme_extension.dart';
import 'package:cleanarch/core/theming/text_styles.dart';
import 'package:cleanarch/core/widgets/app_logo.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AnimatedLogoSplash extends StatefulWidget {
  const AnimatedLogoSplash({super.key});

  @override
  State<AnimatedLogoSplash> createState() => _AnimatedLogoSplashState();
}

class _AnimatedLogoSplashState extends State<AnimatedLogoSplash>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..forward();

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );
    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    // Navigate to posts after delay
    Future.delayed(const Duration(milliseconds: 2500), () {
      if (mounted) {
        context.go('/posts');
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.backgroundColorApp,
      body: Stack(
        children: [
          Center(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Opacity(
                  opacity: _opacityAnimation.value,
                  child: Transform.scale(
                    scale: _scaleAnimation.value,
                    child: child,
                  ),
                );
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const AppLogo(size: 180),
                  const SizedBox(height: 24),
                  Text(
                    "Commu",
                    style: context.titleText.copyWith(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 48.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Connecting Communities",
                    textAlign: TextAlign.center,
                    style: context.subTitleText.copyWith(
                      fontSize: 16,
                      letterSpacing: 1.5,
                      fontWeight: FontWeight.w500,
                      color: context.textSecondaryColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Everywhere",
                    textAlign: TextAlign.center,
                    style: context.subTitleText.copyWith(
                      fontSize: 14,
                      letterSpacing: 1.2,
                      color: context.textSecondaryColor.withValues(alpha: 0.7),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
