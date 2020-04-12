import 'package:flutter/widgets.dart';
import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;

class OrderService with ChangeNotifier {
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
