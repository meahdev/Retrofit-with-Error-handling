import 'package:flutter/material.dart';
import 'package:retrofit_with_error_handling/screens/login_screen.dart';
import 'package:retrofit_with_error_handling/screens/sample_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        "/": (_) =>  const SampleScreen(),
        "login": (_) =>  const LoginScreen(),
      },
    );
  }
}
