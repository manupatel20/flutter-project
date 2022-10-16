import 'package:flutter/material.dart';
import 'login_page.dart';
import 'package:firebase_core/firebase_core.dart';

Future main ( ) async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return const MaterialApp(/*An application that uses Material Design.
    A convenience widget that wraps a number of widgets that are commonly required for Material Design applications.*/
      debugShowCheckedModeBanner: false, //Turns on a little "DEBUG" banner in debug mode to indicate that the app is in debug mode. This is on by default (in debug mode), to turn it off, set the constructor argument to false. In release mode this has no effect.
      home: LoginPage(),
    ); // MaterialApp
  }
}
