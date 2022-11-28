import 'package:flutter/material.dart';
import 'package:sales_app/src/screens/home_screen.dart';

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
        title: 'Fashion App',
        theme: ThemeData(
          backgroundColor: Colors.black,
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: const Color.fromARGB(255, 1, 16, 39),
          inputDecorationTheme: InputDecorationTheme(
            labelStyle: const TextStyle(color: Colors.white),
            hintStyle: const TextStyle(color: Colors.grey),
            focusColor: Colors.white,
            fillColor: const Color.fromARGB(255, 1, 16, 39),
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        home: const HomeScreen());
  }
}