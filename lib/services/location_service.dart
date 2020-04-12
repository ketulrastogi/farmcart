import 'package:flutter/widgets.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class LocationService with ChangeNotifier {
  Future<List<Map<String, dynamic>>> getStates() async {
    http.Response response =
        await http.get('https://api.farmcart.in/api/Values/Statedata');

    Map<String, dynamic> body = await json.decode(response.body);
    return [...body['Data']];
  }

  Future<List<Map<String, dynamic>>> getDistricts(String stateId) async {
    if (stateId == null) {
      return [];
    }
    http.Response response = await http
        .get('https://api.farmcart.in/api/Values/Distictdata?id=$stateId');

    Map<String, dynamic> body = await json.decode(response.body);
    // print(body['Data']);
    List<Map<String, dynamic>> districtList = List();

    districtList = [...body['Data']];
    return districtList;
  }

  Future<List<Map<String, dynamic>>> getTehsils(String districtId) async {
    if (districtId == null) {
      return [];
    }
    http.Response response = await http
        .get('https://api.farmcart.in/api/Values/Talukadata?id=$districtId');

    Map<String, dynamic> body = await json.decode(response.body);
    // print(body['Data']);
    List<Map<String, dynamic>> districtList = List();

    districtList = [...body['Data']];
    return districtList;
  }

  Future<List<Map<String, dynamic>>> getCities(
      String talukaId, String districtId) async {
    if (talukaId == null || districtId == null) {
      return [];
    }
    http.Response response = await http.get(
        'https://api.farmcart.in/api/Values/Villagedata?id=$districtId&did=$talukaId');

    Map<String, dynamic> body = await json.decode(response.body);

    return [...body['Data']];
  }

  Future<List<Map<String, dynamic>>> getPincode(String cityId) async {
    if (cityId == null) {
      cityId = '1540';
    }
    http.Response response = await http
        .get('https://api.farmcart.in/api/Values/Pincodedata?id=$cityId');

    Map<String, dynamic> body = await json.decode(response.body);

    print(body);

    return [...body['Data']];
  }
}
