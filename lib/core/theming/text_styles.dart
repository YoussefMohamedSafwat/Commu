import 'package:cleanarch/core/constants/app_sizes.dart';
import 'package:flutter/material.dart';

class AppTextStyle {
  const AppTextStyle._();

  static const normalText = TextStyle(
    fontSize: AppSizes.s16,
    fontWeight: FontWeight.w700,
  );

  static const appBarText = TextStyle(
    fontSize: AppSizes.s24,
    fontWeight: FontWeight.w500,
  );

  static const commentText = TextStyle(
    fontSize: AppSizes.s16,
    fontWeight: FontWeight.w500,
  );

  static TextStyle titleText = TextStyle(
    fontSize: AppSizes.s24,
    fontWeight: FontWeight.w800,
  );

  static TextStyle hintText = TextStyle(
    fontWeight: FontWeight.w300,
    fontStyle: FontStyle.italic,
    fontSize: AppSizes.s12,
    color: Colors.black45,
  );

  static TextStyle subTitleText = TextStyle(
    fontSize: AppSizes.s12,
    fontWeight: FontWeight.w200,
    fontStyle: FontStyle.italic,
  );

  static TextStyle numberHeaderText = TextStyle(
    fontSize: AppSizes.s16,
    fontWeight: FontWeight.bold,
  );

  static const buttonText = TextStyle(
    fontSize: AppSizes.s22,
    color: Colors.white,
    fontWeight: FontWeight.bold
  );
}
