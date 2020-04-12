import 'dart:io';

import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:farmcart/services/auth_service.dart';
import 'package:farmcart/services/category_service.dart';
import 'package:farmcart/services/product_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddProductPage extends StatefulWidget {
  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final TextEditingController milkQuantityController = TextEditingController();
  final TextEditingController stockQuantityController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  File _image;

  String mainCategoryId;
  String subCategoryId;
  String categoryTypeId;
  String organicTypeId;
  String gabhanId;
  String stockUnitId;
  String stock;
  String minPrice;
  String maxPrice;
  String milkQuantity;
  String milkUnitId;
  String age;
  String ageUnitId;
  String stateId;
  String districtId;
  String tehsilId;
  String villageId;
  bool subCategoryEnabled = false;
  bool categoryTypeEnabled = false;
  bool organicTypeEnabled = false;
  bool gabhanEnabled = false;
  bool districtEnabled = false;
  bool tehsilEnabled = false;
  bool villageEnabled = false;

  Future getImage() async {
    var image = await ImagePicker.pickImage(
      source: ImageSource.gallery,
    );

    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    final CategoryService _categoryService =
        Provider.of<CategoryService>(context);

    final ProductService _productService = Provider.of<ProductService>(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'ખરીદ',
            style: GoogleFonts.lato(
              textStyle: Theme.of(context).textTheme.title.copyWith(
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
            ),
          ),
        ),
        body: ListView(
          padding: EdgeInsets.all(16.0),
          children: <Widget>[
            mainCategoryDropdownWidget(context, _categoryService),
            SizedBox(
              height: 8.0,
            ),
            subCategoryDropdownWidget(context, _categoryService),
            SizedBox(
              height: 8.0,
            ),
            categoryTypeDropdownWidget(context, _categoryService),
            SizedBox(
              height: 8.0,
            ),
            organicTypeDropdownWidget(context, _categoryService),
            SizedBox(
              height: 8.0,
            ),
            nameTextFieldWidget(),
            gabhanTypeDropdownWidget(context, _categoryService),
            SizedBox(
              height: 8.0,
            ),
            priceAndUnitRowWidget(context, _categoryService),
            SizedBox(
              height: 8.0,
            ),
            selectImageWidget(),
            SizedBox(
              height: 8.0,
            ),
            submitButtonWidget(context, _productService),
          ],
        ),
      ),
    );
  }

  Widget mainCategoryDropdownWidget(
      BuildContext context, CategoryService categoryService) {
    return Container(
      child: FutureBuilder<List<Map<String, dynamic>>>(
        future: categoryService.getMainCategoriesAsJson(),
        initialData: [],
        builder: (BuildContext context,
            AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
          if (snapshot.hasData) {
            return DropDownFormField(
              titleText: 'મેઈન કેટેગરી',
              hintText: 'મેઈન કેટેગરી',
              value: mainCategoryId,
              required: true,
              onSaved: (value) {
                setState(() {
                  mainCategoryId = value;
                });
              },
              onChanged: (value) {
                setState(() {
                  mainCategoryId = value;
                  subCategoryId = null;
                  categoryTypeId = null;
                  organicTypeId = null;
                  stockUnitId = null;
                  subCategoryEnabled = true;
                  categoryTypeEnabled = false;
                  organicTypeEnabled = false;
                  if (value == '11') {
                    gabhanEnabled = true;
                  } else {
                    gabhanEnabled = false;
                  }
                });
              },
              dataSource: (snapshot.data != null) ? snapshot.data : [],
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
    );
  }

  Widget subCategoryDropdownWidget(
      BuildContext context, CategoryService categoryService) {
    return Container(
      child: FutureBuilder<List<Map<String, dynamic>>>(
        future: categoryService.getSubCategoriesAsJson(mainCategoryId),
        initialData: [],
        builder: (BuildContext context,
            AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
          if (snapshot.hasData) {
            return DropDownFormField(
              titleText: 'પ્રકાર',
              hintText: 'પ્રકાર',
              value: subCategoryId,
              required: true,
              onSaved: (value) {
                setState(() {
                  subCategoryId = value;
                });
              },
              onChanged: (value) {
                setState(() {
                  subCategoryId = value;
                  categoryTypeId = null;
                  organicTypeId = null;
                  categoryTypeEnabled = true;
                  organicTypeEnabled = false;
                });
              },
              dataSource: (subCategoryEnabled) ? snapshot.data : [],
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
    );
  }

  Widget categoryTypeDropdownWidget(
      BuildContext context, CategoryService categoryService) {
    return Container(
      child: FutureBuilder<List<Map<String, dynamic>>>(
        future: categoryService.getCategoryTypesAsJson(subCategoryId),
        initialData: [],
        builder: (BuildContext context,
            AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
          if (snapshot.hasData) {
            return DropDownFormField(
              titleText: 'પેટા પ્રકાર',
              hintText: 'પેટા પ્રકાર',
              value: categoryTypeId,
              required: true,
              onSaved: (value) {
                setState(() {
                  categoryTypeId = value;
                });
              },
              onChanged: (value) {
                setState(() {
                  categoryTypeId = value;
                  organicTypeId = null;
                  organicTypeEnabled = true;
                });
              },
              dataSource: (categoryTypeEnabled) ? snapshot.data : [],
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
    );
  }

  Widget organicTypeDropdownWidget(
      BuildContext context, CategoryService categoryService) {
    return Container(
      child: DropDownFormField(
        titleText: 'ઓર્ગેનીક પ્રકાર',
        hintText: 'ઓર્ગેનીક પ્રકાર',
        value: organicTypeId,
        required: true,
        onSaved: (value) {
          setState(() {
            organicTypeId = value;
          });
        },
        onChanged: (value) {
          setState(() {
            organicTypeId = value;
          });
          if (organicTypeId == 'Organic') {
            gabhanEnabled = true;
          } else {
            gabhanEnabled = false;
          }
        },
        dataSource: (organicTypeEnabled)
            ? [
                {'Id': 'ઓર્ગેનીક', 'Name': 'ઓર્ગેનીક'},
                {'Id': 'બિન-ઓર્ગેનીક', 'Name': 'બિન-ઓર્ગેનીક'},
              ]
            : [],
        textField: 'Name',
        valueField: 'Id',
      ),
    );
  }

  Widget nameTextFieldWidget() {
    return Container(
      child: TextFormField(
        controller: nameController,
        decoration: InputDecoration(
          filled: true,
          labelText: 'નામ',
          contentPadding:
              EdgeInsets.symmetric(vertical: 20.0, horizontal: 12.0),
        ),
      ),
    );
  }

  Widget gabhanTypeDropdownWidget(
      BuildContext context, CategoryService categoryService) {
    return (gabhanEnabled)
        ? Container(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 8.0,
                ),
                Container(
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: 150.0,
                        child: DropDownFormField(
                          titleText: 'ગાભણ ના પ્રકાર',
                          hintText: 'ગાભણ ના પ્રકાર',
                          value: gabhanId,
                          required: true,
                          onSaved: (value) {
                            setState(() {
                              gabhanId = value;
                            });
                          },
                          onChanged: (value) {
                            setState(() {
                              gabhanId = value;
                            });
                          },
                          dataSource: [
                            {'Id': 'ગાભણ', 'Name': 'ગાભણ'},
                            {'Id': 'બિન-ગાભણ', 'Name': 'બિન-ગાભણ'},
                          ],
                          textField: 'Name',
                          valueField: 'Id',
                        ),
                      ),
                      SizedBox(
                        width: 8.0,
                      ),
                      Flexible(
                        flex: 1,
                        child: TextFormField(
                          controller: milkQuantityController,
                          decoration: InputDecoration(
                            filled: true,
                            labelText: 'દુધ બે સમય નું',
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 20.0, horizontal: 12.0),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 8.0,
                      ),
                      Container(
                        width: 120.0,
                        child: DropDownFormField(
                          titleText: 'માપ',
                          hintText: 'માપ',
                          value: milkUnitId,
                          required: true,
                          onSaved: (value) {
                            setState(() {
                              milkUnitId = value;
                            });
                          },
                          onChanged: (value) {
                            setState(() {
                              milkUnitId = value;
                            });
                          },
                          dataSource: [
                            {'Id': 'કિલો', 'Name': 'કિલો'},
                            {'Id': 'લીટર', 'Name': 'લીટર'},
                          ],
                          textField: 'Name',
                          valueField: 'Id',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        : Container();
  }

  Widget priceAndUnitRowWidget(
      BuildContext context, CategoryService categoryService) {
    return Container(
      width: MediaQuery.of(context).size.width - 40,
      child: Row(
        children: <Widget>[
          Flexible(
            flex: 1,
            child: TextFormField(
              controller: priceController,
              decoration: InputDecoration(
                filled: true,
                labelText: 'ભાવ',
                prefix: Text('₹  '),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 20.0, horizontal: 12.0),
              ),
            ),
          ),
          SizedBox(
            width: 8.0,
          ),
          Container(
            width: 150.0,
            child: DropDownFormField(
              titleText: 'માપ',
              hintText: 'માપ',
              value: stockUnitId,
              required: true,
              onSaved: (value) {
                setState(() {
                  stockUnitId = value;
                });
              },
              onChanged: (value) {
                setState(() {
                  stockUnitId = value;
                });
              },
              dataSource: (gabhanEnabled)
                  ? [
                      {
                        'Id': 'વેતર',
                        'Name': 'વેતર',
                      }
                    ]
                  : [
                      {'Id': 'કિલો', 'Name': 'કિલો'},
                      {'Id': 'લીટર', 'Name': 'લીટર'},
                    ],
              textField: 'Name',
              valueField: 'Id',
            ),
          ),
        ],
      ),
    );
  }

  Widget selectImageWidget() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          RaisedButton(
            color: Colors.white,
            child: Text(
              'SELECT IMAGE',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
            ),
            onPressed: getImage,
          ),
          Container(
            height: 80.0,
            width: 80.0,
            alignment: Alignment.center,
            child: _image == null
                ? Text('No image selected.')
                : Image.file(_image),
          ),
        ],
      ),
    );
  }

  Widget submitButtonWidget(
      BuildContext context, ProductService productService) {
    return Container(
      child: RaisedButton(
        padding: EdgeInsets.all(16.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
        ),
        color: Theme.of(context).primaryColor,
        child: Text(
          'શોધો',
          style: GoogleFonts.lato(
            textStyle: Theme.of(context).textTheme.title.copyWith(
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
          ),
        ),
        onPressed: () async {
          String name = nameController.text;
          String price = priceController.text;
          String unit = stockUnitId;

          productService.addProduct(mainCategoryId, subCategoryId,
              categoryTypeId, name, price, unit, '', _image);
        },
      ),
    );
  }
}
