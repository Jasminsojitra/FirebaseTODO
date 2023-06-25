import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'app_colors.dart';
import 'app_text_styles.dart';

class CommonFillButton extends StatelessWidget {
  const CommonFillButton({
    Key? key,
    required this.btnText,
    this.height,
    this.width,
    this.isLoading,
    required this.callback,
  }) : super(key: key);
  final String btnText;
  final double? height;
  final double? width;
  final bool? isLoading;
  final void Function()? callback;

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: isLoading == true ? true : false,
      child: InkWell(
        splashColor: AppColors.primaryColor,
        onTap: callback,
        child: Ink(
          height: height,
          width: width ?? double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.primaryColor),
          child: Center(
            child: (isLoading == true)
                ? LoadingAnimationWidget.dotsTriangle(
                    color: AppColors.whiteColor, size: 30)
                : Text(
                    btnText,
                    style: AppTextStyles.commonFillButtonTextStyle,
                  ),
          ),
        ),
      ),
    );
  }
}
