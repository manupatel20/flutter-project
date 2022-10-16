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
    final ref = FirebaseStorage.instance
        .ref()
        .child("${widget.userId}/images")
        .child("post_$postid");
    await ref.putFile(pickfile!);

    Map<String, dynamic> input = {
      "Receipe Description": rdesc.text,
      "Receipe Name": rname.text,
      "Receipe Ingridents": rind.text,
      "Receipe Steps": rsteps.text,
      "Receipe Image": await ref.getDownloadURL(),
      "Receipe Calories": rcalories.text,
      "email": "${widget.userId}",
    };
    // FirebaseFirestore.instance.collection("userreceipes").doc("${widget.userId}").set(input);
    FirebaseFirestore.instance.collection("userreceipes").add(input);
    print("${widget.userId}");
    showSnackBar("Receipe uploaded successfully", const Duration(milliseconds: 500));
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
        showSnackBar("No Image Selected", const Duration(milliseconds: 500));
      }
    });
    // Navigator.pop(context);
  }

  TextEditingController rname = TextEditingController();
  TextEditingController rdesc = TextEditingController();
  TextEditingController rind = TextEditingController();
  TextEditingController rsteps = TextEditingController();
  TextEditingController rimage = TextEditingController();
  TextEditingController rcalories = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: navbar("${widget.userId}"),
      appBar: AppBar(
        title: const Text("Kitchen Diaries"),
        backgroundColor: const Color.fromARGB(255, 195, 155, 254),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const SizedBox(height: 100),
            const Text(
              "Add Recipe",
              style: TextStyle(
                fontSize: 30,
                color: Color.fromARGB(255, 195, 155, 254),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: 300,
              child: TextField(
                controller: rname,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Recipe Name',
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: 300,
              child: TextField(
                controller: rdesc,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Recipe Description',
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: 300,
              child: TextField(
                controller: rind,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Recipe Ingredients',
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: 300,
              child: TextField(
                controller: rsteps,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Recipe Steps',
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: 300,
              child: TextField(
                controller: rcalories,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Recipe Calories',
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: selectFile,
              child: const Text("Add Receipe Image"),
              style: ElevatedButton.styleFrom(
                textStyle: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                primary: const Color.fromARGB(255, 195, 155, 254),
                onPrimary: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32.0),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: uploadFile,
              child: const Text("Upload Receipe"),
              style: ElevatedButton.styleFrom(
                textStyle: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                primary: const Color.fromARGB(255, 195, 155, 254),
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
