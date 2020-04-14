import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsPage extends StatefulWidget {
  @override
  _ContactUsPageState createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Contact Us',
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
        backgroundColor: Colors.white,
        body: ListView(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height / 4,
              // color: Colors.green,
              padding: EdgeInsets.all(0.0),
              child: Image.asset(
                'farmcartlogo.png',
                fit: BoxFit.cover,
              ),
            ),
            Divider(
              height: 2.0,
              thickness: 2.0,
            ),
            SizedBox(
              height: 8.0,
            ),
            Container(
              height: 64.0,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  InkWell(
                    onTap: () async {
                      String url = 'tel:+919727834644';
                      if (await canLaunch(url)) {
                        await launch(url);
                      } else {
                        throw 'Could not launch $url';
                      }
                    },
                    child: Container(
                      height: 56.0,
                      width: 56.0,
                      child: Image.asset('call.png'),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      String url = 'https://wa.me/919727834644';
                      if (await canLaunch(url)) {
                        await launch(url);
                      } else {
                        throw 'Could not launch $url';
                      }
                    },
                    child: Container(
                      width: 56.0,
                      height: 56.0,
                      child: Image.asset('whatsapp.png'),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      String url =
                          'mailto:hanumantkrupaent@gmail.com?subject=Hello&body=Hello';
                      if (await canLaunch(url)) {
                        await launch(url);
                      } else {
                        throw 'Could not launch $url';
                      }
                    },
                    child: Container(
                      height: 56.0,
                      width: 56.0,
                      child: Image.asset('email.png'),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 16.0,
            ),
            ListTile(
              leading: Icon(Icons.location_city),
              title: Text('Address'),
              subtitle: Text(
                  'sudama park plot no.70 bokhira jubeli porbandar gujarat'),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.email),
              title: Text('Email Address'),
              subtitle: Text('hanumantkrupaent@gmail.com'),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.phone_android),
              title: Text('Phone number'),
              subtitle: Text('+91-9727834644'),
            ),
          ],
        ),
      ),
    );
  }
}
