import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class MyTeamService with ChangeNotifier {
  Future<List<Map<String, dynamic>>> getMyTeamMembers() async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();

    Map<String, dynamic> userDetails;
    try {
      userDetails = json.decode(_sharedPreferences.getString('userDetails'));
    } catch (Exception) {
      userDetails = null;
    }

    http.Response response = await http.get(
        'https://api.farmcart.in/api/Seller/ViewMemberTeam?id=${userDetails['Id']}');

    Map<String, dynamic> body = json.decode(response.body);
    print(body);
    return [...body['Data']];
  }

  Future<bool> addTeamMember(
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
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();

    Map<String, dynamic> userDetails;
    try {
      userDetails = json.decode(_sharedPreferences.getString('userDetails'));
    } catch (Exception) {
      userDetails = null;
    }

    print('Username : $username, Password : $password');

    http.Response response =
        await http.post('https://api.farmcart.in/api/Seller/AddMember', body: {
      'Memberid': userDetails['Id'],
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
    print(body);
    return body['Success'];
  }
}
