import 'package:farmcart/models/category_type_model.dart';
import 'package:farmcart/models/main_category_model.dart';
import 'package:farmcart/models/sub_category_model.dart';
import 'package:flutter/widgets.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CategoryService with ChangeNotifier {
  // Get All Main Categories
  Future<List<MainCategoryModel>> getMainCategories() async {
    http.Response response =
        await http.get('https://api.farmcart.in/api/Home/Maincategorydata');

    Map<String, dynamic> body = json.decode(response.body);

    List<MainCategoryModel> mainCategoryList = [...body['Data']].map((data) {
      return MainCategoryModel.fromJson(data);
    }).toList();

    return mainCategoryList;
  }

  Future<List<Map<String, dynamic>>> getMainCategoriesAsJson() async {
    http.Response response =
        await http.get('https://api.farmcart.in/api/Home/Maincategorydata');

    Map<String, dynamic> body = json.decode(response.body);

    return [...body['Data']];
  }

  // Get Sub Categories by Main Category Id
  Future<List<SubCategoryModel>> getSubCategories(String mainCategoryId) async {
    http.Response response = await http.get(
        'https://api.farmcart.in/api/Home/Subcategorydata?id=$mainCategoryId');

    Map<String, dynamic> body = json.decode(response.body);

    List<SubCategoryModel> subCategoryList = [...body['Data']].map((data) {
      return SubCategoryModel.fromJson(data);
    }).toList();

    return subCategoryList;
  }

  Future<List<Map<String, dynamic>>> getSubCategoriesAsJson(
      String mainCategoryId) async {
    if (mainCategoryId == null) {
      mainCategoryId = '2';
      return [];
    }

    http.Response response = await http.get(
        'https://api.farmcart.in/api/Home/Subcategorydata?id=$mainCategoryId');

    Map<String, dynamic> body = json.decode(response.body);
    return [...body['Data']];
  }

  // Get Category Types by Sub Category Id
  Future<List<CategoryTypeModel>> getCategoryTypes(String subCategoryId) async {
    http.Response response = await http.get(
        'https://api.farmcart.in/api/Home/InSubcategorydata?id=$subCategoryId');

    Map<String, dynamic> body = json.decode(response.body);

    List<CategoryTypeModel> categoryTypeList = [...body['Data']].map((data) {
      return CategoryTypeModel.fromJson(data);
    }).toList();

    return categoryTypeList;
  }

  Future<List<Map<String, dynamic>>> getCategoryTypesAsJson(
      String subCategoryId) async {
    if (subCategoryId == null) {
      subCategoryId = '2';
      return [];
    }

    http.Response response = await http.get(
        'https://api.farmcart.in/api/Home/InSubcategorydata?id=$subCategoryId');

    Map<String, dynamic> body = json.decode(response.body);
    return [...body['Data']];
  }

  Future<List<Map<String, dynamic>>> getStockTypes(
      String mainCategoryId) async {
    if (mainCategoryId == null) {
      mainCategoryId = '2';
    }

    http.Response response = await http.get(
      'https://api.farmcart.in/api/Values/unitdata?id=$mainCategoryId',
      // 'http://api.farmcart.in/api/Pro/List?id=${userDetails['Id']}',
    );

    Map<String, dynamic> body = json.decode(response.body);

    return [...body['Data']];
  }
}
