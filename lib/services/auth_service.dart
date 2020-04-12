import 'package:flutter/widgets.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService with ChangeNotifier {
  Future<bool> checkMobile(String phoneNumber) async {
    http.Response response =
        await http.post('https://api.farmcart.in/api/Signup/Signup', body: {
      'Mobile': phoneNumber,
    });

    Map<String, dynamic> body = json.decode(response.body);

    return body['Success'];
  }

  Future<bool> checkUsername(String username) async {
    http.Response response =
        await http.post('https://api.farmcart.in/api/Signup/Signup', body: {
      'Mobile': username,
    });

    Map<String, dynamic> body = json.decode(response.body);

    return body['Success'];
  }

  Future<bool> signUp(
    String name,
    String address,
    String country,
    String stateId,
    String districtId,
    String talukaId,
    String cityId,
    String pincode,
    String email,
    String mobile,
    String alternateMobile,
    String gender,
    String birthdate,
    String username,
    String password,
  ) async {
    http.Response response =
        await http.post('https://api.farmcart.in/api/Signup/Signup', body: {
      'Name': name,
      'Address': address,
      'Country': country,
      'State': stateId,
      'Dist': districtId,
      'Taluka': talukaId,
      'City': cityId,
      'Pincode': pincode,
      'Email': email,
      'Mobile': mobile,
      'alternet_no': alternateMobile,
      'gender': gender,
      'Dob': birthdate,
      'username': username,
      'Password': password,
    });

    Map<String, dynamic> body = json.decode(response.body);

    return body['Success'];
  }

  Future<bool> signIn(String username, String password) async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();

    http.Response response = await http.post(
      'https://api.farmcart.in/api/Login/Signin',
      body: {
        'username': username,
        'password': password,
      },
    );

    Map<String, dynamic> body = json.decode(response.body);

    _sharedPreferences.setString('userDetails', response.body);

    return body['Success'];
  }

  Future<Map<String, dynamic>> getUserDetails() async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    Map<String, dynamic> userDetails;
    try {
      userDetails = json.decode(_sharedPreferences.getString('userDetails'));
      return {'isLoggedIn': userDetails['Success'], 'userDetails': userDetails};
    } catch (Exception) {
      userDetails = null;
      return {'isLoggedIn': (userDetails != null), 'userDetails': userDetails};
    }
  }

  Future<void> signOut() async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    _sharedPreferences.setString('userDetails', '');
  }
}
