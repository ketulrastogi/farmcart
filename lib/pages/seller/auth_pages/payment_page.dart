import 'package:easy_web_view/easy_web_view.dart';
import 'package:easy_web_view/easy_web_view.dart';
import 'package:farmcart/pages/seller/auth_pages/auth_page.dart';
import 'package:farmcart/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PaymentPage extends StatefulWidget {
  final Map<String, dynamic> data;

  const PaymentPage({Key key, this.data}) : super(key: key);
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  @override
  Widget build(BuildContext context) {
    final AuthService _authService = Provider.of<AuthService>(context);
    return WillPopScope(
      onWillPop: () {
        _authService.signOut();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AuthPage(),
          ),
        );
        return;
      },
      child: SafeArea(
        child: Scaffold(
          body: EasyWebView(
            src:
                'https://farmcart.in/Pay.aspx?TId=${widget.data['payment_id']}&mo=${widget.data['Contact']}',

            isHtml: false, // Use Html syntax
            isMarkdown: false, // Use markdown syntax
            convertToWidets: false, // Try to convert to flutter widgets
            // width: 100,
            // height: 100,
          ),
        ),
      ),
    );
  }
}
