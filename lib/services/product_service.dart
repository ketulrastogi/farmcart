import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:path/path.dart';
import 'package:async/async.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class ProductService with ChangeNotifier {
  Future<List<Map<String, dynamic>>> getProducts() async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    Map<String, dynamic> userDetails;
    try {
      userDetails = json.decode(_sharedPreferences.getString('userDetails'));
      http.Response response = await http.get(
        'https://api.farmcart.in/api/Seller/ViewProduct?userid=${userDetails['Id']}',
        // 'http://api.farmcart.in/api/Pro/List?id=${userDetails['Id']}',
      );
      Map<String, dynamic> body = json.decode(response.body);
      return [...body['Data']];
    } catch (Exception) {
      userDetails = null;
    }
    return [];
  }

  Future<void> addProduct(
    String mainCategoryId,
    String name,
    String organicTypeId,
    String subCategoryId,
    String categoryTypeId,
    String milkQuantity,
    String milkUnit,
    String price,
    String unit,
    String stock,
    String gabhanType,
    File image,
    String productId,
  ) async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    Map<String, dynamic> userDetails;
    try {
      userDetails = json.decode(_sharedPreferences.getString('userDetails'));
    } catch (Exception) {
      userDetails = null;
    }
    print('ProductId : $productId');
    print('userId: ${userDetails['Id']}');
    print('MainCategory: $mainCategoryId');
    print('Productname: $name');
    print(
        'OrganicType: ${(mainCategoryId == '11') ? 'organic' : organicTypeId}');
    print('SubCategoryId: $subCategoryId');
    print('UnderSubCategoryId: $categoryTypeId');
    print('MilkQuantity: ${(mainCategoryId == '11') ? milkQuantity : ''}');
    print('MilkUnit: ${(mainCategoryId == '11') ? milkUnit : ''}');
    print('Price: $price');
    print(' Unit: $unit');
    print(' Image: ${(image != null) ? image.uri.toString() : '%00'}');
    print('Vetar: ${(mainCategoryId == '11') ? stock : '%00'}');
    print('GabhanType : $gabhanType');
    String userId = userDetails['Id'];
    String milkqty = (mainCategoryId == '11') ? milkQuantity : '0';
    String milkunit = (mainCategoryId == '11') ? milkUnit : 'Liter';
    String gabhantype = (gabhanType != null) ? gabhanType : 'NA';
    String vetar = (mainCategoryId == '11') ? stock : '0';
    String organicType = (mainCategoryId == '11') ? 'organic' : organicTypeId;
    String articleno = (mainCategoryId == '11') ? '1' : stock;
    print('MilkQty: $milkqty, milkUnit: $milkunit, Vetar: $vetar');

    http.Response response = (productId == null)
        ? await http.post(
            'https://api.farmcart.in/api/Seller/AddProduct',
            body: {
              'userid': userId,
              'MainCetegory': mainCategoryId,
              'MainCetegoryId': mainCategoryId,
              'SubCetegory': subCategoryId,
              'UnderSubCetegory': categoryTypeId,
              'Prodcutname': name,
              'Organic': organicType,
              'MilkQuantity': milkqty,
              'MilkUnit': milkunit,
              'Price': price,
              'unit': unit,
              'vetar': vetar,
              'Articleno': articleno,
              'GabhanType': gabhantype,
              // 'test': fileContentBase64,
            },
          )
        : await http.post(
            'https://api.farmcart.in/api/Seller/UpdateProduct',
            body: {
              'productid': productId,
              'userid': userId,
              'MainCetegory': mainCategoryId,
              'MainCetegoryId': mainCategoryId,
              'SubCetegory': subCategoryId,
              'UnderSubCetegory': categoryTypeId,
              'Prodcutname': name,
              'Organic': organicType,
              'MilkQuantity': milkqty,
              'MilkUnit': milkunit,
              'Price': price,
              'unit': unit,
              'vetar': vetar,
              'Articleno': articleno,
              // 'test': fileContentBase64,
            },
          );

    Map<String, dynamic> body = json.decode(response.body);

    print('Product Added');
    print(body);
    if ((productId == null) || ((productId != null) && (image != null))) {
      // uploadImage(body['Productid'], userDetails['Id'], image);
      await uploadImage((productId == null) ? body['Productid'] : productId,
          userDetails['Id'], image);
    }

    // Map<String, dynamic> body = json.decode(response.body);

    // print(body);
  }

  Future<void> uploadImage(
    String productId,
    String userId,
    File file,
  ) async {
    Dio dio = new Dio();

    String fileName = file.path.split('/').last;
    FormData formData = FormData.fromMap({
      'test': await MultipartFile.fromFile(file.path, filename: fileName),
      'ProductId': productId,
      'sid': userId,
    });
    Response response = await dio.post(
        'https://api.farmcart.in/api/DocumentUpload/AddProductImage',
        data: formData);
//  return response.data['id'];
    print(response.data);

    // var stream = new http.ByteStream(DelegatingStream.typed(image.openRead()));
    // // get file length
    // var length = await image.length(); //imageFile is your image file
    // Uri uri =
    //     Uri.parse('https://api.farmcart.in/api/DocumentUpload/AddProductImage');

    // var request = new http.MultipartRequest("POST", uri);
    // request.fields['ProductId'] = productId;
    // request.fields['sid'] = userId;
    // var multipartFileSign = new http.MultipartFile(
    //   'test',
    //   stream,
    //   length,
    //   filename: basename(image.path),
    // );

    // // add file to multipart
    // request.files.add(multipartFileSign);
    // var response = await request.send();

    // print('Image Uploaded');
    // print(
    //   response.statusCode,
    // );
    // // listen for response
    // response.stream.transform(utf8.decoder).listen((value) {
    //   print(value);
    // });
  }

  Future<List<Map<String, dynamic>>> searchProducts(
    String mainCategoryName,
    String mainCategoryId,
    String subCategoryId,
    String underSubCategoryId,
    String stockQuantity,
    String minAmount,
    String maxAmount,
    String milkUnit,
    String milkQuantity,
    String organicType,
    String stateId,
    String districtId,
    String talukaId,
    String villageId,
    String stockUnit,
  ) async {
    // print('MainCategoryId-new : $mainCategoryId');

    mainCategoryName = (mainCategoryName == null) ? '%00' : mainCategoryName;
    mainCategoryId = (mainCategoryId == null) ? '%00' : mainCategoryId;
    subCategoryId = (subCategoryId == null) ? '%00' : subCategoryId;
    underSubCategoryId =
        (underSubCategoryId == null) ? '%00' : underSubCategoryId;
    stockQuantity = (stockQuantity == null) ? '%00' : stockQuantity;
    stockUnit = (stockUnit == null) ? '%00' : stockUnit;
    minAmount = (minAmount == null) ? '%00' : minAmount;
    maxAmount = (maxAmount == null) ? '%00' : maxAmount;
    milkUnit = (milkUnit == null) ? '%00' : milkUnit;
    milkQuantity = (milkQuantity == null) ? '%00' : milkQuantity;
    organicType = (organicType == null) ? '%00' : organicType;
    stateId = (stateId == null) ? '%00' : stateId;
    districtId = (districtId == null) ? '%00' : districtId;
    talukaId = (talukaId == null) ? '%00' : talukaId;
    villageId = (villageId == null) ? '%00' : villageId;

    print('MainCategoryName: $mainCategoryName');
    print('MainCategoryId: $mainCategoryId');
    print('SubCategoryId: $subCategoryId');
    print('UnderSubCategoryId: $underSubCategoryId');
    print('StockQuantity: $stockQuantity');
    print('StockUnit: $stockUnit');
    print('MinimumAmount: $minAmount');
    print('MaximumAmount: $maxAmount');
    print('MilkUnit: $milkQuantity');
    print('OrganicType: $organicType');
    print('StateId: $stateId');
    print('DistrictId: $districtId');
    print('TalukaId: $talukaId');
    print('VillageId: $villageId');

    // String main_cat_name = '%E0%AA%85%E0%AA%A8%E0%AA%BE%E0%AA%9C';
    String main_cat_name = mainCategoryName;
    // String mc = '1';
    // String sc = '1';
    // String uc = '6';
    String mc = mainCategoryId;
    String sc = subCategoryId;
    String uc = underSubCategoryId;
    // String stock = '20';
    // String min = '1';
    // String max = '1000';
    String stock = stockQuantity;
    String unit = stockUnit;
    String min = minAmount;
    String max = maxAmount;

    String milk_type = '%00';
    String milk_qty = '%00';

    if (mainCategoryId == '11') {
      milk_type = stockUnit;
      milk_qty = stockQuantity;
    }

    String organic_type = organicType;
    String state = (stateId == null) ? '%00' : stateId;
    String dist = (districtId == null) ? '%00' : districtId;
    String city = (talukaId == null) ? '%00' : talukaId;
    String village = (villageId == null) ? '%00' : villageId;

    http.Response response = await http.get(
      'https://api.farmcart.in/api/Values/Searchdata?Main_Cat_Name=$main_cat_name&MC=$mc&SC=$sc&UC=$uc&stock=$stock&min=$min&max=$max&Type_Miilk=$milk_type&HMiilk=$milk_qty&OrganicType=$organic_type&State=$state&dist=$dist&city=$city&Village=$village&unit=$unit',
      // 'https://api.farmcart.in/api/Values/Searchdata?Main_Cat_Name=$mainCategoryName&MC=$mainCategoryId&SC=$subCategoryId&UC=$underSubCategoryId&stock=$stockQuantity&min=$minAmount&max=$maxAmount&Type_Miilk=$milkUnit&HMiilk=$milkQuantity&OrganicType=$organicType&State=$stateId&dist=$districtId&city=%00&Village=$villageId&unit=$stockQuantity',
      // 'https://api.farmcart.in/api/Seller/ViewProduct?userid=${userDetails['Id']}',
      // 'http://api.farmcart.in/api/Pro/List?id=${userDetails['Id']}',
    );

    Map<String, dynamic> body = json.decode(response.body);
    print(body);

    if (body['Success']) {
      return [...body['Data']];
    } else {
      return [];
    }
  }

  Future<Map<String, dynamic>> getSingleProductBynRand(String nRand) async {
    http.Response response = await http.get(
      'https://api.farmcart.in/api/Pro/data?id=$nRand',
      // 'http://api.farmcart.in/api/Pro/List?id=${userDetails['Id']}',
    );

    Map<String, dynamic> body = json.decode(response.body);

    // print(body);

    return [...body['Data']][0];
  }

  Future<Map<String, dynamic>> getSingleProductById(String productId) async {
    http.Response response = await http.get(
      'https://api.farmcart.in/api/Seller/ViewSingleProduct?id=$productId',
      // 'http://api.farmcart.in/api/Pro/List?id=${userDetails['Id']}',
    );

    Map<String, dynamic> body = json.decode(response.body);

    print('Product Data : $body');

    return [...body['Data']][0];
  }

  Future<void> deleteProductById(String productId) async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    Map<String, dynamic> userDetails;
    try {
      userDetails = json.decode(_sharedPreferences.getString('userDetails'));
    } catch (Exception) {
      userDetails = null;
    }

    http.Response response = await http.get(
      'https://api.farmcart.in/api/Seller/DeletePro?sellerid=${userDetails['Id']}&id=$productId',
      // 'http://api.farmcart.in/api/Pro/List?id=${userDetails['Id']}',
    );

    Map<String, dynamic> body = json.decode(response.body);

    // print(body);

    // return [...body['Data']][0];
  }
}
