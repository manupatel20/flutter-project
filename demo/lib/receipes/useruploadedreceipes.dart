import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/receipes/receipeform.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

import '../login_page.dart';
import '../navbar.dart';
import '../search.dart';
import '../userreceipedetail.dart';

class useruploadedreceipes extends StatefulWidget {
  String userId;
  useruploadedreceipes(this.userId);
  // const useruploadedreceipes({Key? key}) : super(key: key);

  @override
  State<useruploadedreceipes> createState() => _useruploadedreceipesState();
}

class _useruploadedreceipesState extends State<useruploadedreceipes> {
  @override
  Widget build(BuildContext context) {
    // QueryDocumentSnapshot querysnapshot = FirebaseFirestore().collection('userreceipes').get();
    return Scaffold(/*Implements the basic Material Design visual layout structure.This class provides APIs for showing drawers and bottom sheets.*/
      drawer: navbar("${widget.userId}"),//A Material Design panel that slides in horizontally from the edge of a Scaffold to show navigation links in an application.
      appBar: AppBar(//App bars are typically used in the Scaffold.appBar property, which places the app bar as a fixed-height widget at the top of the screen.
        title: Text(
          "Kitchen Diaries",
          style: GoogleFonts.balooPaaji2(
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
              StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('userreceipes')
                      .where('email', isEqualTo: "${widget.userId}")
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            QueryDocumentSnapshot x =
                                snapshot.data!.docs[index];
                            return InkWell(
                              onTap: () {
                                Navigator.push(//Navigator helps us navigate to new route. Navigator.push() method is used to switch to a new route.
                                    context,
                                    MaterialPageRoute(//MaterialPageRoute - A modal route that replaces the entire screen with a platform-adaptive transition. By default, when a modal route is replaced by another, the previous route remains in memory.
                                      builder: (context) => details(
                                          "${widget.userId}",
                                          x['Receipe Name'],
                                          true),
                                    ));
                              },
                              child: Card(
                                  margin: const EdgeInsets.all(20),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  elevation: 0.0,
                                  child: Stack(
                                    children: [
                                      ClipRRect(/*A widget that clips its child using a rounded rectangle.
                                     By default, ClipRRect uses its own bounds as the base rectangle for the clip, but the size and location of the clip can be customized using a custom clipper.*/
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.network(
                                          x['Receipe Image'],
                                          height: 300,
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Positioned(
                                        right: 0,
                                        left: 0,
                                        bottom: 0,
                                        child: Container(//A convenience widget that combines common painting, positioning, and sizing widgets.
                                            padding: const EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: Colors.black26,
                                            ),
                                            child: Text(
                                              snapshot.data!.docs[index]
                                                  ['Receipe Name'],
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                              ),
                                            )),
                                      ),
                                      Positioned(
                                        right: 0,
                                        height: 30,
                                        width: 80,
                                        child: Container(//A convenience widget that combines common painting, positioning, and sizing widgets.
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: const Color.fromARGB(
                                                255, 255, 255, 255),
                                          ),
                                          child: Center(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const Icon(
                                                    Icons.local_fire_department,
                                                    size: 20),
                                                Text(
                                                  snapshot
                                                      .data!
                                                      .docs[index]
                                                          ['Receipe Calories']
                                                      .toString(),
                                                  style: const TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 0, 0, 0),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  )),
                            );
                          });
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
