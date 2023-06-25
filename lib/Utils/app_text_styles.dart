import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTextStyles {
  //20
  static TextStyle appBarTextStyle = TextStyle(
    color: AppColors.whiteColor,
    fontSize: 15,
    fontWeight: FontWeight.w600,
  );
  static TextStyle commonFillButtonTextStyle = TextStyle(
    color: AppColors.whiteColor,
    fontSize: 13.50,
    fontWeight: FontWeight.w600,
  );
  static TextStyle commonBorderedButtonTextStyle = TextStyle(
    color: AppColors.whiteColor,
    fontSize: 13.50,
    fontWeight: FontWeight.w600,
  );

  //18
  static TextStyle headerTextStyle = TextStyle(
    color: AppColors.whiteColor,
    fontSize: 13.50,
    fontWeight: FontWeight.w600,
  );

  //16
  static TextStyle titleTextStyle = TextStyle(
    color: AppColors.whiteColor,
    fontSize: 12,
    fontWeight: FontWeight.w600,
  );

  //15
  static TextStyle mediumTextStyle = TextStyle(
    color: AppColors.whiteColor,
    fontSize: 11.50,
    fontWeight: FontWeight.w600,
  );

  //14
  static TextStyle smallTextStyle = TextStyle(
    color: AppColors.whiteColor,
    fontSize: 10.50,
    fontWeight: FontWeight.w400,
  );
  static TextStyle subTitleTextStyle = TextStyle(
    color: AppColors.whiteColor.withOpacity(0.6),
    fontSize: 10.50,
    fontWeight: FontWeight.w400,
  );
}
