import 'package:farmcart/services/order_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class OrderInquiryListPage extends StatefulWidget {
  @override
  _OrderInquiryListPageState createState() => _OrderInquiryListPageState();
}

class _OrderInquiryListPageState extends State<OrderInquiryListPage> {
  @override
  Widget build(BuildContext context) {
    final OrderService orderService = Provider.of<OrderService>(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Order Inquiries',
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
        body: FutureBuilder<List<Map<String, dynamic>>>(
          future: orderService.getOrderInquires(),
          builder:
              (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
            if (snapshot.hasData) {
              print(snapshot.data);
              print(snapshot.data.length);
              if (snapshot.data != null && snapshot.data.length != 0) {
                return ListView.separated(
                  padding: EdgeInsets.all(8.0),
                  itemCount: snapshot.data.length + 1,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              width: 40.0,
                              alignment: Alignment.center,
                              // color: Colors.yellow,
                              child: Text(
                                'Id',
                                style: GoogleFonts.lato(
                                  textStyle: Theme.of(context)
                                      .textTheme
                                      .title
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                        // color: Theme.of(context).primaryColor,
                                      ),
                                ),
                              ),
                            ),
                            Flexible(
                              flex: 2,
                              child: Container(
                                // width: 150.0,
                                alignment: Alignment.center,
                                // color: Colors.red,
                                child: Text(
                                  'Product',
                                  style: GoogleFonts.lato(
                                    textStyle: Theme.of(context)
                                        .textTheme
                                        .title
                                        .copyWith(
                                          fontWeight: FontWeight.bold,
                                          // color: Theme.of(context).primaryColor,
                                        ),
                                  ),
                                ),
                              ),
                            ),
                            Flexible(
                              flex: 2,
                              child: Container(
                                // color: Colors.blue,
                                alignment: Alignment.center,
                                child: Text(
                                  'Customer',
                                  style: GoogleFonts.lato(
                                    textStyle: Theme.of(context)
                                        .textTheme
                                        .title
                                        .copyWith(
                                          fontWeight: FontWeight.bold,
                                          // color: Theme.of(context).primaryColor,
                                        ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: 90.0,
                              alignment: Alignment.center,
                              // color: Colors.amber,
                              child: Text(
                                'Date',
                                style: GoogleFonts.lato(
                                  textStyle: Theme.of(context)
                                      .textTheme
                                      .title
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                        // color: Theme.of(context).primaryColor,
                                      ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      Map<String, dynamic> order = snapshot.data[index - 1];
                      return InkWell(
                        onTap: () async {
                          List<Map<String, dynamic>> orderDetails =
                              await orderService.getOrderDetails(
                            order['OrderId'],
                            order['nRand'],
                          );

                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('ORDER DETAILS'),
                                  content: Container(
                                    height: 170.0,
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Container(
                                                width: 80.0,
                                                alignment:
                                                    Alignment.centerRight,
                                                child: Text('Customer : ')),
                                            Expanded(
                                                child: Text(orderDetails[0]
                                                    ['customername'])),
                                          ],
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Container(
                                              width: 80.0,
                                              alignment: Alignment.centerRight,
                                              child: Text('Contact : '),
                                            ),
                                            Text(orderDetails[0]['contact']),
                                          ],
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Container(
                                              width: 80.0,
                                              alignment: Alignment.centerRight,
                                              child: Text('Address : '),
                                            ),
                                            Expanded(
                                              child: Text(
                                                  '${orderDetails[0]['address']}, ${orderDetails[0]['City']}, ${orderDetails[0]['District']}, ${orderDetails[0]['State']} - ${orderDetails[0]['pincode']}'),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Container(
                                              width: 80.0,
                                              alignment: Alignment.centerRight,
                                              child: Text('Product : '),
                                            ),
                                            Text(orderDetails[0]['Pro_detail']
                                                [0]['Name']),
                                          ],
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Container(
                                              width: 80.0,
                                              alignment: Alignment.centerRight,
                                              child: Text('Quantity : '),
                                            ),
                                            Text(
                                                '${orderDetails[0]['qty']} - ${orderDetails[0]['unit']}'),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              });
                        },
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                width: 40.0,
                                alignment: Alignment.center,
                                // color: Colors.yellow,
                                child: Text(
                                  order['OrderId'],
                                  style: GoogleFonts.lato(
                                    textStyle: Theme.of(context)
                                        .textTheme
                                        .subhead
                                        .copyWith(
                                            // fontWeight: FontWeight.bold,
                                            // color: Theme.of(context).primaryColor,
                                            ),
                                  ),
                                ),
                              ),
                              Flexible(
                                flex: 2,
                                child: Container(
                                  // width: 150.0,
                                  alignment: Alignment.topCenter,
                                  // color: Colors.red,
                                  child: Text(
                                    order['ProductName'],
                                    style: GoogleFonts.lato(
                                      textStyle: Theme.of(context)
                                          .textTheme
                                          .subhead
                                          .copyWith(
                                              // fontWeight: FontWeight.bold,
                                              // color: Theme.of(context).primaryColor,
                                              ),
                                    ),
                                  ),
                                ),
                              ),
                              Flexible(
                                flex: 2,
                                child: Container(
                                  alignment: Alignment.topCenter,
                                  // color: Colors.blue,
                                  child: Column(
                                    children: <Widget>[
                                      Text(
                                        order['PersonName'],
                                        style: GoogleFonts.lato(
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .subhead
                                              .copyWith(
                                                  // fontWeight: FontWeight.bold,
                                                  // color: Theme.of(context).primaryColor,
                                                  ),
                                        ),
                                      ),
                                      Text(
                                        order['Village_Name'],
                                        style: GoogleFonts.lato(
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .subhead
                                              .copyWith(
                                                  // fontWeight: FontWeight.bold,
                                                  // color: Theme.of(context).primaryColor,
                                                  ),
                                        ),
                                      ),
                                      Text(
                                        order['Contact'],
                                        style: GoogleFonts.lato(
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .subhead
                                              .copyWith(
                                                  // fontWeight: FontWeight.bold,
                                                  // color: Theme.of(context).primaryColor,
                                                  ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                width: 90.0,
                                // color: Colors.amber,
                                child: Text(
                                  order['Order_Date'],
                                  style: GoogleFonts.lato(
                                    textStyle: Theme.of(context)
                                        .textTheme
                                        .subhead
                                        .copyWith(
                                            // fontWeight: FontWeight.bold,
                                            // color: Theme.of(context).primaryColor,
                                            ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                  },
                  separatorBuilder: (context, index) {
                    return Divider();
                  },
                );
              } else {
                return Center(
                  child: Text(
                    'No order inquiry available.',
                    style: GoogleFonts.lato(
                      textStyle: Theme.of(context).textTheme.title.copyWith(
                          // fontWeight: FontWeight.bold,
                          // color: Theme.of(context).primaryColor,
                          ),
                    ),
                  ),
                );
              }
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
