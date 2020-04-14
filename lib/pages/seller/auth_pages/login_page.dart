import 'package:farmcart/pages/seller/auth_pages/auth_page.dart';
import 'package:farmcart/pages/home_page/home_page.dart';
import 'package:farmcart/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;

  // final TextEditingController _addressController = TextEditingController();
  // final TextEditingController _pincodeController = TextEditingController();
  // final TextEditingController _emailController = TextEditingController();
  // final TextEditingController _phoneController = TextEditingController();
  // final TextEditingController _alternatephoneController =
  //     TextEditingController();
  // final TextEditingController _birthdateController = TextEditingController();
  // final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final AuthService _authService = Provider.of<AuthService>(context);

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
        backgroundColor: Colors.white,
        body: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.all(16.0),
            children: <Widget>[
              LogoWidget(),
              Container(
                alignment: Alignment.center,
                child: Text(
                  'LOGIN',
                  style: GoogleFonts.lato(
                    textStyle: Theme.of(context).textTheme.headline.copyWith(
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
                    border: OutlineInputBorder(),
                    labelText: 'Phone Number',
                  ),
                  controller: _usernameController,
                  onSaved: (value) {},
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Phone number can not be empty';
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
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                  controller: _passwordController,
                  onSaved: (value) {},
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Password can not be empty';
                    }
                    return null;
                  },
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
                          'LOGIN',
                          style: GoogleFonts.lato(
                            textStyle:
                                Theme.of(context).textTheme.subhead.copyWith(
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
                            builder: (context) => HomePage(),
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
            ],
          ),
        ),
      ),
    );
  }
}
