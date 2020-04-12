import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:farmcart/pages/buyer/product_list_page.dart';
import 'package:farmcart/services/category_service.dart';
import 'package:farmcart/services/location_service.dart';
import 'package:farmcart/services/product_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ProductSearchPage extends StatefulWidget {
  @override
  _ProductSearchPageState createState() => _ProductSearchPageState();
}

class _ProductSearchPageState extends State<ProductSearchPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController milkQuantityController = TextEditingController();
  final TextEditingController stockQuantityController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController minPriceController = TextEditingController();
  final TextEditingController maxPriceController = TextEditingController();

  String mainCategoryId;
  String mainCategoryName;
  String subCategoryId;
  String categoryTypeId;
  String organicTypeId;
  String gabhanId;
  String vetar;
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
  String talukaId;
  String villageId;
  bool _loading = false;
  bool subCategoryEnabled = false;
  bool categoryTypeEnabled = false;
  bool organicTypeEnabled = false;
  bool gabhanEnabled = false;
  bool stateEnabled = false;
  bool districtEnabled = false;
  bool tehsilEnabled = false;
  bool villageEnabled = false;
  bool stockTypeEnabled = false;
  Map<String, dynamic> mainCategory;

  @override
  Widget build(BuildContext context) {
    final CategoryService _categoryService =
        Provider.of<CategoryService>(context);

    final LocationService _locationService =
        Provider.of<LocationService>(context);
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
              organicTypeDropdownWidget(context, _categoryService),
              gabhanTypeDropdownWidget(context, _categoryService),
              SizedBox(
                height: 8.0,
              ),
              quantityAndUnitRowWidget(context, _categoryService),
              SizedBox(
                height: 8.0,
              ),
              minMaxRateRowWidget(context, _categoryService),
              SizedBox(
                height: 8.0,
              ),
              stateDropdownWidget(context, _locationService),
              SizedBox(
                height: 8.0,
              ),
              districtDropdownWidget(context, _locationService),
              SizedBox(
                height: 8.0,
              ),
              tehsilDropdownWidget(context, _locationService),
              SizedBox(
                height: 8.0,
              ),
              villageCityDropdownWidget(context, _locationService),
              SizedBox(
                height: 8.0,
              ),
              submitButtonWidget(context, _categoryService),
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
                  stateId = null;
                  stateEnabled = true;
                  subCategoryEnabled = true;
                  categoryTypeEnabled = false;
                  organicTypeEnabled = false;
                  stockTypeEnabled = true;

                  if (snapshot.data != null) {
                    mainCategory = snapshot.data
                        .firstWhere((item) => (item['Id'] == mainCategoryId));
                    mainCategoryName = mainCategory['Name'];
                  } else {
                    mainCategoryName = null;
                  }

                  if (value == '11') {
                    gabhanEnabled = true;
                  } else {
                    gabhanEnabled = false;
                  }
                });
              },
              dataSource: (snapshot.hasData) ? snapshot.data : [],
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
                            {'Id': 'gabhan', 'Name': 'ગાભણ'},
                            {'Id': 'nongabhan', 'Name': 'બિન-ગાભણ'},
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
                          onSaved: (value) {
                            setState(() {
                              milkQuantity = value;
                            });
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Milk quantity can not be empty.';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.number,
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

  Widget quantityAndUnitRowWidget(
      BuildContext context, CategoryService categoryService) {
    return Container(
      width: MediaQuery.of(context).size.width - 40,
      child: Row(
        children: <Widget>[
          Flexible(
            flex: 1,
            child: TextFormField(
              controller: stockQuantityController,
              onSaved: (value) {
                setState(() {
                  stock = value;
                });
              },
              validator: (value) {
                if (value.isEmpty) {
                  return 'Milk quantity can not be empty.';
                }
                return null;
              },
              decoration: InputDecoration(
                filled: true,
                labelText: (gabhanEnabled) ? 'વેતર / ઉમર વર્ષ' : 'જથ્થો',
                contentPadding:
                    EdgeInsets.symmetric(vertical: 20.0, horizontal: 12.0),
              ),
              keyboardType: TextInputType.number,
            ),
          ),
          SizedBox(
            width: 8.0,
          ),
          Container(
            width: 150.0,
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
                  dataSource: (stockTypeEnabled && snapshot.hasData)
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

  Widget minMaxRateRowWidget(
      BuildContext context, CategoryService categoryService) {
    return Container(
      width: MediaQuery.of(context).size.width - 40,
      child: Row(
        children: <Widget>[
          Flexible(
            flex: 1,
            child: TextFormField(
              controller: minPriceController,
              onSaved: (value) {
                setState(() {
                  minPrice = value;
                });
              },
              validator: (value) {
                if (value.isEmpty) {
                  return 'Minimum price can not be empty.';
                }
                return null;
              },
              decoration: InputDecoration(
                filled: true,
                labelText: 'લઘુતમ ભાવ',
                prefix: Text('₹  '),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 20.0, horizontal: 12.0),
              ),
              keyboardType: TextInputType.number,
            ),
          ),
          SizedBox(
            width: 8.0,
          ),
          Flexible(
            flex: 1,
            child: TextFormField(
              controller: maxPriceController,
              onSaved: (value) {
                setState(() {
                  maxPrice = value;
                });
              },
              validator: (value) {
                if (value.isEmpty) {
                  return 'Maximum price can not be empty.';
                }
                return null;
              },
              decoration: InputDecoration(
                filled: true,
                labelText: 'મહત્તમ ભાવ',
                prefix: Text('₹  '),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 20.0, horizontal: 12.0),
              ),
              keyboardType: TextInputType.number,
            ),
          ),
        ],
      ),
    );
  }

  Widget stateDropdownWidget(
      BuildContext context, LocationService locationService) {
    return Container(
      child: FutureBuilder<List<Map<String, dynamic>>>(
        future: locationService.getStates(),
        builder: (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
          return DropDownFormField(
            titleText: 'રાજ્ય',
            hintText: 'રાજ્ય',
            value: stateId,
            required: true,
            onSaved: (value) {
              setState(() {
                stateId = value;
                districtId = null;
                talukaId = null;
                villageId = null;
              });
            },
            onChanged: (value) {
              setState(() {
                stateId = value;
                districtId = null;
                talukaId = null;
                villageId = null;
                districtEnabled = true;
                tehsilEnabled = false;
                villageEnabled = false;
              });
            },
            dataSource: (stateEnabled) ? snapshot.data : [],
            textField: 'Name',
            valueField: 'Id',
          );
        },
      ),
    );
  }

  Widget districtDropdownWidget(
      BuildContext context, LocationService locationService) {
    return Container(
      child: FutureBuilder<List<Map<String, dynamic>>>(
        future: locationService.getDistricts(stateId),
        builder: (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
          return DropDownFormField(
            titleText: 'જિલ્લો',
            hintText: 'જિલ્લો',
            value: districtId,
            required: true,
            onSaved: (value) {
              setState(() {
                districtId = value;
                talukaId = null;
                villageId = null;
              });
            },
            onChanged: (value) {
              setState(() {
                districtId = value;
                talukaId = null;
                villageId = null;
                tehsilEnabled = true;
                villageEnabled = false;
              });
            },
            dataSource: (districtEnabled) ? snapshot.data : [],
            textField: 'Name',
            valueField: 'Id',
          );
        },
      ),
    );
  }

  Widget tehsilDropdownWidget(
      BuildContext context, LocationService locationService) {
    return Container(
      child: FutureBuilder<List<Map<String, dynamic>>>(
        future: locationService.getTehsils(districtId),
        builder: (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
          return DropDownFormField(
            titleText: 'તાલુકો',
            hintText: 'તાલુકો',
            value: talukaId,
            required: true,
            onSaved: (value) {
              setState(() {
                talukaId = value;
              });
            },
            onChanged: (value) {
              setState(() {
                talukaId = value;
                villageId = null;
                villageEnabled = true;
              });
            },
            dataSource: (tehsilEnabled) ? snapshot.data : [],
            textField: 'Name',
            valueField: 'Id',
          );
        },
      ),
    );
  }

  Widget villageCityDropdownWidget(
      BuildContext context, LocationService locationService) {
    return Container(
      child: FutureBuilder(
        future: locationService.getCities(talukaId, districtId),
        builder: (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
          return DropDownFormField(
            titleText: 'શહેર/ગામ',
            hintText: 'શહેર/ગામ',
            value: villageId,
            required: true,
            onSaved: (value) {
              setState(() {
                villageId = value;
              });
            },
            onChanged: (value) {
              setState(() {
                villageId = value;
              });
            },
            dataSource: (villageEnabled) ? snapshot.data : [],
            textField: 'Name',
            valueField: 'Id',
          );
        },
      ),
    );
  }

  Widget submitButtonWidget(
      BuildContext context, CategoryService categoryService) {
    final ProductService productService = Provider.of<ProductService>(context);
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
                  _formKey.currentState.save();

                  print(mainCategory);

                  print('MainCategoryName: $mainCategoryName');
                  print('MainCategoryId: $mainCategoryId');
                  print('SubCategoryId: $subCategoryId');
                  print('UnderSubCategoryId: $categoryTypeId');
                  print('StockQuantity: $stock');
                  print('StockUnit: $stockUnitId');
                  print('MinimumAmount: $minPrice');
                  print('MaximumAmount: $maxPrice');
                  print('MilkQuantity: $milkQuantity');
                  print('MilkUnit: $milkUnitId');
                  print('OrganicType: $organicTypeId');
                  print('StateId: $stateId');
                  print('DistrictId: $districtId');
                  print('TalukaId: $talukaId');
                  print('VillageId: $villageId');

                  List<Map<String, dynamic>> products =
                      await productService.searchProducts(
                          mainCategoryName,
                          mainCategoryId,
                          subCategoryId,
                          categoryTypeId,
                          // stock,
                          stockQuantityController.text,
                          // minPrice,
                          minPriceController.text,
                          // maxPrice,
                          maxPriceController.text,
                          milkUnitId,
                          milkQuantityController.text,
                          organicTypeId,
                          stateId,
                          districtId,
                          talukaId,
                          villageId,
                          stockUnitId);

                  _formKey.currentState.reset();
                  stockQuantityController.text = '';
                  minPriceController.text = '';
                  maxPriceController.text = '';
                  milkQuantityController.text = '';
                  setState(() {
                    _loading = false;
                  });
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductListPage(products: products),
                    ),
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
