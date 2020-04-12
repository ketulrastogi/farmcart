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
  final String productId;
  final Map<String, dynamic> product;

  const AddProductPage({Key key, this.productId, this.product})
      : super(key: key);

  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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

  List<Map<String, dynamic>> mainCategories = [];
  List<Map<String, dynamic>> subCategories = [];
  List<Map<String, dynamic>> categoryTypes = [];
  bool _loading = false;
  bool subCategoryEnabled = false;
  bool categoryTypeEnabled = false;
  bool organicTypeEnabled = true;
  bool gabhanEnabled = false;
  bool districtEnabled = false;
  bool tehsilEnabled = false;
  bool villageEnabled = false;

  @override
  void initState() {
    super.initState();
    print(widget.product);
    if (widget.product != null) {
      mainCategoryId = widget.product['MainCategory'];
      subCategoryId = widget.product['SubCategory'];
      subCategoryEnabled = true;
      categoryTypeId = widget.product['InSubCategory'];
      categoryTypeEnabled = true;
      priceController.text = widget.product['Price'];
      stockUnitId = widget.product['unit'];
      stockQuantityController.text = widget.product['articleno'];

      print('MainCategoryId : $mainCategoryId');
      print('SubCategoryId : $subCategoryId');
      print('CategoryTypeId : $categoryTypeId');
      print('Price : ${priceController.text}');
      print('StockUnit : $stockUnitId');
    }
  }

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
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
            ),
          ),
          titleSpacing: 0.0,
          elevation: 1.0,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(
              // color: Colors.black,
              ),
        ),
        body: Form(
          key: _formKey,
          child: ListView(
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
              (mainCategoryId == '11')
                  ? gabhanTypeWidget()
                  : organicTypeDropdownWidget(),
              SizedBox(
                height: 8.0,
              ),
              milkQuantityandUnitWidget(context, _categoryService),
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
            mainCategories = snapshot.data;
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

                  if (value == '11') {
                    gabhanEnabled = true;
                    organicTypeEnabled = false;
                  } else {
                    gabhanEnabled = false;
                    organicTypeEnabled = true;
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
            subCategories = snapshot.data;
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
            categoryTypes = snapshot.data;
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

  Widget organicTypeDropdownWidget() {
    return Column(
      children: <Widget>[
        Container(
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
            },
            dataSource: (organicTypeEnabled)
                ? [
                    {'Id': 'organic', 'Name': 'ઓર્ગેનીક'},
                    {'Id': 'nonorganic', 'Name': 'બિન-ઓર્ગેનીક'},
                  ]
                : [],
            textField: 'Name',
            valueField: 'Id',
          ),
        ),
      ],
    );
  }

  Widget gabhanTypeWidget() {
    return Container(
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
          {'Id': 'gabhan', 'Name': 'ગાભણ'},
          {'Id': 'nongabhan', 'Name': 'બિન-ગાભણ'},
        ],
        textField: 'Name',
        valueField: 'Id',
      ),
    );
  }

  Widget milkQuantityandUnitWidget(
      BuildContext context, CategoryService categoryService) {
    return (mainCategoryId == '11')
        ? Container(
            child: Column(
              children: <Widget>[
                Container(
                  child: Row(
                    children: <Widget>[
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
                        width: 150.0,
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
                            {'Id': 'Kg', 'Name': 'કિલો'},
                            {'Id': 'Litre', 'Name': 'લીટર'},
                          ],
                          textField: 'Name',
                          valueField: 'Id',
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 8.0,
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
              controller: stockQuantityController,
              validator: (value) {
                if (value.isEmpty) {
                  return '';
                }
                return null;
              },
              decoration: InputDecoration(
                filled: true,
                labelText: (mainCategoryId == '11') ? 'વેતર/ઉમર વર્ષ' : 'જથ્થો',
                // prefix: Text('₹  '),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 20.0, horizontal: 12.0),
              ),
            ),
          ),
          SizedBox(
            width: 8.0,
          ),
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
            width: 120.0,
            child: FutureBuilder<List<Map<String, dynamic>>>(
              initialData: [],
              future: categoryService.getStockTypes(mainCategoryId),
              builder: (context,
                  AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                List<Map<String, dynamic>> data = [];
                data = snapshot.data;
                return DropDownFormField(
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
                  dataSource: (snapshot.hasData)
                      ? data.map((stockUnit) {
                          return {
                            'Id': stockUnit['unit'],
                            'Name': stockUnit['unit'],
                          };
                        }).toList()
                      : [],
                  textField: 'Name',
                  valueField: 'Id',
                );
              },
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
        child: (_loading)
            ? CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(
                  Theme.of(context).primaryColor,
                ),
                backgroundColor: Colors.white,
              )
            : Text(
                'શોધો',
                style: GoogleFonts.lato(
                  textStyle: Theme.of(context).textTheme.title.copyWith(
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                ),
              ),
        onPressed: (_loading)
            ? null
            : () async {
                setState(() {
                  _loading = true;
                });

                if (_formKey.currentState.validate()) {
                  // _formKey.currentState.save();
                  String name = categoryTypes.firstWhere(
                      (item) => (item['Id'] == categoryTypeId))['Name'];
                  print('ADD PRODUCT PAGE : 541 - Name : $name');
                  String stock = stockQuantityController.text;
                  String price = priceController.text;
                  String unit = stockUnitId;
                  milkQuantity = milkQuantityController.text;
                  productService.addProduct(
                    mainCategoryId,
                    name,
                    organicTypeId,
                    subCategoryId,
                    categoryTypeId,
                    milkQuantity,
                    milkUnitId,
                    price,
                    unit,
                    stock,
                    _image,
                    widget.productId,
                  );

                  mainCategoryId = null;
                  name = null;
                  organicTypeId = null;
                  subCategoryId = null;
                  categoryTypeId = null;
                  milkQuantity = null;
                  milkUnitId = null;
                  price = null;
                  unit = null;
                  stock = null;
                  _image = null;
                  stockQuantityController.text = '';
                  priceController.text = '';
                  stockUnitId = '';
                  milkQuantity = milkQuantityController.text;
                  setState(() {
                    _loading = false;
                  });

                  showDialog(
                    context: context,
                    builder:(context){
                      return AlertDialog(
                        title: Text('SUCCESS'),
                        content: Text('Product is successfully added.')
                      );
                    }
                  );
                }
                setState(() {
                  _loading = false;
                });
              },
      ),
    );
  }
}
