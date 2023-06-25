import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Controllers/todo_controller.dart';
import '../Utils/app_colors.dart';
import '../Utils/app_texts.dart';
import '../Utils/common_buttons.dart';

class AddEditTask extends StatelessWidget {
  AddEditTask({Key? key}) : super(key: key);

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final addEditTodoProvider = Provider.of<TodoController>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(addEditTodoProvider.isAdd
            ? AppTexts.addBtnText
            : AppTexts.editBtnText),
      ),
      body: ListView(
        padding: EdgeInsets.all(25),
        children: [
          Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  decoration:
                      InputDecoration(hintText: AppTexts.taskNameTextFieldText),
                  style: TextStyle(color: AppColors.whiteColor),
                  cursorColor: AppColors.whiteColor.withOpacity(0.5),
                  controller: addEditTodoProvider.taskNameController,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  validator: (val) {
                    if (val!.isNotEmpty) {
                      return null;
                    } else {
                      return AppTexts.taskNameTextFieldErrorText;
                    }
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  maxLines: 3,
                  decoration:
                      InputDecoration(hintText: AppTexts.taskDesTextFieldText),
                  style: TextStyle(color: AppColors.whiteColor),
                  cursorColor: AppColors.whiteColor.withOpacity(0.5),
                  controller: addEditTodoProvider.taskDescriptionController,
                  textInputAction: TextInputAction.newline,
                  validator: (val) {
                    if (val!.isNotEmpty) {
                      return null;
                    } else {
                      return AppTexts.taskDesTextFieldErrorText;
                    }
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  style: TextStyle(color: AppColors.whiteColor),
                  cursorColor: AppColors.whiteColor.withOpacity(0.5),
                  onTap: () => addEditTodoProvider.selectDate(context),
                  controller: addEditTodoProvider.dateController,
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: AppTexts.taskDateTextFieldText,
                  ),
                  validator: (val) {
                    if (val!.isNotEmpty) {
                      return null;
                    } else {
                      return AppTexts.taskDateTextFieldErrorText;
                    }
                  },
                  autofocus: false,
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          CommonFillButton(
              height: 50,
              btnText: addEditTodoProvider.isAdd
                  ? AppTexts.addBtnText
                  : AppTexts.editBtnText,
              isLoading: addEditTodoProvider.isContinueBtnLoading,
              callback: () async {
                if (formKey.currentState!.validate()) {
                  if (addEditTodoProvider.isAdd)
                    addEditTodoProvider.AddTask(context);
                  else
                    addEditTodoProvider.EditTask(context);
                }
              }),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
