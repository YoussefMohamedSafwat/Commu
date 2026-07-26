import 'package:cleanarch/core/theming/app_theme_extension.dart';
import 'package:cleanarch/core/theming/colors.dart';
import 'package:flutter/material.dart';

class AuthField extends StatefulWidget {
  final IconData icon;
  final String hintText;
  final bool ispass;
  final double parentWidth;
  final TextEditingController controller;
  final String? Function(String? value) validator;

  const AuthField({
    super.key,
    required this.hintText,
    required this.icon,
    this.ispass = false,
    required this.parentWidth,
    required this.controller,
    required this.validator,
  });

  @override
  State<AuthField> createState() => _AuthFieldState();
}

class _AuthFieldState extends State<AuthField> {
  bool _isObscure = true;
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: SizedBox(
        width: widget.parentWidth,
        child: FocusScope(
          onFocusChange: (focused) => setState(() => _isFocused = focused),
          child: TextFormField(
            controller: widget.controller,
            validator: (value) => widget.validator(value),
            obscureText: widget.ispass ? _isObscure : false,
            style: TextStyle(color: context.textPrimaryColor, fontSize: 15),
            decoration: InputDecoration(
              prefixIcon: Icon(
                widget.icon,
                color: context.primaryColor,
                size: 20,
              ),
              hintText: widget.hintText,
              hintStyle: TextStyle(
                color: context.textTertiaryColor,
                fontSize: 14,
              ),
              filled: true,
              fillColor: context.isDark
                  ? const Color(0xFF0F1716).withValues(alpha: 0.5)
                  : Colors.white.withValues(alpha: 0.5),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 18,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                  color: context.isDark
                      ? Colors.white.withValues(alpha: 0.1)
                      : AppColors.lightTeal,
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: context.primaryColor, width: 2),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: context.accentColor, width: 1),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: context.accentColor, width: 2),
              ),
              suffixIcon: widget.ispass
                  ? IconButton(
                      icon: Icon(
                        _isObscure ? Icons.visibility_off : Icons.visibility,
                        color: _isFocused
                            ? context.primaryColor
                            : context.textTertiaryColor,
                        size: 20,
                      ),
                      onPressed: () {
                        setState(() {
                          _isObscure = !_isObscure;
                        });
                      },
                    )
                  : null,
            ),
          ),
        ),
      ),
    );
  }
}
