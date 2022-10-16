import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/HomePage.dart';
import 'package:demo/SignUp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/painting.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    showSnackBar(String message, Duration duration) {//Shows a SnackBar across all registered Scaffolds.A scaffold can show at most one snack bar at a time. If this function is called while another snack bar is already visible, the given snack bar will be added to a queue and displayed after the earlier snack bars have closed.
      final snackBar = SnackBar(content: Text(message), duration: duration);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);//Manages SnackBars and MaterialBanners for descendant Scaffolds.This class provides APIs for showing snack bars and material banners at the bottom and top of the screen, respectively.
    }

    /*A controller for an editable text field.Whenever the user modifies a text field with an associated TextEditingController, the text field updates value and the controller notifies its listeners. Listeners can then read the text and selection properties to learn what the user has typed or how the selection has been updated */
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    return Scaffold(/*Implements the basic Material Design visual layout structure.This class provides APIs for showing drawers and bottom sheets.*/
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        /*SingleChildScrollView - A box in which a single widget can be scrolled.
    This widget is useful when you have a single box that will normally be entirely visible,
     but you need to make sure it can be scrolled if the container gets too small in one axis
     (the scroll direction).It is also useful if you need to shrink-wrap in both axes
     (the main scrolling direction as well as the cross axis), as one might see in a dialog or pop-up menu.*/
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 130),
            const Icon(
              Icons.restaurant,
              size: 100,
            ),
            SizedBox(height: 20),
            //hello again,
            Text(
              'KITCHEN DIARIES',
              style: GoogleFonts.bebasNeue(
                fontSize: 42,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Welcomes You !',
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 40),

            //email textfield
            Container(//A convenience widget that combines common painting, positioning, and sizing widgets.
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 195, 155, 254),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 25),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: TextField(
                          controller: emailController,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.email,
                              color: Colors.grey[600],
                            ),
                            border: InputBorder.none,
                            hintText: 'Email',
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: TextField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.vpn_key,
                              color: Colors.grey[600],
                            ),
                            border: InputBorder.none,
                            hintText: 'password',
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      {}
                      (FirebaseAuth.instance
                          .signInWithEmailAndPassword(//Tries to create a new user account with the given email address and password. If successful, it also signs the user in into the app.
                              email: emailController.text,
                              password: passwordController.text)
                          .then((value) {
                        print("successsfully logged-in");
                      }).then((value) {
                        Navigator.push(//Navigator helps us navigate to new route. Navigator.push() method is used to switch to a new route.
                            context,
                            MaterialPageRoute(//MaterialPageRoute - A modal route that replaces the entire screen with a platform-adaptive transition. By default, when a modal route is replaced by another, the previous route remains in memory.
                                builder: (context) =>
                                    HomePage(emailController.text)));
                      }).onError((error, stackTrace) {
                        print("error ${error.toString()}");
                        showSnackBar("error ${error.toString()}",//Shows a SnackBar across all registered Scaffolds.A scaffold can show at most one snack bar at a time. If this function is called while another snack bar is already visible, the given snack bar will be added to a queue and displayed after the earlier snack bars have closed.
                            Duration(milliseconds: 500));
                      }));
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.deepPurple[400],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Center(
                          child: Text(
                            'Sign In',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Not a member?',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      GestureDetector(/*By default a GestureDetector with an invisible child ignores touches; this behavior can be controlled with behavior. Detects various gestures and events using the supplied MotionEvents. The OnGestureListener callback will notify users when a particular motion event has occurred.*/
                        onTap: () {
                          Navigator.push(//Navigator helps us navigate to new route. Navigator.push() method is used to switch to a new route.
                              context,
                              MaterialPageRoute(//MaterialPageRoute - A modal route that replaces the entire screen with a platform-adaptive transition. By default, when a modal route is replaced by another, the previous route remains in memory.
                                  builder: (context) => SignUp()));
                        },
                        child: const Text(
                          ' Register Now',
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  SizedBox(height: 25),
                ],
              ),
            ),

            //password textfield

            //signin button

            //not a member? Register now
          ],
        )),
      ),
    );
  }
}
