import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:farmcart/pages/seller/auth_pages/auth_page.dart';
import 'package:farmcart/services/auth_service.dart';
import 'package:farmcart/services/location_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
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
  bool cityEnabled = false;
  String stateId;
  String districtId;
  String villageCityId;
  String pincode;
  String gender;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final AuthService _authService = Provider.of<AuthService>(context);
    final LocationService locationService =
        Provider.of<LocationService>(context);
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
                  'નવું સેલર એકાઉન્ટ',
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
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'જન્મ તારીખ ખાલી ના હોવી જોઈએ.';
                    }
                    return null;
                  },
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
                  required: true,
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
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'વૈકલ્પિક ફોન નંબર ખાલી ના હોવો જોઈએ.';
                    } else if (value.length != 10) {
                      return 'વૈકલ્પિક ફોન નંબર ફક્ત 10 અંકનો જ હોવો જોઈએ.';
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
                    labelText: 'ઈ-મેલ એડ્રેસ',
                  ),
                  controller: _emailController,
                  onSaved: (value) {},
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'ઈ-મેલ એડ્રેસ ખાલી ના હોવું જોઈએ.';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              Container(
                child: FutureBuilder<List<Map<String, dynamic>>>(
                  future: locationService.getStates(),
                  initialData: [
                    {'Id': '2', 'Name': 'Gujarat'}
                  ],
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                    if (snapshot.hasData) {
                      return DropDownFormField(
                        titleText: 'રાજ્ય',
                        hintText: 'રાજ્ય',
                        value: stateId,
                        required: true,
                        onSaved: (value) {
                          setState(() {
                            stateId = value;
                          });
                        },
                        onChanged: (value) {
                          setState(() {
                            stateId = value;
                            districtId = null;
                            villageCityId = null;
                            districtEnabled = true;
                          });
                        },
                        dataSource: snapshot.data,
                        textField: 'Name',
                        valueField: 'Id',
                      );
                    } else {
                      return Center(
                        child: Container(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                  },
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              Container(
                child: FutureBuilder<List<Map<String, dynamic>>>(
                  future: locationService.getDistricts(stateId),
                  initialData: [
                    {"Stateid": "2", "Id": "4", "Name": "Ahmedabad"}
                  ],
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                    if (snapshot.hasData) {
                      return DropDownFormField(
                        titleText: 'જિલ્લો',
                        hintText: 'જિલ્લો',
                        value: districtId,
                        required: true,
                        onSaved: (value) {
                          setState(() {
                            districtId = value;
                          });
                        },
                        onChanged: (value) {
                          setState(() {
                            districtId = value;
                            villageCityId = null;
                            cityEnabled = true;
                          });
                        },
                        dataSource: districtEnabled ? snapshot.data : [],
                        textField: 'Name',
                        valueField: 'Id',
                      );
                    } else {
                      return Center(
                        child: Container(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                  },
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              Container(
                child: FutureBuilder<List<Map<String, dynamic>>>(
                  future: locationService.getDistricts(stateId),
                  initialData: [
                    {"Stateid": "2", "Id": "4", "Name": "Ahmedabad"}
                  ],
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                    if (snapshot.hasData) {
                      return DropDownFormField(
                        titleText: 'તાલુકો',
                        hintText: 'તાલુકો',
                        value: districtId,
                        required: true,
                        onSaved: (value) {
                          setState(() {
                            districtId = value;
                          });
                        },
                        onChanged: (value) {
                          setState(() {
                            districtId = value;
                            villageCityId = null;
                            cityEnabled = true;
                          });
                        },
                        dataSource: districtEnabled ? snapshot.data : [],
                        textField: 'Name',
                        valueField: 'Id',
                      );
                    } else {
                      return Center(
                        child: Container(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                  },
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              Container(
                child: FutureBuilder<List<Map<String, dynamic>>>(
                  future: locationService.getCities(stateId, districtId),
                  initialData: [
                    {
                      "Stateid": "2",
                      "distinctid": "4",
                      "Id": "1540",
                      "Name": "Abasana"
                    }
                  ],
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                    if (snapshot.hasData) {
                      return DropDownFormField(
                        titleText: 'શહેર / ગામ',
                        hintText: 'શહેર / ગામ',
                        value: villageCityId,
                        required: true,
                        onSaved: (value) {
                          setState(() {
                            villageCityId = value;
                          });
                        },
                        onChanged: (value) async {
                          setState(() {
                            villageCityId = value;
                          });

                          List<Map<String, dynamic>> pincodeData =
                              await locationService.getPincode(value);
                          _pincodeController.text = pincodeData[0]['Name'];
                        },
                        dataSource: cityEnabled ? snapshot.data : [],
                        textField: 'Name',
                        valueField: 'Id',
                      );
                    } else {
                      return Center(
                        child: Container(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
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
                    labelText: 'પીનકોડ',
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
                  ),
                  keyboardType: TextInputType.number,
                  controller: _pincodeController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'પીનકોડ ખાલી ના હોવો જોઈએ.';
                    }
                    return null;
                  },
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
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'સરનામું ખાલી ના હોવું જોઈએ.';
                    }
                    return null;
                  },
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
              Container(
                child: TextFormField(
                  decoration: InputDecoration(
                    // border: OutlineInputBorder(),
                    filled: true,
                    labelText: 'યુઝર આઈડી',
                  ),
                  controller: _usernameController,
                  onSaved: (value) {},
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'યુઝર આઈડી ખાલી ના હોવું જોઈએ.';
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
                      String username = _usernameController.text;
                      String password = _passwordController.text;
                      String email = _emailController.text;
                      String mobile = _phoneController.text;
                      String pincode = _pincodeController.text;
                      String address = _addressController.text;
                      String alternateNo = _alternatephoneController.text;
                      String birthdate = _birthdateController.text;
                      _nameController.text = '';
                      _emailController.text = '';
                      _passwordController.text = '';
                      _phoneController.text = '';
                      _alternatephoneController.text = '';
                      _pincodeController.text = '';
                      _addressController.text = '';
                      _birthdateController.text = '';
                      _usernameController.text = '';
                      _passwordController.text = '';
                      _formKey.currentState.reset();
                      print(
                          'Name: $name, Address: $address, Country: India, StateId: $stateId, DistrictId: $districtId, CityId: $villageCityId, Pincode: $pincode, Email: $email, MobileNo: $mobile, AlternateMobileNo: $alternateNo, Gender: $gender, Birthdate: $birthdate, Username: $username, Password: $password');

                      bool _loggedIn = await _authService.signUp(
                        name,
                        address,
                        'India',
                        stateId,
                        districtId,
                        villageCityId,
                        pincode,
                        email,
                        mobile,
                        alternateNo,
                        gender,
                        birthdate,
                        username,
                        password,
                      );
                      if (_loggedIn) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AuthPage(
                                // isSeller: true,
                                ),
                          ),
                        );
                      } else {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text('ERROR'),
                                content: Text(
                                    'An error occured while signin up. Try again.'),
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
