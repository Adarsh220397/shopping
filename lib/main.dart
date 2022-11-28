import 'package:flutter/material.dart';
import 'package:sales_app/src/screens/home_screen.dart';
import 'package:sales_app/src/utils/app_constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: AppConstants.appName,
        theme: ThemeData(
          backgroundColor: Colors.black,
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: AppConstants.scaffoldBackgroundColor,
          inputDecorationTheme: InputDecorationTheme(
            labelStyle: const TextStyle(color: Colors.white),
            hintStyle: const TextStyle(color: Colors.grey),
            focusColor: Colors.white,
            fillColor: AppConstants.scaffoldBackgroundColor,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        home: const HomeScreen());
  }
}
