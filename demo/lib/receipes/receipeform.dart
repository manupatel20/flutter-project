import 'dart:io';
import 'package:http/http.dart';

import '../login_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';

import '../navbar.dart';

class receipeform extends StatefulWidget {
  String userId;
  receipeform(this.userId);
  // const receipeform({Key? key, this.userId}) : super(key: key);

  @override
  State<receipeform> createState() => _receipeformState();
}

class _receipeformState extends State<receipeform> {
  // String? get userId => userId;

  Future uploadFile() async {

    final postid = DateTime.now().millisecondsSinceEpoch.toString();
    final ref = FirebaseStorage.instance.ref().child("${widget.userId}/images").child("post_$postid");
    await ref.putFile(pickfile!);

    Map<String, dynamic> input = {
      "Recipe Description": rdesc.text,
      "Receipe Name": rname.text,
      "Receipe Ingridents": rind.text,
      "Receipe Steps": rsteps.text,
      "Receipe Image": await ref.getDownloadURL(),
    };
    FirebaseFirestore.instance.collection("userreceipes").doc("${widget.userId}").set(input);
    print("${widget.userId}");
    showSnackBar("Receipe uploaded successfully", Duration(milliseconds: 500));
  }

  showSnackBar(String message, Duration duration) {
    final snackBar = SnackBar(content: Text(message), duration: duration);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  File? pickfile;
  final picker = ImagePicker();

  Future selectFile() async {
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    final pickedImageFile = File(pickedImage!.path);

    setState(() {
      if (pickedImage != null) {
        pickfile = pickedImageFile;
      } else {
        showSnackBar("No Image Selected", Duration(milliseconds: 500));
      }
    });
    // Navigator.pop(context);
  }

  TextEditingController rname = TextEditingController();
  TextEditingController rdesc = TextEditingController();
  TextEditingController rind = TextEditingController();
  TextEditingController rsteps = TextEditingController();
  TextEditingController rimage = TextEditingController();

  @override
  
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: navbar("$Widget.userId"),
      appBar: AppBar(
        title: Text("Receipe Form"),
        backgroundColor: Color.fromARGB(255, 195, 155, 254),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            SizedBox(height: 100),
            Text(
              "Add Receipe",
              style: TextStyle(
                fontSize: 30,
                color: Color.fromARGB(255, 195, 155, 254),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: 300,
              child: TextField(
                controller: rname,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Receipe Name',
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: 300,
              child: TextField(
                controller: rdesc,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Receipe Description',
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: 300,
              child: TextField(
                controller: rind,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Receipe Ingredients',
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: 300,
              child: TextField(
                controller: rsteps,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Receipe Steps',
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 20,
            ),

            ElevatedButton(
              onPressed: selectFile,
              child: Text("Add Receipe Image"),
              style: ElevatedButton.styleFrom(
                textStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                primary: Color.fromARGB(255, 195, 155, 254),
                onPrimary: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32.0),
                  
                ),
              ),
            ),
            SizedBox(height: 20),

            ElevatedButton(
              onPressed: uploadFile,
              child: Text("Upload Receipe"),
              style: ElevatedButton.styleFrom(
                textStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                primary: Color.fromARGB(255, 195, 155, 254),
                onPrimary: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32.0),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
