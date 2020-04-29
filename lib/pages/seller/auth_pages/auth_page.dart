import 'package:farmcart/pages/seller/auth_pages/login_page.dart';
import 'package:farmcart/pages/seller/auth_pages/signup_page.dart';
import 'package:farmcart/pages/home_page/home_page.dart';
import 'package:farmcart/pages/seller/seller_home_page.dart';
import 'package:farmcart/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class AuthPage extends StatefulWidget {
  // final bool isSeller;

  // const AuthPage({Key key, this.isSeller}) : super(key: key);

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final AuthService _authService = Provider.of<AuthService>(context);

    return FutureBuilder<Map<String, dynamic>>(
      future: _authService.getUserDetails(),
      builder: (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data['isLoggedIn']) {
            return SellerHomePage();
          } else {
            return SafeArea(
              child: Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.white,
                  elevation: 0,
                  title: Text(
                    'BACK',
                    style: GoogleFonts.lato(
                      textStyle: Theme.of(context).textTheme.button.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor,
                          ),
                    ),
                  ),
                  titleSpacing: 0.0,
                  iconTheme: IconThemeData(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                backgroundColor: Colors.yellow.shade100,
                body: Form(
                  key: _formKey,
                  child: ListView(
                    padding: EdgeInsets.all(16.0),
                    children: <Widget>[
                      LogoWidget(),
                      SizedBox(
                        height: 32.0,
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: Text(
                          'લોગીન',
                          style: GoogleFonts.lato(
                            textStyle:
                                Theme.of(context).textTheme.headline.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).primaryColor,
                                    ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      Container(
                        child: TextFormField(
                          decoration: InputDecoration(
                            // border: OutlineInputBorder(),
                            filled: true,
                            prefixIcon: Icon(Icons.phone_android),
                            labelText: 'યુઝરનેમ',
                          ),
                          controller: _usernameController,
                          onSaved: (value) {},
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'યુઝરનેમ ખાલી ના હોવું જોઈએ.';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      Container(
                        child: TextFormField(
                          decoration: InputDecoration(
                            // border: OutlineInputBorder(),
                            filled: true,
                            prefixIcon: Icon(Icons.lock),
                            labelText: 'પાસવર્ડ',
                          ),
                          controller: _passwordController,
                          onSaved: (value) {},
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'પાસવર્ડ ખાલી ના હોવો જોઈએ.';
                            }
                            return null;
                          },
                          obscureText: true,
                        ),
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      Container(
                        child: RaisedButton(
                          padding: EdgeInsets.symmetric(
                            vertical: 16.0,
                          ),
                          color: Theme.of(context).primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: _isLoading
                              ? Center(
                                  child: Container(
                                    height: 16.0,
                                    width: 16.0,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2.0,
                                      valueColor: AlwaysStoppedAnimation(
                                        Theme.of(context).primaryColor,
                                      ),
                                      backgroundColor: Colors.white,
                                    ),
                                  ),
                                )
                              : Text(
                                  'લોગીન',
                                  style: GoogleFonts.lato(
                                    textStyle: Theme.of(context)
                                        .textTheme
                                        .title
                                        .copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                  ),
                                ),
                          onPressed: () async {
                            setState(() {
                              _isLoading = true;
                            });
                            if (_formKey.currentState.validate()) {
                              String username = _usernameController.text;
                              String password = _passwordController.text;
                              _usernameController.text = '';
                              _passwordController.text = '';
                              bool _loggedIn =
                                  await _authService.signIn(username, password);
                              if (_loggedIn) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SellerHomePage(),
                                  ),
                                );
                              } else {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text('ERROR'),
                                        content: Text(
                                            'Username or password is incorrect. Try again.'),
                                      );
                                    });
                              }
                            }
                            setState(() {
                              _isLoading = false;
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        height: 32.0,
                      ),
                      Container(
                        // margin: EdgeInsets.symmetric(horizontal: 32.0),
                        child: RaisedButton(
                          padding: EdgeInsets.symmetric(
                            vertical: 16.0,
                          ),
                          color: Theme.of(context).accentColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: Text(
                            'નવા રજીસ્ટ્રેશન માટે ક્લીક કરો',
                            style: GoogleFonts.lato(
                              textStyle:
                                  Theme.of(context).textTheme.title.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignupPage(),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        } else {
          return SafeArea(
            child: Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }
      },
    );
  }
}

class LogoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      width: 100.0,
      // color: Colors.green,
      // padding: EdgeInsets.all(16.0),
      child: Image.asset(
        'farmcartlogo_new.png',
        fit: BoxFit.contain,
      ),
    );
  }
}
