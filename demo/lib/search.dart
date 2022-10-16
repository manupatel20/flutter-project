import 'dart:convert';
import 'dart:developer';
import 'package:demo/HomePage.dart';
import 'package:demo/receipeview.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'Model.dart';
import 'package:clock/clock.dart';

class search extends StatefulWidget {
  // const search({Key? key}) : super(key: key);

  String query , userId;
  search(this.query , this.userId);

  @override
  State<search> createState() => _searchState();
}

class _searchState extends State<search> {
  showSnackBar(String message, Duration duration) { //Shows a SnackBar across all registered Scaffolds.A scaffold can show at most one snack bar at a time. If this function is called while another snack bar is already visible, the given snack bar will be added to a queue and displayed after the earlier snack bars have closed.
    final snackBar = SnackBar(content: Text(message), duration: duration);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  bool isLoading = true;

  List<ReceipeModel> receipes = <ReceipeModel>[];

  getreceipe(String query) async {
    String url =
        "https://api.edamam.com/search?q=$query&app_id=cac09239&app_key=2a0165b7a3909e97cc9cecf161d66653";// fetching recipes from API
    http.Response response = await http.get(Uri.parse(url));
    Map data = jsonDecode(response.body);
    // log(data.toString());

    data["hits"].forEach((element) {
      ReceipeModel receipeModel = new ReceipeModel();
      receipeModel = ReceipeModel.fromMap(element["recipe"]);
      receipes.add(receipeModel);

      setState(() {
        isLoading = false;
      });
      // log(receipes.toString());
    });

    receipes.forEach((receipes) {
      print(receipes.label);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getreceipe(widget.query);
  }

  @override
  Widget build(BuildContext context) {
    /*A controller for an editable text field.Whenever the user modifies a text field with an associated TextEditingController, the text field updates value and the controller notifies its listeners. Listeners can then read the text and selection properties to learn what the user has typed or how the selection has been updated */
    TextEditingController searchController = TextEditingController();
    return Scaffold(
      /*Implements the basic Material Design visual layout structure.This class provides APIs for showing drawers and bottom sheets.*/
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          /*SingleChildScrollView - A box in which a single widget can be scrolled.
          This widget is useful when you have a single box that will normally be entirely visible,
          but you need to make sure it can be scrolled if the container gets too small in one axis
          (the scroll direction).It is also useful if you need to shrink-wrap in both axes
          (the main scrolling direction as well as the cross axis), as one might see in a dialog or pop-up menu.*/
          child: Column(
            children: [
              Container(//A convenience widget that combines common painting, positioning, and sizing widgets.
                padding: EdgeInsets.symmetric(horizontal: 8),
                margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 195, 155, 254),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    GestureDetector(/*By default a GestureDetector with an invisible child ignores touches; this behavior can be controlled with behavior
                    Detects various gestures and events using the supplied MotionEvents. The OnGestureListener callback will notify users when a particular motion event has occurred.*/
                        onTap: () {
                          if ((searchController.text).replaceAll(" ", "") ==
                              "") {
                            print("Blank search");
                            showSnackBar(
                                "Blank search is not Valid...please enter some text",
                                Duration(milliseconds: 500));
                          } else {
                            Navigator.pushReplacement(//Navigator helps us navigate to new route. Navigator.push() method is used to switch to a new route.
                                context,
                                MaterialPageRoute(//MaterialPageRoute - A modal route that replaces the entire screen with a platform-adaptive transition. By default, when a modal route is replaced by another, the previous route remains in memory.
                                  builder: (context) =>
                                      search(searchController.text , "${widget.userId}"),
                                ));
                          }
                        },
                        child: Icon(Icons.search)),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        hintText: "Search Receipe",
                        border: InputBorder.none,
                      ),
                    ))
                  ],
                ),
              ),
              SingleChildScrollView(/*SingleChildScrollView - A box in which a single widget can be scrolled.
              This widget is useful when you have a single box that will normally be entirely visible,
               but you need to make sure it can be scrolled if the container gets too small in one axis
               (the scroll direction).It is also useful if you need to shrink-wrap in both axes
               (the main scrolling direction as well as the cross axis), as one might see in a dialog or pop-up menu.*/
                child: Container(//A convenience widget that combines common painting, positioning, and sizing widgets.
                  child: isLoading
                      ? CircularProgressIndicator()
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: receipes.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(//Navigator helps us navigate to new route. Navigator.push() method is used to switch to a new route.
                                    context,
                                    MaterialPageRoute(//MaterialPageRoute - A modal route that replaces the entire screen with a platform-adaptive transition. By default, when a modal route is replaced by another, the previous route remains in memory.
                                      builder: (context) =>
                                          receipeview(receipes[index].url),
                                    ));
                              },
                              child: Card(
                                margin: EdgeInsets.all(20),
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
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                          height: 200,
                                          receipes[index].image),
                                    ),
                                    Positioned(
                                      child: Container(
                                          padding: EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.black26,
                                          ),
                                          child: Text(
                                            receipes[index].label,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                            ),
                                          )),
                                      right: 0,
                                      left: 0,
                                      bottom: 0,
                                    ),
                                    Positioned(
                                      right: 0,
                                      height: 30,
                                      width: 80,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                        ),
                                        child: Center(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(Icons.local_fire_department,
                                                  size: 20),
                                              Text(
                                                receipes[index]
                                                    .calories
                                                    .toString()
                                                    .substring(0, 4),
                                                style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 0, 0, 0),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                            // color: Colors.red;
                          },
                        ),
                ),
              ),
              ButtonBar(
                alignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  HomePage("${widget.userId}")));
                    },
                    child: const Text('Back'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
