import 'dart:async';

import 'package:flutter/material.dart';
import 'package:news_app_api/models/country.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleView extends StatefulWidget {
  final String postUrl;
  ArticleView({@required this.postUrl});

  @override
  _ArticleViewState createState() => _ArticleViewState();
}

class _ArticleViewState extends State<ArticleView> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
    String countryCode = Provider.of<Country>(context).countryCode;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "${countries[countryCode]}'s ",
              style:
                  TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
            ),
            Text(
              "News 📰",
              style: TextStyle(
                  color: Theme.of(context).accentColor,
                  fontWeight: FontWeight.w600),
            )
          ],
        ),
        actions: <Widget>[
          Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: IconButton(
                icon: Icon(Icons.share),
                onPressed: () {
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Share Functionality!!',
                      ),
                    ),
                  );
                },
              ))
        ],
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: WebView(
          initialUrl: widget.postUrl,
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          },
        ),
      ),
    );
  }
}
