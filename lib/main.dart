import 'package:flutter/material.dart';
import 'package:retrofit_with_error_handling/network/token_interceptor.dart';
import 'package:retrofit_with_error_handling/screens/login_screen.dart';
import 'package:retrofit_with_error_handling/screens/sample_screen.dart';

import 'core/app_storage.dart';

void main() async{
///ensures that the Flutter framework's bindings are properly initialized before proceeding with the rest of your application code.
  WidgetsFlutterBinding.ensureInitialized();
  ///Obtain shared preferences.
  await AppStorage().init();
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
      navigatorKey: navigatorKey,
      initialRoute: "/",
      routes: {
        "/": (_) =>  const SampleScreen(),
        "login": (_) =>  const LoginScreen(),
      },
    );
  }
}
