import 'package:floating_snackbar/floating_snackbar.dart';
import 'package:jasmin_todo/Utils/app_colors.dart';

class AppMessages {
  static void errorSnackBar({required String title, context}) {
    FloatingSnackBar(
      message: title,
      context: context,
      textColor: AppColors.whiteColor,
      duration: const Duration(milliseconds: 4000),
      backgroundColor: AppColors.redColor,
    );
  }

  static void successSnackBar({required String title, context}) {
    FloatingSnackBar(
      message: title,
      context: context,
      textColor: AppColors.whiteColor,
      duration: const Duration(milliseconds: 4000),
      backgroundColor: AppColors.greenColor,
    );
  }
}
