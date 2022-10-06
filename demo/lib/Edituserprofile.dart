import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/navbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';

class edituserprofile extends StatefulWidget {
  // const edituserprofile({Key? key}) : super(key: key);
  String userId;
  TextEditingController x = TextEditingController();
  edituserprofile(this.userId);

  @override
  State<edituserprofile> createState() => _edituserprofileState();
}

showSnackBar(String message, Duration duration) {
  final snackBar = SnackBar(content: Text(message), duration: duration);
  // ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

// getuserinfo() async {
//   final ref =
//       FirebaseFirestore.instance.collection("userdata").doc("$Widget.userId");
//   ref.get().then((DocumentSnapshot doc) {
//     print(doc.data());
//   });
// }

bool showpassword = false;

class _edituserprofileState extends State<edituserprofile> {
  File? pickfile;
  final picker = ImagePicker();

  String get img => img;

  Future selectFile() async {
    final XFile? pickedImage =
        await picker.pickImage(source: ImageSource.gallery);
    // ignore: unnecessary_nullable_for_final_variable_declarations
    final File? pickedImageFile = File(pickedImage!.path);
    // final  pickedImageFile = pickedImage!.path;

    setState(() {
      if (pickedImage != null) {
        pickfile = pickedImageFile as File?;
      } else {
        showSnackBar("No Image Selected", const Duration(milliseconds: 500));
      }
    });

    final postid = DateTime.now().millisecondsSinceEpoch.toString();
    final ref = FirebaseStorage.instance
        .ref()
        .child("${widget.userId}/images")
        .child("post_$postid");
    await ref.putFile(pickfile!);
    print("${widget.userId}");
    FirebaseFirestore.instance
        .collection("userdata")
        .doc("${widget.userId}")
        .update({"user profile url": await ref.getDownloadURL()});
    showSnackBar("Image Selected and uploaded successfully",
        Duration(milliseconds: 500));

    setState(() {
      String img = ref.getDownloadURL().toString();
    });
    // Navigator.pop(context);
  }

  // @override
  // void initstate() {
  //   getuserinfo();
  //   super.initState();
  // }

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController phone = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: navbar("${widget.userId}"),
      appBar: AppBar(
        title: const Text("Edit User Profile"),
        backgroundColor: Color.fromARGB(255, 195, 155, 254),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            Center(
              child: Stack(
                children: [
                  // SizedBox(height: 20),
                  Container(
                    width: 180,
                    height: 180,
                    decoration: BoxDecoration(
                      border: Border.all(
                          width: 4,
                          color: Theme.of(context).scaffoldBackgroundColor),
                      boxShadow: [
                        BoxShadow(
                          spreadRadius: 2,
                          blurRadius: 10,
                          color: Colors.black.withOpacity(0.1),
                          offset: Offset(0, 10),
                        ),
                      ],
                      shape: BoxShape.circle,
                      image: const DecorationImage(
                        image: NetworkImage(
                            ""),
                            fit:BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () {
                          selectFile();
                        },
                        child: Container(
                          child: Icon(Icons.edit),
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 4,
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),
                            color: Color.fromARGB(255, 195, 155, 254),
                          ),
                        ),
                      ))
                ],
              ),
            ),
            const SizedBox(height: 40),
            buildTextField("User Name", "Dev Patel", false, name),
            buildTextField("Email", "abc@gmail.com", false, email),
            buildTextField("Password", "******", true, password),
            buildTextField("Phone no.", "10 digits no.", false, phone),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Map<String, dynamic> input = {
                      "email": email.text,
                      "name": name.text,
                      "phone": phone.text,
                    };
                    FirebaseFirestore.instance
                        .collection("userdata")
                        .doc(email.text)
                        .set(input)
                        .then((value) => showSnackBar(
                            "Userdata Updated Successfully",
                            Duration(milliseconds: 500)));
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 195, 155, 254),
                    primary: Colors.white,
                    onSurface: Colors.grey,
                  ),
                  child: const Text(
                    "SAVE",
                    style: TextStyle(
                      fontSize: 16,
                      letterSpacing: 2.2,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildTextField(String labelText, String placeholder, bool ispassword,
      TextEditingController x) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextField(
        controller: x,
        obscureText: ispassword ? showpassword : false,
        decoration: InputDecoration(
          suffixIcon: ispassword
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      showpassword = !showpassword;
                    });
                  },
                  icon: const Icon(Icons.remove_red_eye),
                  color: Color.fromARGB(255, 195, 155, 254),
                )
              : null,
          contentPadding: const EdgeInsets.only(bottom: 3),
          labelText: labelText,
          hintText: placeholder,
          floatingLabelBehavior: FloatingLabelBehavior.always,
        ),
      ),
    );
  }
}
