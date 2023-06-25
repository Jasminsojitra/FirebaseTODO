import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jasmin_todo/Screen/add_edit_task_screen.dart';
import 'package:jasmin_todo/Utils/app_colors.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

import '../Controllers/todo_controller.dart';
import '../Utils/app_text_styles.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final todoProvider = Provider.of<TodoController>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Task List"),
      ),
      body: StreamBuilder(
        stream: todoProvider.getAllTaskList(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
                child: LoadingAnimationWidget.dotsTriangle(
                    color: AppColors.whiteColor, size: 60));
          }
          return ListView(
            shrinkWrap: true,
            children: snapshot.data!.docs.length > 0
                ? snapshot.data!.docs.map((document) {
                    //print(document.data());
                    return PopupMenuButton<String>(
                      padding: EdgeInsets.all(0),
                      onSelected: (String value) {
                        if (value == "Edit") {
                          todoProvider.editTask = document;
                          todoProvider.isAdd = false;
                          Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AddEditTask()))
                              .then((value) => todoProvider.clearData());
                          todoProvider.editData();
                        } else {
                          todoProvider.delete(context, document);
                        }
                      },
                      child: Card(
                          margin: EdgeInsets.fromLTRB(15, 7, 10, 7),
                          color: Colors.transparent,
                          child: ListTile(
                            title: Text(document['taskName'],
                                style: AppTextStyles.appBarTextStyle),
                            subtitle: Text(document['description'],
                                style: AppTextStyles.subTitleTextStyle),
                            trailing: Text(document['date'],
                                style: AppTextStyles.subTitleTextStyle),
                            leading: Container(
                              child: Icon(
                                Icons.task,
                                color: AppColors.backgroundColor,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color:
                                          AppColors.whiteColor.withOpacity(0.5),
                                      spreadRadius: 2),
                                ],
                              ),
                              height: 50,
                              width: 50,
                            ),
                          )),
                      itemBuilder: (BuildContext context) =>
                          <PopupMenuEntry<String>>[
                        const PopupMenuItem<String>(
                          value: 'Edit',
                          child: Text('Edit'),
                        ),
                        const PopupMenuItem<String>(
                          value: 'Delete',
                          child: Text('Delete'),
                        ),
                      ],
                    );
                  }).toList()
                : [
                  Center(child: Text("Add Task",style: AppTextStyles.appBarTextStyle))
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          todoProvider.isAdd = true;
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddEditTask()),
          ).then((value) => todoProvider.clearData());
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
