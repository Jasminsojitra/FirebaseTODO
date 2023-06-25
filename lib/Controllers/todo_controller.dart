import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jasmin_todo/Utils/app_colors.dart';
import '../Utils/app_texts.dart';
import '../Utils/common_snackbars.dart';

class TodoController extends ChangeNotifier {
  TextEditingController taskNameController = TextEditingController();
  TextEditingController taskDescriptionController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  bool isContinueBtnLoading = false;
  dynamic editTask;
  bool isAdd = true;

  editData() {
    if (!isAdd) {
      taskNameController.text = editTask["taskName"];
      dateController.text = editTask["date"];
      taskDescriptionController.text = editTask["description"];
      taskStartDate = DateFormat("dd-MM-yyyy").parse(editTask["date"]);
    }
  }

  clearData() {
    taskNameController.text = "";
    dateController.text = "";
    taskDescriptionController.text = "";
    taskStartDate = DateTime.now();
  }

  AddTask(context) {
    try {
      print("doc");
      //List<Placemark> placemarks = await placemarkFromCoordinates(double.parse(latitude.toString()) , double.parse(longitude.toString()));
      CollectionReference task = FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('taskList');
      var id = task.doc().id;
      task.doc(id).set({
        "id": id,
        "taskName": taskNameController.text,
        "date": dateController.text,
        "description": taskDescriptionController.text,
      }).then((value) async {
        AppMessages.successSnackBar(
            title: AppTexts.taskAddSuccessText, context: context);
        notifyListeners();
        Navigator.pop(context);
      });
    } on FirebaseAuthException catch (e) {
      AppMessages.errorSnackBar(title: e.message!, context: context);
      //showSnackBar(context,e.message,Colors.red.withOpacity(0.8));
    } catch (e) {
      AppMessages.errorSnackBar(
          title: AppTexts.somethingWrongText, context: context);
      //Navigator.pop(context);
      //showSnackBar(context,e,Colors.red);
    }
  }

  EditTask(context) {
    try {
      FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('taskList')
          .doc(editTask["id"])
          .update({
        "id": editTask["id"],
        "taskName": taskNameController.text,
        "date": dateController.text,
        "description": taskDescriptionController.text,
      }).then((result) {
        //pop dialog
        AppMessages.successSnackBar(
            title: AppTexts.taskEditSuccessText, context: context);
        notifyListeners();
        Navigator.pop(context);
      });
    } on FirebaseAuthException catch (e) {
      AppMessages.errorSnackBar(title: e.message!, context: context);
    } catch (e) {
      AppMessages.errorSnackBar(
          title: AppTexts.somethingWrongText, context: context);
    }
  }

  Stream<QuerySnapshot<Object?>> getAllTaskList() async* {
    QuerySnapshot qShot = await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('taskList')
        .get();
    yield qShot;
  }

  DateTime taskDate = DateTime.now();
  DateTime? taskStartDate;

  Future<void> selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: taskStartDate ?? DateTime.now(),
        firstDate: taskDate,
        lastDate: DateTime(taskDate.year + 1, taskDate.month - 1, taskDate.day),
        helpText: 'Task Date',
        // Can be used as title
        cancelText: 'Cancel',
        confirmText: 'Select',
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              primaryColor: AppColors.whiteColor,
              canvasColor: AppColors.whiteColor,
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(),
              ),
            ),
            child: child!,
          );
        });

    if (pickedDate != null && pickedDate != taskDate)
      taskStartDate = pickedDate;
    dateController.text = DateFormat('dd-MM-yyyy').format(pickedDate!);
    notifyListeners();
  }

  void delete(context, item) {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: const Text('Please Confirm'),
            content: const Text('Are you sure to delete Task Entry?'),
            actions: [
              // The "Yes" button
              TextButton(
                  onPressed: () {
                    // Close the dialog
                    FirebaseFirestore.instance
                        .collection("users")
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .collection('taskList')
                        .doc(item['id'])
                        .delete()
                        .then((result) {
                      //pop dialog
                      AppMessages.successSnackBar(
                          title: AppTexts.taskDeleteSuccessText,
                          context: context);
                      notifyListeners();
                      Navigator.pop(context);
                    });
                  },
                  child: const Text('Yes')),
              TextButton(
                  onPressed: () {
                    // Close the dialog
                    Navigator.of(context).pop();
                  },
                  child: const Text('No'))
            ],
          );
        });
  }
}
