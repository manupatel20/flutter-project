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
    return Scaffold(
      drawer: navbar("${widget.userId}"),
      appBar: AppBar(
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
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => receipeform("${widget.userId}"),
                ),
              );
            },
            icon: const Icon(Icons.food_bank_rounded),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginPage(),
                ),
              );
            },
            icon: const Icon(Icons.login),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              StreamBuilder(
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
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          DocumentSnapshot documentSnapshot =
                              snapshot.data!.docs[index];
                          return Container(
                            child: Column(
                              children:<Widget> [
                                // Image.network(documentSnapshot["Receipe Image"]),
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
                                      Image.network(
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
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
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
