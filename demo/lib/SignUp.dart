import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/HomePage.dart';
import 'package:demo/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

//The state of these widgets can be changed once they are built because they are mutable ,
// so state of an app can change multiple times with different sets of variables, inputs, data, are called stateful widgets.
class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  //final is used to create a constant variable
  //Defining a snackbar,snackbar widget is used to display the popup message incase of any error
  showSnackBar(String message, Duration duration) {
    final snackBar = SnackBar(content: Text(message), duration: duration);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    // final _formKey = GlobalKey<FormState>();
    //TextEditingController is used to take input from the text-field in TextField widget
    TextEditingController emailController = TextEditingController();
    TextEditingController nameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
/**
 * Implements the basic Material Design visual layout structure.
  This class provides APIs for showing drawers and bottom sheets.
  By default the scaffold's body is resized to make room for the keyboard. To prevent the resize set resizeToAvoidBottomInset to false.
   In either case the focused widget will be scrolled into view if it's within a scrollable container.
 */
    return Scaffold(
      backgroundColor: Colors.white,
      /**A box in which a single widget can be scrolled.

      This widget is useful when you have a single box that will normally be entirely visible, for example a clock face in a time picker,
      but you need to make sure it can be scrolled if the container gets too small in one axis (the scroll direction). */
      body: SingleChildScrollView(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 40),
            Icon(
              Icons.restaurant,
              size: 70,
            ),
            SizedBox(height: 20),
            //hello again,
            Text(
              'KITCHEN DIARIES',
              //here we are using google fonts to incrase the font size and style,
              //we can also use the default fonts provided by flutter
              style: GoogleFonts.bebasNeue(
                fontSize: 42,
                fontWeight: FontWeight.bold,
              ),
            ),
            //here we are using the text widget to display the text
            //along eith the Sizedbox widget to give some space between the text and the textfield(two widgets)
            SizedBox(height: 10),
            Text(
              'Welcomes You !',
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            SizedBox(height: 20),
            Container(
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
                  SizedBox(height: 25),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      /**
                       * A material design text field.
                        Text fields let users enter text into a UI.
                        The TextField widget implements this component.
                        To provide a text field that looks like a Material Design text field, use the TextField widget.
                        To provide a text field that looks like a Cupertino text field, use the CupertinoTextField widget.
                        To provide a text field that looks like a text field in an Android Material Design app, use the TextFormField widget.
                       
                       */
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: TextField(
                          controller: nameController,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.person,
                              color: Colors.grey[600],
                            ),
                            border: InputBorder.none,
                            hintText: 'Usernme',
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
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
                  SizedBox(height: 10),
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
                          controller: phoneController,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.phone,
                              color: Colors.grey[600],
                            ),
                            border: InputBorder.none,
                            hintText: 'phone no.',
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
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
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      {}
                      (FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                              email: emailController.text,
                              password: passwordController.text)
                          .then((value) {
                        Map<String, dynamic> input = {
                          "email": emailController.text,
                          "name": nameController.text,
                          "phone": phoneController.text,
                        };
                        FirebaseFirestore.instance
                            .collection("userdata")
                            .doc(emailController.text)
                            .set(input);
                      }).catchError((error) {
                        print('failed to add user: $error');
                        showSnackBar("failed to add user: $error",
                            Duration(milliseconds: 500));
                      }).then((value) {
                        print("successsfully registered,$value");
                      }).then((value) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()));
                      }).onError((error, stackTrace) {
                        print("error ${error.toString()}");
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
                            'Sign Up',
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
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0, right: 40.0),
                        child: GestureDetector(
                          onTap: () => print("Facebook clicked"),
                          child: Container(
                            padding: const EdgeInsets.all(15.0),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: const Icon(
                              FontAwesomeIcons.facebookF,
                              color:  Color(0xFF0084ff),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10.0, right: 40.0),
                        child: GestureDetector(
                          onTap: () => print("Instagram clicked"),
                          child: Container(
                            padding: const EdgeInsets.all(15.0),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: const Icon(
                              FontAwesomeIcons.instagram,
                              color: Color(0xFF0084ff),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10.0, right: 40.0),
                        child: GestureDetector(
                          onTap: () => print("Github clicked"),
                          child: Container(
                            padding: const EdgeInsets.all(15.0),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: const Icon(
                              FontAwesomeIcons.github,
                              color: Color(0xFF0084ff),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                        child: GestureDetector(
                          onTap: () => print("Google clicked"),
                          child: Container(
                            padding: const EdgeInsets.all(15.0),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: const Icon(
                              FontAwesomeIcons.google,
                              color: Color(0xFF0084ff),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Already have an Account?',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()));
                        },
                        child: const Text(
                          ' Sign In',
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
