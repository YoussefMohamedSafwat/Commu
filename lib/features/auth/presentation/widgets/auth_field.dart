import 'package:cleanarch/core/theming/colors.dart';
import 'package:cleanarch/core/theming/text_styles.dart';
import 'package:flutter/material.dart';

class AuthField extends StatefulWidget {
  final IconData icon;
  final String hintText;
  final bool ispass;
  final double parentWidth;
  final TextEditingController controller;
  final Function(String? value) validator;

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
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        width: widget.parentWidth * 0.8,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(20),
          color: Colors.black12,
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 0),
              color: AppColors.primaryColor,
              blurRadius: 5,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: TextFormField(
            controller: widget.controller,
            validator: (value) => widget.validator(value),
            obscureText: widget.ispass ? _isObscure : false,
            decoration: InputDecoration(
              icon: Icon(widget.icon),
              hint: Text(
                widget.hintText,
                style: AppTextStyle.hintText.copyWith(),
              ),
              border: InputBorder.none,
              suffixIcon: widget.ispass
                  ? IconButton(
                      icon: _isObscure
                          ? Icon(Icons.visibility_off)
                          : Icon(Icons.visibility),
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
