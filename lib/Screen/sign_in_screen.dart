import 'package:flutter/material.dart';
import 'package:jasmin_todo/Screen/sign_up_screen.dart';
import 'package:provider/provider.dart';

import '../Controllers/sign_in_controller.dart';
import '../Utils/app_colors.dart';
import '../Utils/app_text_styles.dart';
import '../Utils/app_texts.dart';
import '../Utils/common_buttons.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({Key? key}) : super(key: key);

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final signInProvider = Provider.of<SignInController>(context);
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 4),
              FlutterLogo(size: 100),
              const SizedBox(height: 30),
              Text(AppTexts.signInTitleText,
                  style: AppTextStyles.appBarTextStyle),
              const SizedBox(height: 40),
              Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                          hintText: AppTexts.emailTextFieldText),
                      style: TextStyle(color: AppColors.whiteColor),
                      cursorColor: AppColors.whiteColor.withOpacity(0.5),
                      controller: signInProvider.userEmailController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      validator: (val) {
                        if (val!.isNotEmpty) {
                          return null;
                        } else {
                          return AppTexts.emailTextFieldErrorText;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          hintText: AppTexts.passwordTextFieldText),
                      obscureText: true,
                      style: TextStyle(color: AppColors.whiteColor),
                      cursorColor: AppColors.whiteColor.withOpacity(0.5),
                      controller: signInProvider.userPasswordController,
                      textInputAction: TextInputAction.done,
                      validator: (val) {
                        if (val!.isNotEmpty) {
                          return null;
                        } else {
                          return AppTexts.passwordTextFieldErrorText;
                        }
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              CommonFillButton(
                  height: 50,
                  btnText: AppTexts.continueBtnText,
                  isLoading: signInProvider.isContinueBtnLoading,
                  callback: () async {
                    if (formKey.currentState!.validate()) {
                      signInProvider.signInWithGoogle(context);
                    }
                  }),
              const SizedBox(height: 30),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Didn't have account?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: AppColors.whiteColor.withOpacity(0.5),
                        fontSize: 14),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUpScreen()),
                      );
                    },
                    child: Text(
                      " Register here",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: AppColors.whiteColor.withOpacity(0.8),
                          fontSize: 14),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      )),
    );
  }
}
