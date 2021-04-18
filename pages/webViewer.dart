import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:query_loader_app/models/content.dart';
import 'package:webview_flutter/webview_flutter.dart';



class WebViewer extends StatelessWidget {

  final String url;
  final String author;

  WebViewer({this.url, this.author});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(author),
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: IconButton(
              icon: Icon(Icons.arrow_back),
            ),
          ),
        ),
        body: WebView(
          initialUrl: url,
        ),
      ),
    );
  }

}