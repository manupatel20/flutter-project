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

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {


  showSnackBar(String message, Duration duration) {
    final snackBar = SnackBar(content: Text(message), duration: duration);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    // final _formKey = GlobalKey<FormState>();
    TextEditingController emailController = TextEditingController();
    TextEditingController nameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController phoneController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.white,
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
              style: GoogleFonts.bebasNeue(
                fontSize: 42,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Welcomes You !',
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
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
                            .collection("userdata").doc(emailController.text)
                            .set(input); 
                      }).catchError((error) {
                        print('failed to add user: $error');
                        showSnackBar("failed to add user: $error", Duration(milliseconds: 500));
                      
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
                        child: Center(
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
                        padding: EdgeInsets.only(top: 10.0, right: 40.0),
                        child: GestureDetector(
                          onTap: () => print("Facebook clicked"),
                          child: Container(
                            padding: const EdgeInsets.all(15.0),
                            decoration: new BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: new Icon(
                              FontAwesomeIcons.facebookF,
                              color: Color(0xFF0084ff),
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
                            decoration: new BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: new Icon(
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
                            decoration: new BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: new Icon(
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
                            decoration: new BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: new Icon(
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
                      Text(
                        'Already have an account?',
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
                        child: Text(
                          ' Sign In',
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 25),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
