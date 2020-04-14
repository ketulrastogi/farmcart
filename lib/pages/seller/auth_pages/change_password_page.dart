import 'package:farmcart/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ChangePasswordPage extends StatefulWidget {
  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool _loading = false;
  String password;
  String confirmPassword;

  @override
  Widget build(BuildContext context) {
    final AuthService authService = Provider.of<AuthService>(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'વેચાણ',
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
        body: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.all(16.0),
            children: <Widget>[
              Container(
                child: TextFormField(
                  controller: passwordController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Password can not be empty.';
                    } else if (value != confirmPasswordController.text) {
                      return 'Password and confirm password are not same.';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    filled: true,
                    labelText: 'Password',
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 20.0, horizontal: 12.0),
                  ),
                  obscureText: true,
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              Container(
                child: TextFormField(
                  controller: confirmPasswordController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Confirm password can not be empty.';
                    } else if (value != passwordController.text) {
                      return 'Password and confirm password are not same.';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    filled: true,
                    labelText: 'Confirm Password',
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 20.0, horizontal: 12.0),
                  ),
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
                  child: Text(
                    'SUBMIT',
                    style: GoogleFonts.lato(
                      textStyle: Theme.of(context).textTheme.title.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      password = passwordController.text;
                      try {
                        authService.changePassword(password);
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text('SUCCESS'),
                                content:
                                    Text('Password is changed successfully.'),
                              );
                            });
                        // Navigator.pop(context);
                      } catch (e) {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text('SUCCESS'),
                                content: Text(
                                    'An error occured while changing password.'),
                              );
                            });
                      }
                    }
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
