import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jasmin_todo/Screen/home_screen.dart';
import 'package:jasmin_todo/Utils/app_colors.dart';
import 'Controllers/sign_in_controller.dart';
import 'Controllers/todo_controller.dart';
import 'Screen/sign_in_screen.dart';
import 'package:provider/provider.dart';

final box = GetStorage();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => SignInController()),
          ChangeNotifierProvider(create: (_) => TodoController()),
        ],
        child: MyApp(),
      ));
}

class MyApp extends StatelessWidget {
   MyApp({super.key});

  bool login=box.read("isLogin")??false;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jasmin Todo',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
        appBarTheme: AppBarTheme(
          color: AppColors.backgroundColor,
          iconTheme: IconThemeData(color: AppColors.whiteColor),
          centerTitle: true,
          titleTextStyle: TextStyle(color: AppColors.whiteColor,fontSize: 18),
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        primaryColor: AppColors.backgroundColor,
        scaffoldBackgroundColor: AppColors.backgroundColor,
        useMaterial3: true,
        iconTheme: IconThemeData(color: AppColors.whiteColor),
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: TextStyle(color: AppColors.whiteColor),
          contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 10.0),
          hintStyle: TextStyle(color: AppColors.whiteColor.withOpacity(0.5)),
          enabledBorder: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(
              color: AppColors.whiteColor.withOpacity(0.5),
            ),
          ),
          errorBorder: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.red),
          ),
          focusedErrorBorder: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(
                color:AppColors.whiteColor,
            ),
          ),
          focusedBorder:UnderlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(
              color: AppColors.whiteColor,
            ),
          ),
        ),
      ),
      home: login?HomeScreen():SignInScreen(),
    );
  }
}

