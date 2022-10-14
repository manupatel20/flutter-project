import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../search.dart';

class reviews extends StatefulWidget {
  String userId;
  reviews(this.userId); 
  // const reviews({Key? key}) : super(key: key);

  @override
  State<reviews> createState() => _reviewsState();
}

class _reviewsState extends State<reviews> {
  @override
  Widget build(BuildContext context) {

    TextEditingController input = TextEditingController();

    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 195, 155, 254),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    GestureDetector(
                        onTap: () {
                          if ((input.text).replaceAll(" ", "") ==
                              "") {
                            print("Blank search");
                            
                          } else {
                            // getreceipe(searchController.text);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                       search(input.text , "${widget.userId}"),
                                ));
                          }
                        },
                        child: const Icon(Icons.search)),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: TextField(
                      controller: input,
                      decoration: const InputDecoration(
                        hintText: "Search Receipe",
                        border: InputBorder.none,
                      ),
                    ))
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
