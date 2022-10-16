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
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
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
                                      ClipRRect(
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
                                        child: Container(
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
                                        child: Container(
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
