import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter/webview_flutter.dart';

class receipeview extends StatefulWidget {
  // const receipeview({Key? key}) : super(key: key);

  String url;
  receipeview(this.url);
  @override
  State<receipeview> createState() => _receipeviewState();
}

class _receipeviewState extends State<receipeview> {

late String finalurl;
@override
  void initState() {
    if(widget.url.toString().contains("http://")){
      finalurl = widget.url.toString().replaceAll("http://", "https://");
    }else{
      finalurl = widget.url;
    }
    super.initState();
  }


final Completer<WebViewController> controller = Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(/*Implements the basic Material Design visual layout structure.This class provides APIs for showing drawers and bottom sheets.*/
      appBar: AppBar(//App bars are typically used in the Scaffold.appBar property, which places the app bar as a fixed-height widget at the top of the screen.
        title: Text("Food Recipes"),
      ),
      body: Container(//A convenience widget that combines common painting, positioning, and sizing widgets.
        child: WebView(
          initialUrl: finalurl,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController){
            controller.complete(webViewController);
          },
        ),
      ),
    );
  }
}
