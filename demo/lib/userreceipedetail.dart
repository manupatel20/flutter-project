import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/receipes/receipeform.dart';
import 'package:demo/receipes/updatereceipe.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

import 'login_page.dart';
import 'navbar.dart';

class User {
  late String ReceipeName;
  late String ReceipeDescription;
  late String ReceipeIngredients;
  late String ReceipeSteps;
}

class details extends StatefulWidget {
  // const details({Key? key}) : super(key: key);
  String userId, ReceipeName;
  bool delete = false;
  details(this.userId, this.ReceipeName, this.delete);

  @override
  State<details> createState() => _detailsState();
}

class _detailsState extends State<details> {
  @override
  void initState() {
    String url = FirebaseFirestore.instance
        .collection("userreceipes")
        .doc("${widget.userId}")
        .snapshots()
        .toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(/*Implements the basic Material Design visual layout structure.This class provides APIs for showing drawers and bottom sheets.*/
      drawer: navbar("${widget.userId}"),
      appBar: AppBar(
        title: Text(
          "Kitchen Diaries",
          style: GoogleFonts.balooPaaji2( // Import google fonts
            textStyle: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              // fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 195, 155, 254),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(//Navigator helps us navigate to new route. Navigator.push() method is used to switch to a new route.
                context,
                MaterialPageRoute(//MaterialPageRoute - A modal route that replaces the entire screen with a platform-adaptive transition. By default, when a modal route is replaced by another, the previous route remains in memory.
                  builder: (context) => receipeform("${widget.userId}"),
                ),
              );
            },
            icon: const Icon(Icons.food_bank_rounded),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(//Navigator helps us navigate to new route. Navigator.push() method is used to switch to a new route.
                context,
                MaterialPageRoute(//MaterialPageRoute - A modal route that replaces the entire screen with a platform-adaptive transition. By default, when a modal route is replaced by another, the previous route remains in memory.
                  builder: (context) => const LoginPage(),
                ),
              );
            },
            icon: const Icon(Icons.login),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(/*SingleChildScrollView - A box in which a single widget can be scrolled.
    This widget is useful when you have a single box that will normally be entirely visible,
     but you need to make sure it can be scrolled if the container gets too small in one axis
     (the scroll direction).It is also useful if you need to shrink-wrap in both axes
     (the main scrolling direction as well as the cross axis), as one might see in a dialog or pop-up menu.*/
          child: Column(
            children: [
              StreamBuilder(//Widget that builds itself based on the latest snapshot of interaction with a Stream.
                  stream: FirebaseFirestore.instance
                      .collection("userreceipes")
                      .where('Receipe Name', isEqualTo: "${widget.ReceipeName}")
                      // .doc("${widget.userId}").collection("ReceipeImage")
                      .snapshots(),
                  builder: (context,
                      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                          snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),//A Material Design circular progress indicator, which spins to indicate that the application is busy.
                      );
                    } else {
                      return ListView.builder(//A scrollable list of widgets arranged linearly.
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),//Scroll physics that does not allow the user to scroll.
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          DocumentSnapshot documentSnapshot =
                              snapshot.data!.docs[index];
                          return Container(
                            child: Column(
                              children:<Widget> [
                                // Image.network(documentSnapshot["Receipe Image"]),
                                Container(//A convenience widget that combines common painting, positioning, and sizing widgets.
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8),
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 20, horizontal: 20),
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                    // border:Border.all(color: Color.fromARGB(255, 152, 119, 202), width: 2),
                                    // color: const Color.fromARGB(
                                    //     255, 195, 155, 254),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Row(
                                    children: [
                                      Flexible(
                                        child: Column(
                                          children: [
                                            
                                            Text("Recipe Name:\n "+documentSnapshot["Receipe Name"],
                                                style: GoogleFonts.balooPaaji2(
                                                  textStyle: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 20,
                                                    // fontWeight: FontWeight.bold,
                                                  ),
                                                )),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8),
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 20, horizontal: 20),
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                    // border:Border.all(color: Color.fromARGB(255, 59, 26, 107), width: 2),
                                    // color: const Color.fromARGB(
                                    //     255, 195, 155, 254),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Row(
                                    children: [
                                      Flexible(
                                        child: Column(
                                          children: [
                                            
                                            // ignore: prefer_interpolation_to_compose_strings
                                            Text("Recipe Description:\n "+
                                                documentSnapshot[
                                                    "Receipe Description"],
                                                style: GoogleFonts.balooPaaji2(
                                                  textStyle: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 20,
                                                    // fontWeight: FontWeight.bold,
                                                  ),
                                                )),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(//A convenience widget that combines common painting, positioning, and sizing widgets.
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8),
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 20, horizontal: 20),
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Row(
                                    children: [
                                      Flexible(
                                        child: Column(
                                          children: [
                                            Text(
                                                // ignore: prefer_interpolation_to_compose_strings
                                                'Recipe Ingredients: \n' +
                                                    documentSnapshot[
                                                        "Receipe Ingridents"],
                                                // overflow: TextOverflow.ellipsis,
                                                style:
                                                    GoogleFonts.balooPaaji2(
                                                  textStyle: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 20,
                                                    // fontWeight: FontWeight.bold,
                                                  ),
                                                )),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8),
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 20, horizontal: 20),
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                    // border:Border.all(color: Color.fromARGB(255, 59, 26, 107), width: 2),
                                    // color: const Color.fromARGB(
                                    //     255, 195, 155, 254),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Row(
                                    children: [
                                      
                                      // ignore: prefer_interpolation_to_compose_strings
                                      Text("Recipe Steps:\n"+documentSnapshot["Receipe Steps"],
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.balooPaaji2(
                                            textStyle: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 20,
                                              // fontWeight: FontWeight.bold,
                                            ),
                                          )),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8),
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 20, horizontal: 20),
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                    // border:Border.all(color: Color.fromARGB(255, 59, 26, 107), width: 2),
                                    // color: const Color.fromARGB(
                                    //     255, 195, 155, 254),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Row(
                                    children: [
                                      Text("Recipe Image: ",
                                          style: GoogleFonts.balooPaaji2(
                                            textStyle: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 20,
                                              // fontWeight: FontWeight.bold,
                                            ),
                                          )),
                                      Image.network(//Creates a widget that displays an ImageStream obtained from the network.
                                        documentSnapshot["Receipe Image"],
                                        height: 200,
                                        width: 200,
                                        fit: BoxFit.cover,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                Column(
                                  children: <Widget>[
                                    if (widget.delete == true)
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.push(////Navigator helps us navigate to new route. Navigator.push() method is used to switch to a new route.
                                              context,
                                              MaterialPageRoute(//MaterialPageRoute - A modal route that replaces the entire screen with a platform-adaptive transition. By default, when a modal route is replaced by another, the previous route remains in memory.
                                                builder: (context) =>
                                                    updatereceipe(
                                                  documentSnapshot.id,
                                                  "${widget.userId}",
                                                ),
                                              ));
                                        },
                                        child: const Text("Update"),
                                      ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    if (widget.delete == true)
                                      ElevatedButton(
                                        onPressed: () {
                                          FirebaseFirestore.instance
                                              .collection("userreceipes")
                                              .doc(documentSnapshot.id)
                                              .delete();
                                          Navigator.pop(context);
                                        },
                                        child: const Text("Delete"),
                                      ),
                                  ],
                                )
                              ],
                            ),
                          );
                        },
                      );
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
