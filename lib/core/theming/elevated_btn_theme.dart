import 'package:cleanarch/core/constants/app_sizes.dart';
import 'package:cleanarch/core/theming/colors.dart';
import 'package:cleanarch/core/theming/text_styles.dart';

import 'package:flutter/material.dart';

ButtonStyle elevatedbuttonstyle = ElevatedButton.styleFrom(
  iconSize: AppSizes.s22,
  iconColor: AppColors.iconBtnColor,
  textStyle: AppTextStyle.buttonText,
  shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(8)),
);
