import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:farmcart/services/location_service.dart';
import 'package:farmcart/services/order_service.dart';
// import 'package:farmcart/services/order_service.dart';
// import 'package:farmcart/services/product_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class OrderInquiryPage extends StatefulWidget {
  final String productId;
  final String unitId;
  final String sellerId;
  // final List<Map<String, dynamic>> productData;

  const OrderInquiryPage({Key key, this.productId, this.unitId, this.sellerId})
      : super(key: key);

  @override
  _OrderInquiryPageState createState() => _OrderInquiryPageState();
}

class _OrderInquiryPageState extends State<OrderInquiryPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _pincodeController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  String stateId;
  String districtId;
  String talukaId;
  String villageId;
  String pincode;
  bool stateEnabled = true;
  bool districtEnabled = false;
  bool tehsilEnabled = false;
  bool villageEnabled = false;
  List<Map<String, dynamic>> units = [
    {'Name': 'Kilo', 'Value': 'Kilo'},
    {'Name': 'Man', 'Value': 'Man'},
    {'Name': 'PCS', 'Value': 'PCS'}
  ];
  String selectedUnit;
  String name;
  String address;
  String quantity;
  String message;
  String contactNo;
  String productId;

  @override
  void initState() {
    // stateId = '2';
    // districtId = '4';
    // villageCityId = '1540';
    // pincode = '382021';
    // selectedUnit = 'Kilo';
    print('Product Widget : ${widget.productId}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    LocationService locationService = Provider.of<LocationService>(context);
    OrderService orderService = Provider.of<OrderService>(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'ઓર્ડર પૂછપરછ',
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
          key: formKey,
          child: ListView(
            padding: EdgeInsets.all(8.0),
            children: <Widget>[
              Container(
                child: TextFormField(
                  decoration: InputDecoration(
                    filled: true,
                    labelText: 'પૂરું નામ',
                  ),
                  controller: _nameController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'પૂરું નામ ખાલી ના હોવું જોઈએ.';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              Container(
                child: TextFormField(
                  decoration: InputDecoration(
                    filled: true,
                    labelText: 'ફોન નંબર',
                  ),
                  keyboardType: TextInputType.number,
                  controller: _phoneController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'ફોન નંબર ખાલી ના હોવો જોઈએ.';
                    } else if (value.length != 10) {
                      return 'ફોન નંબર ફક્ત 10 અંકનો જ હોવો જોઈએ.';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    setState(() {
                      contactNo = value;
                    });
                  },
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              Container(
                child: FutureBuilder<List<Map<String, dynamic>>>(
                  initialData: [],
                  future: locationService.getStates(),
                  builder: (context,
                      AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
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
              ),
              SizedBox(
                height: 8.0,
              ),
              Container(
                child: FutureBuilder<List<Map<String, dynamic>>>(
                  future: locationService.getDistricts(stateId),
                  builder: (context,
                      AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
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
              ),
              SizedBox(
                height: 8.0,
              ),
              Container(
                child: FutureBuilder<List<Map<String, dynamic>>>(
                  future: locationService.getTehsils(districtId),
                  builder: (context,
                      AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
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
              ),
              SizedBox(
                height: 8.0,
              ),
              Container(
                child: FutureBuilder(
                  future: locationService.getCities(talukaId, districtId),
                  builder: (context,
                      AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
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
                      onChanged: (value) async {
                        setState(() {
                          villageId = value;
                        });
                        // List<Map<String, dynamic>> pincodeData =
                        //     await locationService.getPincode(value);
                        // _pincodeController.text = pincodeData[0]['Name'];
                      },
                      dataSource: (villageEnabled) ? snapshot.data : [],
                      textField: 'Name',
                      valueField: 'Id',
                    );
                  },
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              // Container(
              //   child: TextFormField(
              //     decoration: InputDecoration(
              //       filled: true,
              //       labelText: 'પીનકોડ',
              //       contentPadding:
              //           EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
              //     ),
              //     keyboardType: TextInputType.number,
              //     controller: _pincodeController,
              //     validator: (value) {
              //       if (value.isEmpty) {
              //         return 'પીનકોડ ખાલી ના હોવો જોઈએ.';
              //       }
              //       return null;
              //     },
              //     onSaved: (value) {
              //       setState(() {
              //         pincode = value;
              //       });
              //     },
              //   ),
              // ),
              // SizedBox(
              //   height: 8.0,
              // ),
              Container(
                child: TextFormField(
                  decoration: InputDecoration(
                    filled: true,
                    labelText: 'સરનામું',
                  ),
                  maxLines: 4,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'સરનામું ખાલી ના હોવું જોઈએ.';
                    }
                    return null;
                  },
                  controller: _addressController,
                  onSaved: (value) {
                    setState(() {
                      address = value;
                    });
                  },
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              Container(
                child: Row(
                  children: <Widget>[
                    Flexible(
                      child: TextFormField(
                        decoration: InputDecoration(
                          filled: true,
                          labelText: 'જથ્થો',
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 20.0, horizontal: 10.0),
                        ),
                        keyboardType: TextInputType.number,
                        controller: _quantityController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'જથ્થો ખાલી ના હોવો જોઈએ.';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          setState(() {
                            quantity = value;
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      width: 8.0,
                    ),
                    Container(
                      width: 168.0,
                      // height: 56.0,
                      child: DropDownFormField(
                        titleText: 'માપ',
                        hintText: 'માપ',
                        value: selectedUnit,
                        // hintText: 'Unit',
                        required: true,
                        onSaved: (value) {
                          setState(() {
                            selectedUnit = value;
                          });
                        },
                        onChanged: (value) {
                          setState(() {
                            selectedUnit = value;
                          });
                        },
                        dataSource: units,
                        textField: 'Name',
                        valueField: 'Value',
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              Container(
                child: TextFormField(
                  decoration: InputDecoration(
                    filled: true,
                    labelText: 'અન્ય મેસેજ',
                  ),
                  controller: _messageController,
                  validator: (value) {
                    return null;
                  },
                  onSaved: (value) {
                    setState(() {
                      message = value;
                    });
                  },
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0),
          child: RaisedButton(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            color: Colors.green,
            child: Text(
              'SUBMIT INQUIRY',
              style: GoogleFonts.lato(
                textStyle: Theme.of(context).textTheme.subhead.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
              ),
            ),
            onPressed: () async {
              if (formKey.currentState.validate()) {
                formKey.currentState.save();

                orderService.submitOrderInquiry(
                  name,
                  address,
                  stateId,
                  districtId,
                  villageId,
                  pincode,
                  contactNo,
                  selectedUnit,
                  quantity,
                  message,
                  widget.productId,
                  widget.sellerId,
                );

                // formKey.currentState.reset();
              }
            },
          ),
        ),
      ),
    );
  }
}
