import 'package:flutter/widgets.dart';
import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class OrderService with ChangeNotifier {
  Future<List<Map<String, dynamic>>> getOrderInquires() async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    Map<String, dynamic> userDetails;
    try {
      userDetails = json.decode(_sharedPreferences.getString('userDetails'));
    } catch (Exception) {
      userDetails = null;
    }

    http.Response response = await http.get(
      // 'https://api.farmcart.in/api/Seller/ViewOrder?userid=70',
      'https://api.farmcart.in/api/Seller/ViewOrder?userid=${userDetails['Id']}',
      // 'http://api.farmcart.in/api/Pro/List?id=${userDetails['Id']}',
    );

    Map<String, dynamic> body = json.decode(response.body);

    print(body);

    return [...body['Data']];
  }

  Future<List<Map<String, dynamic>>> getOrderDetails(
      String orderId, String nRand) async {
    http.Response response = await http.get(
      'https://api.farmcart.in/api/Seller/Orderdetail?id=$orderId&Rand=$nRand',
      // 'https://api.farmcart.in/api/Seller/ViewOrder?userid=${userDetails['Id']}',
      // 'http://api.farmcart.in/api/Pro/List?id=${userDetails['Id']}',
    );

    Map<String, dynamic> body = json.decode(response.body);

    // print(body);

    return [...body['Data']];
  }

  Future<Map<String, dynamic>> submitOrderInquiry(
    String name,
    String address,
    String stateId,
    String districtId,
    String cityId,
    String pincode,
    String contactNo,
    String unit,
    String quantity,
    String message,
    // String orderId,
    String productId,
    String sellerId,
  ) async {
    String orderId = DateTime.now().millisecondsSinceEpoch.toString();

    print({
      'Name': name,
      'Address': address,
      'StateId': stateId,
      'DistrictId': districtId,
      'CityId': cityId,
      'PincodeId': (pincode != null) ? pincode : 'pincode',
      'ContactNo': contactNo,
      'Unit': unit,
      'Quantity': quantity,
      'Message': message,
      'ProductId': productId,
      'OrderId': orderId,
    });

    http.Response response = await http.post(
      'https://api.farmcart.in/api/Pro/Order',
      body: {
        'personname': name,
        'address': address,
        'state': stateId,
        'dist': districtId,
        'city': cityId,
        'pincode': pincode,
        'contactno': contactNo,
        'Unit': unit,
        'Reason': message,
        'Stock': quantity,
        'orderId': orderId,
        'productid': productId,
      },
    );

    Map<String, dynamic> body = await json.decode(response.body);
    print(body);
    // print(json.decode(response.body));

    return body;
  }
}
