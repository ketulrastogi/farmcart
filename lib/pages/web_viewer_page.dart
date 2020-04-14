import 'package:easy_web_view/easy_web_view.dart';
import 'package:easy_web_view/easy_web_view.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WebViewerPage extends StatefulWidget {
  final String title;
  final String url;

  const WebViewerPage({Key key, this.title, this.url}) : super(key: key);
  @override
  _WebViewerPageState createState() => _WebViewerPageState();
}

class _WebViewerPageState extends State<WebViewerPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.title,
            style: GoogleFonts.lato(
              textStyle: Theme.of(context).textTheme.title.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
            ),
          ),
          titleSpacing: 0.0,
          elevation: 1.0,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(
              // color: Colors.black,
              ),
        ),
        body: EasyWebView(
          src: widget.url,

          isHtml: false, // Use Html syntax
          isMarkdown: false, // Use markdown syntax
          convertToWidets: false, // Try to convert to flutter widgets
          // width: 100,
          // height: 100,
        ),
      ),
    );
  }
}
