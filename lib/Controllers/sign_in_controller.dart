import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jasmin_todo/Screen/home_screen.dart';
import 'package:jasmin_todo/Utils/app_texts.dart';

import '../Utils/common_snackbars.dart';
import '../main.dart';

class SignInController extends ChangeNotifier {
  TextEditingController userNameController = TextEditingController();
  TextEditingController userEmailController = TextEditingController();
  TextEditingController userPasswordController = TextEditingController();
  bool isContinueBtnLoading = false;

  signInWithGoogle(context) async {
    isContinueBtnLoading = true;
    notifyListeners();

    try {
      UserCredential _authenticatedUser = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: userEmailController.text!.trim().toLowerCase(),
              password: userPasswordController.text!);
      if (_authenticatedUser.user!.email != null) {
        box.write("uid", _authenticatedUser.user!.uid);
        box.write("gmail", _authenticatedUser.user!.email);
        box.write("isLogin", true);
        var userInfo = await getUserInfo(_authenticatedUser.user!.uid);
        print(userInfo);
        //showSnackBar(context,"Login Succesfully",AppColor.ACCENT_COLOR_Dark_Dark.withOpacity(0.8));
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => HomeScreen()),
            (Route<dynamic> route) => false);
      }
    } on FirebaseAuthException catch (e) {
      AppMessages.errorSnackBar(
          title: e.message
              .toString()
              .substring(0, e.message.toString().indexOf('.')),
          context: context);
      isContinueBtnLoading = false;
      notifyListeners();
    } catch (ex) {
      isContinueBtnLoading = false;
      notifyListeners();
      print("Email and Password incorrect");
    }

    print(userNameController.text);
    isContinueBtnLoading = false;
    notifyListeners();
  }

  signUpWithGoogle(context) async {
    isContinueBtnLoading = true;
    notifyListeners();

    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: userEmailController.text!.trim().toLowerCase(),
              password: userPasswordController.text!)
          .then((currentUser) => FirebaseFirestore.instance
                  .collection('users')
                  .doc(currentUser.user!.uid)
                  .set({
                "uid": currentUser.user!.uid,
                "created": DateTime.now().toLocal().toString(),
                "email": userEmailController.text!.trim().toLowerCase(),
                "name": userNameController.text,
              }).then((value) {
                isContinueBtnLoading = false;
                AppMessages.successSnackBar(
                    title: AppTexts.registerSuccessText, context: context);
                Navigator.pop(context);
              }));
    } on FirebaseAuthException catch (e) {
      AppMessages.errorSnackBar(
          title: e.message
              .toString()
              .substring(0, e.message.toString().indexOf('.')),
          context: context);
      isContinueBtnLoading = false;
      notifyListeners();
    } catch (e) {
      AppMessages.errorSnackBar(
          title: AppTexts.somethingWrongText, context: context);
      isContinueBtnLoading = false;
      notifyListeners();
    }

    print(userNameController.text);
    isContinueBtnLoading = false;
    notifyListeners();
  }

  Future<dynamic> getUserInfo(id) async {
    QuerySnapshot qShot = await FirebaseFirestore.instance
        .collection("users")
        .where("uid", isEqualTo: id)
        .get();
    // QuerySnapshot qShot =
    //     await FirebaseFirestore.instance
    //     .collection("users")
    //     .doc(FirebaseAuth.instance.currentUser!.uid).get();
    return Map<String, dynamic>.from(qShot.docs[0].data() as Map);
  }
}
