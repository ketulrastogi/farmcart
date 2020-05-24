import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:farmcart/pages/seller/auth_pages/auth_page.dart';
import 'package:farmcart/pages/seller/my_team_page.dart';
import 'package:farmcart/services/auth_service.dart';
import 'package:farmcart/services/location_service.dart';
import 'package:farmcart/services/my_team_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AddTeamMemberPage extends StatefulWidget {
  @override
  _AddTeamMemberPageState createState() => _AddTeamMemberPageState();
}

class _AddTeamMemberPageState extends State<AddTeamMemberPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  // final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _pincodeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _alternatephoneController =
      TextEditingController();
  final TextEditingController _birthdateController = TextEditingController();

  String selectedUnit;
  String name;
  String address;
  String quantity;
  String message;
  String contactNo;
  String productId;
  bool districtEnabled = false;
  bool talukaEnabled = false;
  bool cityEnabled = false;
  String stateId;
  String districtId;
  String talukaId;
  String villageCityId;
  String pincode;
  String gender;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final AuthService _authService = Provider.of<AuthService>(context);
    final MyTeamService _myTeamService = Provider.of<MyTeamService>(context);
    final LocationService locationService =
        Provider.of<LocationService>(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            'નવા મેમ્બર ઉમેરો',
            style: GoogleFonts.lato(
              textStyle: Theme.of(context).textTheme.title.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).accentColor,
                  ),
            ),
          ),
          titleSpacing: 0.0,
          iconTheme: IconThemeData(
            color: Theme.of(context).accentColor,
          ),
        ),
        backgroundColor: Colors.orange.shade100,
        body: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.all(16.0),
            children: <Widget>[
              // LogoWidget(),
              // Container(
              //   alignment: Alignment.center,
              //   child: Text(
              //     'નવું સેલર એકાઉન્ટ',
              //     style: GoogleFonts.lato(
              //       textStyle: Theme.of(context).textTheme.headline.copyWith(
              //             fontWeight: FontWeight.bold,
              //             color: Theme.of(context).primaryColor,
              //           ),
              //     ),
              //   ),
              // ),
              // SizedBox(
              //   height: 16.0,
              // ),
              Container(
                child: TextFormField(
                  decoration: InputDecoration(
                    // border: OutlineInputBorder(),
                    filled: true,
                    labelText: 'પૂરું નામ',
                  ),
                  controller: _nameController,
                  onSaved: (value) {},
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'પૂરું નામ ખાલી ના હોવું જોઈએ.';
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
                    filled: true,
                    labelText: 'જન્મ તારીખ',
                    hintText: 'DD/MM/YYYY',
                  ),
                  controller: _birthdateController,
                  onSaved: (value) {},
                  // validator: (value) {
                  //   if (value.isEmpty) {
                  //     return 'જન્મ તારીખ ખાલી ના હોવી જોઈએ.';
                  //   }
                  //   return null;
                  // },
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              Container(
                child: DropDownFormField(
                  titleText: 'જાતિ',
                  hintText: 'તમારી જાતિ પસંદ કરો',
                  value: gender,
                  // required: true,
                  onSaved: (value) {
                    setState(() {
                      gender = value;
                    });
                  },
                  onChanged: (value) async {
                    setState(() {
                      gender = value;
                    });
                  },
                  dataSource: [
                    {
                      'Id': 'પુરુષ',
                      'Name': 'પુરુષ',
                    },
                    {
                      'Id': 'સ્ત્રી',
                      'Name': 'સ્ત્રી',
                    },
                  ],
                  textField: 'Name',
                  valueField: 'Id',
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              Container(
                child: TextFormField(
                  decoration: InputDecoration(
                    filled: true,
                    labelText: 'ફોન નંબર',
                  ),
                  maxLength: 10,
                  controller: _phoneController,
                  onSaved: (value) {},
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'ફોન નંબર ખાલી ના હોવો જોઈએ.';
                    } else if (value.length != 10) {
                      return 'ફોન નંબર ફક્ત 10 અંકનો જ હોવો જોઈએ.';
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
                    filled: true,
                    labelText: 'વૈકલ્પિક ફોન નંબર',
                  ),
                  controller: _alternatephoneController,
                  onSaved: (value) {},
                  // validator: (value) {
                  //   if (value.isEmpty) {
                  //     return 'વૈકલ્પિક ફોન નંબર ખાલી ના હોવો જોઈએ.';
                  //   } else if (value.length != 10) {
                  //     return 'વૈકલ્પિક ફોન નંબર ફક્ત 10 અંકનો જ હોવો જોઈએ.';
                  //   }
                  //   return null;
                  // },
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              Container(
                child: TextFormField(
                  decoration: InputDecoration(
                    filled: true,
                    labelText: 'ઈ-મેલ એડ્રેસ',
                  ),
                  controller: _emailController,
                  onSaved: (value) {},
                  // validator: (value) {
                  //   bool emailValid = RegExp(
                  //           r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                  //       .hasMatch(value);

                  //   if (value.isEmpty) {
                  //     return 'ઈ-મેલ એડ્રેસ ખાલી ના હોવું જોઈએ.';
                  //   }
                  //   if (!emailValid) {
                  //     return 'આ ઈમેલ એડ્રેસ માન્ય નથી.';
                  //   }
                  //   return null;
                  // },
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              SizedBox(
                height: 8.0,
              ),
              stateDropdownWidget(context, locationService),
              SizedBox(
                height: 8.0,
              ),
              districtDropdownWidget(context, locationService),
              SizedBox(
                height: 8.0,
              ),
              tehsilDropdownWidget(context, locationService),
              SizedBox(
                height: 8.0,
              ),
              villageCityDropdownWidget(context, locationService),
              SizedBox(
                height: 8.0,
              ),
              Container(
                child: TextFormField(
                  decoration: InputDecoration(
                    filled: true,
                    labelText: 'પીનકોડ',
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
                  ),
                  keyboardType: TextInputType.number,
                  controller: _pincodeController,
                  // validator: (value) {
                  //   if (value.isEmpty) {
                  //     return 'પીનકોડ ખાલી ના હોવો જોઈએ.';
                  //   }
                  //   return null;
                  // },
                  onSaved: (value) {
                    setState(() {
                      pincode = value;
                    });
                  },
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              Container(
                child: TextFormField(
                  decoration: InputDecoration(
                    filled: true,
                    labelText: 'સરનામું',
                  ),
                  maxLines: 4,
                  // validator: (value) {
                  //   if (value.isEmpty) {
                  //     return 'સરનામું ખાલી ના હોવું જોઈએ.';
                  //   }
                  //   return null;
                  // },
                  controller: _addressController,
                  onSaved: (value) {
                    setState(() {
                      address = value;
                    });
                  },
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(4.0),
                  topRight: Radius.circular(4.0),
                ),
                child: Container(
                  height: 64.0,
                  padding: EdgeInsets.only(left: 12.0),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.black45,
                      ),
                    ),
                    color: Colors.black12,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'યુઝરનેમ',
                        style: Theme.of(context).textTheme.caption,
                      ),
                      Text(
                        _phoneController.text,
                        style: Theme.of(context).textTheme.subhead,
                      ),
                    ],
                  ),
                ),
              ),
              // SizedBox(
              //   height: 8.0,
              // ),
              // Container(
              //   child: TextFormField(
              //     decoration: InputDecoration(
              //       // border: OutlineInputBorder(),
              //       filled: true,
              //       labelText: 'યુઝરનેમ',
              //     ),
              //     controller: _phoneController,
              //     onSaved: (value) {},
              //     validator: (value) {
              //       if (value.isEmpty) {
              //         return 'યુઝર આઈડી ખાલી ના હોવું જોઈએ.';
              //       }
              //       return null;
              //     },
              //     // enabled: false,
              //   ),
              // ),
              SizedBox(
                height: 8.0,
              ),
              Container(
                child: TextFormField(
                  decoration: InputDecoration(
                    // border: OutlineInputBorder(),
                    filled: true,
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
                  color: Theme.of(context).accentColor,
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
                                Theme.of(context).accentColor,
                              ),
                              backgroundColor: Colors.white,
                            ),
                          ),
                        )
                      : Text(
                          'રજીસ્ટર',
                          style: GoogleFonts.lato(
                            textStyle:
                                Theme.of(context).textTheme.title.copyWith(
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
                      String name = _nameController.text;
                      String username = _phoneController.text;
                      String password = _passwordController.text;
                      String email = (_emailController.text == null ||
                              _emailController.text == '')
                          ? 'test@test.com'
                          : _emailController.text;
                      String mobile = _phoneController.text;
                      String pincode = (_pincodeController.text == null ||
                              _pincodeController.text == '')
                          ? '999999'
                          : _pincodeController.text;
                      String address = (_addressController.text == null ||
                              _addressController.text == '')
                          ? 'Address'
                          : _addressController.text;
                      String alternateNo =
                          (_alternatephoneController.text == null ||
                                  _alternatephoneController.text == '')
                              ? '999999999'
                              : _alternatephoneController.text;
                      String birthdate = (_birthdateController.text == null ||
                              _birthdateController.text == '')
                          ? '01/01/2000'
                          : _birthdateController.text;

                      bool registeredMobile =
                          await _authService.checkMobile(mobile);
                      if (registeredMobile) {
                        showDialog(
                            context: context,
                            barrierDismissible: true,
                            builder: (context) {
                              return AlertDialog(
                                title: Text('WARNING'),
                                content: Text(
                                    '$mobile is already registered. login using that account.'),
                              );
                            });
                      }

                      bool registeredUsername =
                          await _authService.checkUsername(username);
                      if (registeredUsername) {
                        showDialog(
                            context: context,
                            barrierDismissible: true,
                            builder: (context) {
                              return AlertDialog(
                                title: Text('WARNING'),
                                content: Text(
                                    '$username is already registered. login using that account.'),
                              );
                            });
                      }

                      print('Username : $username, Password : $password');

                      print(
                          'Name: $name, Address: $address, Country: India, StateId: $stateId, DistrictId: $districtId, CityId: $villageCityId, Pincode: $pincode, Email: $email, MobileNo: $mobile, AlternateMobileNo: $alternateNo, Gender: $gender, Birthdate: $birthdate, Username: $username, Password: $password');

                      if (!registeredMobile || !registeredUsername) {
                        _nameController.text = '';
                        _emailController.text = '';
                        _passwordController.text = '';
                        _phoneController.text = '';
                        _alternatephoneController.text = '';
                        _pincodeController.text = '';
                        _addressController.text = '';
                        _birthdateController.text = '';
                        // _usernameController.text = '';
                        _passwordController.text = '';
                        _formKey.currentState.reset();

                        bool _loggedIn = await _myTeamService.addTeamMember(
                          name,
                          address,
                          'India',
                          stateId,
                          districtId,
                          talukaId,
                          villageCityId,
                          pincode,
                          email,
                          mobile,
                          alternateNo,
                          (gender == null || gender == '') ? 'Male' : gender,
                          birthdate,
                          username,
                          password,
                        );

                        if (_loggedIn) {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('SUCCESS'),
                                  content:
                                      Text('Team member is added succesfully.'),
                                  actions: <Widget>[
                                    FlatButton(
                                      child: Text(
                                        'OK',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      color: Theme.of(context).primaryColor,
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              });
                        } else {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('ERROR'),
                                  content: Text(
                                      'An error occured while adding a team member. Try again.'),
                                  actions: <Widget>[
                                    FlatButton(
                                      child: Text(
                                        'OK',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      color: Theme.of(context).primaryColor,
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              });
                        }
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

  Widget stateDropdownWidget(
      BuildContext context, LocationService locationService) {
    return Container(
      child: FutureBuilder<List<Map<String, dynamic>>>(
        future: locationService.getStates(),
        builder: (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
          return DropDownFormField(
            titleText: 'રાજ્ય',
            hintText: 'રાજ્ય',
            value: stateId,
            required: true,
            onSaved: (value) {
              setState(() {
                stateId = value;
                districtId = null;
                talukaId = null;
                villageCityId = null;
              });
            },
            onChanged: (value) {
              setState(() {
                stateId = value;
                districtId = null;
                talukaId = null;
                villageCityId = null;
                districtEnabled = true;
                talukaEnabled = false;
                cityEnabled = false;
              });
            },
            dataSource: (snapshot.data != null) ? snapshot.data : [],
            textField: 'Name',
            valueField: 'Id',
          );
        },
      ),
    );
  }

  Widget districtDropdownWidget(
      BuildContext context, LocationService locationService) {
    return Container(
      child: FutureBuilder<List<Map<String, dynamic>>>(
        future: locationService.getDistricts(stateId),
        builder: (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
          return DropDownFormField(
            titleText: 'જિલ્લો',
            hintText: 'જિલ્લો',
            value: districtId,
            required: true,
            onSaved: (value) {
              setState(() {
                districtId = value;
                talukaId = null;
                villageCityId = null;
              });
            },
            onChanged: (value) {
              setState(() {
                districtId = value;
                talukaId = null;
                villageCityId = null;
                talukaEnabled = true;
                cityEnabled = false;
              });
            },
            dataSource:
                (districtEnabled && snapshot.hasData) ? snapshot.data : [],
            textField: 'Name',
            valueField: 'Id',
          );
        },
      ),
    );
  }

  Widget tehsilDropdownWidget(
      BuildContext context, LocationService locationService) {
    return Container(
      child: FutureBuilder<List<Map<String, dynamic>>>(
        future: locationService.getTehsils(districtId),
        builder: (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
          return DropDownFormField(
            titleText: 'તાલુકો',
            hintText: 'તાલુકો',
            value: talukaId,
            required: true,
            onSaved: (value) {
              setState(() {
                talukaId = value;
              });
            },
            onChanged: (value) {
              setState(() {
                talukaId = value;
                villageCityId = null;
                cityEnabled = true;
              });
            },
            dataSource:
                (talukaEnabled && snapshot.hasData) ? snapshot.data : [],
            textField: 'Name',
            valueField: 'Id',
          );
        },
      ),
    );
  }

  Widget villageCityDropdownWidget(
      BuildContext context, LocationService locationService) {
    return Container(
      child: FutureBuilder(
        future: locationService.getCities(talukaId, districtId),
        builder: (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
          return DropDownFormField(
            titleText: 'શહેર/ગામ',
            hintText: 'શહેર/ગામ',
            value: villageCityId,
            required: true,
            onSaved: (value) {
              setState(() {
                villageCityId = value;
              });
            },
            onChanged: (value) {
              setState(() {
                villageCityId = value;
              });
            },
            dataSource: (cityEnabled && snapshot.hasData) ? snapshot.data : [],
            textField: 'Name',
            valueField: 'Id',
          );
        },
      ),
    );
  }
}
