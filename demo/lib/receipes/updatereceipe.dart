import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';

import '../navbar.dart';

class updatereceipe extends StatefulWidget {
  String docid , userId;
  updatereceipe(this.docid , this.userId);
  // const updatereceipe({Key? key}) : super(key: key);

  @override
  State<updatereceipe> createState() => _updatereceipeState();
}

class _updatereceipeState extends State<updatereceipe> {

  Future uploadFile() async {
    final postid = DateTime.now().millisecondsSinceEpoch.toString();
    final ref = FirebaseStorage.instance
        .ref()
        .child("${widget.userId}/images")
        .child("post_$postid");
    await ref.putFile(pickfile!);

    Map<String, dynamic> input = {
      if(rdesc.text.isNotEmpty) "Receipe Description": rdesc.text,
      if(rname.text.isNotEmpty) "Receipe Name": rname.text,
      if(rind.text.isNotEmpty) "Receipe Ingridents": rind.text,
      if(rsteps.text.isNotEmpty) "Receipe Steps": rsteps.text,
      
      "Receipe Image": await ref.getDownloadURL(),
      "email": "${widget.userId}",
    };
    FirebaseFirestore.instance.collection("userreceipes").doc(widget.docid).update(input );//Represents a Cloud Firestore database and is the entry point for all Cloud Firestore operations.
    // FirebaseFirestore.instance.collection("userreceipes").add(input);
    print("${widget.userId}");
    showSnackBar("Receipe uploaded successfully", Duration(milliseconds: 500));
  }

  showSnackBar(String message, Duration duration) {//Shows a SnackBar across all registered Scaffolds.A scaffold can show at most one snack bar at a time. If this function is called while another snack bar is already visible, the given snack bar will be added to a queue and displayed after the earlier snack bars have closed.
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
        showSnackBar("No Image Selected", Duration(milliseconds: 500));//Shows a SnackBar across all registered Scaffolds.A scaffold can show at most one snack bar at a time. If this function is called while another snack bar is already visible, the given snack bar will be added to a queue and displayed after the earlier snack bars have closed.
      }
    });
    // Navigator.pop(context);
  }

  /*A controller for an editable text field.Whenever the user modifies a text field with an associated TextEditingController, the text field updates value and the controller notifies its listeners. Listeners can then read the text and selection properties to learn what the user has typed or how the selection has been updated */
  TextEditingController rname = TextEditingController();
  TextEditingController rdesc = TextEditingController();
  TextEditingController rind = TextEditingController();
  TextEditingController rsteps = TextEditingController();
  TextEditingController rimage = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: navbar("${widget.userId}"),//A Material Design panel that slides in horizontally from the edge of a Scaffold to show navigation links in an application.
      appBar: AppBar( //App bars are typically used in the Scaffold.appBar property, which places the app bar as a fixed-height widget at the top of the screen.
        title: Text("Kitchen Diaries"),
        backgroundColor: Color.fromARGB(255, 195, 155, 254),
      ),
      body: SingleChildScrollView(/*SingleChildScrollView - A box in which a single widget can be scrolled.
    This widget is useful when you have a single box that will normally be entirely visible,
     but you need to make sure it can be scrolled if the container gets too small in one axis
     (the scroll direction).It is also useful if you need to shrink-wrap in both axes
     (the main scrolling direction as well as the cross axis), as one might see in a dialog or pop-up menu.*/
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            SizedBox(height: 100),
            Text(
              "Update Receipe",
              style: TextStyle(
                fontSize: 30,
                color: Color.fromARGB(255, 195, 155, 254),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container( //A convenience widget that combines common painting, positioning, and sizing widgets.
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
            Container( //A convenience widget that combines common painting, positioning, and sizing widgets.
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
            Container( //A convenience widget that combines common painting, positioning, and sizing widgets.
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
