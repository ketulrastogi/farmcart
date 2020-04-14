import 'package:farmcart/pages/buyer/order_inquiry_page.dart';
import 'package:farmcart/services/product_service.dart';
// import 'package:farmcart/services/product_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductPage extends StatefulWidget {
  final Map<String, dynamic> product;

  const ProductPage({Key key, this.product}) : super(key: key);
  // final Product product;
  // final List<Map<String, dynamic>> productData;
  // final String label;

  // const ProductPage({Key key, this.product, this.label, this.productData})
  // : super(key: key);
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage>
    with TickerProviderStateMixin {
  TabController tabController;
  String productId;
  @override
  void initState() {
    super.initState();
    tabController = TabController(vsync: this, length: 2);
    // print(widget.productData);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ProductService productService = Provider.of<ProductService>(context);

    return Scaffold(
        appBar: AppBar(
          title: Text(
            // widget.productData[0]['Name'],
            widget.product['Productname'],
            style: GoogleFonts.lato(
              textStyle: Theme.of(context).textTheme.title.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
            ),
          ),
          titleSpacing: 0.0,
          elevation: 1.0,
          // backgroundColor: Colors.white,
          iconTheme: IconThemeData(
            // color: Theme.of(context).primaryColor,
            color: Colors.white,
          ),
          bottom: TabBar(
            controller: tabController,
            // indicatorColor: Colors.green,
            // unselectedLabelColor: Colors.grey,
            // labelColor: Colors.black,
            labelStyle: GoogleFonts.lato(
              textStyle: Theme.of(context).textTheme.subhead.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
            ),
            tabs: <Widget>[
              Container(
                height: 56.0,
                child: Tab(
                  child: Text(
                    'માહિતી',
                  ),
                ),
              ),
              Container(
                height: 56.0,
                child: Tab(
                  child: Text('સંપર્ક'),
                ),
              )
            ],
          ),
        ),
        body: FutureBuilder<Map<String, dynamic>>(
            future:
                productService.getSingleProductBynRand(widget.product['nRand']),
            builder: (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
              print(snapshot.data);

              if (snapshot.hasData) {
                productId = snapshot.data['Id'];
                return TabBarView(
                  controller: tabController,
                  children: <Widget>[
                    ListView(
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height / 4,
                          child: Image.network(
                            widget.product['nImage'],
                            fit: BoxFit.contain,
                          ),
                          // child: Image.asset('no-image.png'),
                        ),
                        ListTile(
                          title: Text(
                            'નામ',
                            style: GoogleFonts.lato(
                              textStyle:
                                  Theme.of(context).textTheme.subtitle.copyWith(
                                        color: Colors.black87,
                                      ),
                            ),
                          ),
                          subtitle: Text(
                            widget.product['Productname'],
                            style: GoogleFonts.lato(
                              textStyle:
                                  Theme.of(context).textTheme.subhead.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                            ),
                          ),
                          leading: Icon(
                            Icons.trip_origin,
                            size: 28.0,
                          ),
                        ),
                        Divider(
                          indent: 64.0,
                        ),
                        ListTile(
                          title: Text(
                            'ભાવ',
                            style: GoogleFonts.lato(
                              textStyle:
                                  Theme.of(context).textTheme.subtitle.copyWith(
                                        color: Colors.black87,
                                      ),
                            ),
                          ),
                          subtitle: Row(
                            children: <Widget>[
                              Text(
                                (snapshot.data['offerprice'] == '')
                                    ? '₹ ${snapshot.data['originalprice']} / ${snapshot.data['unit']}'
                                    : '₹ ${snapshot.data['offerprice']} / ${snapshot.data['unit']}',
                                style: GoogleFonts.lato(
                                  textStyle: Theme.of(context)
                                      .textTheme
                                      .subhead
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ),
                              SizedBox(
                                width: 16.0,
                              ),
                              Text(
                                '₹ ${snapshot.data['originalprice']} / ${snapshot.data['unit']}',
                                style: GoogleFonts.lato(
                                  textStyle: Theme.of(context)
                                      .textTheme
                                      .subhead
                                      .copyWith(
                                        fontWeight: FontWeight.w400,
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                ),
                              ),
                            ],
                          ),
                          leading: Icon(
                            Icons.monetization_on,
                            size: 28.0,
                          ),
                        ),
                        Divider(
                          indent: 64.0,
                        ),
                        ListTile(
                          title: Text(
                            'ઉપલબ્ધ',
                            style: GoogleFonts.lato(
                              textStyle:
                                  Theme.of(context).textTheme.subtitle.copyWith(
                                        color: Colors.black87,
                                      ),
                            ),
                          ),
                          subtitle: Text(
                            snapshot.data['Availability'],
                            style: GoogleFonts.lato(
                              textStyle:
                                  Theme.of(context).textTheme.subhead.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                            ),
                          ),
                          leading: Icon(
                            Icons.assignment_turned_in,
                            size: 28.0,
                          ),
                        ),
                        Divider(
                          indent: 64.0,
                        ),
                        ListTile(
                          title: Text(
                            'જથ્થો',
                            style: GoogleFonts.lato(
                              textStyle:
                                  Theme.of(context).textTheme.subtitle.copyWith(
                                        color: Colors.black87,
                                      ),
                            ),
                          ),
                          subtitle: Text(
                            (snapshot.data['Availability'] == 'In Stock')
                                ? '400 કિલો'
                                : '0 કિલો',
                            style: GoogleFonts.lato(
                              textStyle:
                                  Theme.of(context).textTheme.subhead.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                            ),
                          ),
                          leading: Icon(
                            Icons.equalizer,
                            size: 28.0,
                          ),
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.all(8.0),
                        //   child: RaisedButton(
                        //     padding: EdgeInsets.all(16.0),
                        //     shape: RoundedRectangleBorder(
                        //       borderRadius: BorderRadius.circular(4.0),
                        //     ),
                        //     color: Theme.of(context).primaryColor,
                        //     child: Text(
                        //       'પૂછપરછ',
                        //       style: GoogleFonts.lato(
                        //           textStyle: Theme.of(context)
                        //               .textTheme
                        //               .title
                        //               .copyWith(
                        //                 fontWeight: FontWeight.bold,
                        //                 color: Colors.white,
                        //               )),
                        //     ),
                        //     onPressed: () {
                        //       Navigator.push(
                        //         context,
                        //         MaterialPageRoute(
                        //           builder: (context) => OrderInquiryPage(
                        //               // product: widget.product,
                        //               // productData: widget.productData,
                        //               ),
                        //         ),
                        //       );
                        //     },
                        //   ),
                        // )
                      ],
                    ),
                    // ListView(
                    //   children: <Widget>[
                    //     ListTile(
                    //       title: Text(
                    //         'નામ',
                    //         style: GoogleFonts.lato(
                    //           textStyle:
                    //               Theme.of(context).textTheme.subtitle.copyWith(
                    //                     color: Colors.black87,
                    //                   ),
                    //         ),
                    //       ),
                    //       subtitle: Text(
                    //         widget.product['personname'],
                    //         style: GoogleFonts.lato(
                    //           textStyle:
                    //               Theme.of(context).textTheme.subhead.copyWith(
                    //                     fontWeight: FontWeight.bold,
                    //                   ),
                    //         ),
                    //       ),
                    //       leading: Icon(
                    //         Icons.person,
                    //         size: 28.0,
                    //       ),
                    //     ),
                    //     Divider(
                    //       indent: 64.0,
                    //     ),
                    //     ListTile(
                    //       title: Text(
                    //         'રાજ્ય',
                    //         style: GoogleFonts.lato(
                    //           textStyle:
                    //               Theme.of(context).textTheme.subtitle.copyWith(
                    //                     color: Colors.black87,
                    //                   ),
                    //         ),
                    //       ),
                    //       subtitle: Text(
                    //         '',
                    //         // 'ગુજરાત',
                    //         style: GoogleFonts.lato(
                    //           textStyle:
                    //               Theme.of(context).textTheme.subhead.copyWith(
                    //                     fontWeight: FontWeight.bold,
                    //                   ),
                    //         ),
                    //       ),
                    //       leading: Icon(
                    //         Icons.device_hub,
                    //         size: 28.0,
                    //       ),
                    //     ),
                    //     Divider(
                    //       indent: 64.0,
                    //     ),
                    //     ListTile(
                    //       title: Text(
                    //         'જિલ્લો',
                    //         style: GoogleFonts.lato(
                    //           textStyle:
                    //               Theme.of(context).textTheme.subtitle.copyWith(
                    //                     color: Colors.black87,
                    //                   ),
                    //         ),
                    //       ),
                    //       subtitle: Text(
                    //         '',
                    //         // 'પાટણ',
                    //         style: GoogleFonts.lato(
                    //           textStyle:
                    //               Theme.of(context).textTheme.subhead.copyWith(
                    //                     fontWeight: FontWeight.bold,
                    //                   ),
                    //         ),
                    //       ),
                    //       leading: Icon(
                    //         Icons.map,
                    //         size: 28.0,
                    //       ),
                    //     ),
                    //     Divider(
                    //       indent: 64.0,
                    //     ),
                    //     ListTile(
                    //       title: Text(
                    //         'તાલુકો',
                    //         style: GoogleFonts.lato(
                    //           textStyle:
                    //               Theme.of(context).textTheme.subtitle.copyWith(
                    //                     color: Colors.black87,
                    //                   ),
                    //         ),
                    //       ),
                    //       subtitle: Text(
                    //         '',
                    //         // 'પાટણ',
                    //         style: GoogleFonts.lato(
                    //           textStyle:
                    //               Theme.of(context).textTheme.subhead.copyWith(
                    //                     fontWeight: FontWeight.bold,
                    //                   ),
                    //         ),
                    //       ),
                    //       leading: Icon(
                    //         Icons.location_on,
                    //         size: 28.0,
                    //       ),
                    //     ),
                    //     Divider(
                    //       indent: 64.0,
                    //     ),
                    //     ListTile(
                    //       title: Text(
                    //         'શહેર / ગામ',
                    //         style: GoogleFonts.lato(
                    //           textStyle:
                    //               Theme.of(context).textTheme.subtitle.copyWith(
                    //                     color: Colors.black87,
                    //                   ),
                    //         ),
                    //       ),
                    //       subtitle: Text(
                    //         '',
                    //         // 'હાંસાપુર',
                    //         style: GoogleFonts.lato(
                    //           textStyle:
                    //               Theme.of(context).textTheme.subhead.copyWith(
                    //                     fontWeight: FontWeight.bold,
                    //                   ),
                    //         ),
                    //       ),
                    //       leading: Icon(
                    //         Icons.location_city,
                    //         size: 28.0,
                    //       ),
                    //     ),
                    //     Divider(
                    //       indent: 64.0,
                    //     ),
                    //     ListTile(
                    //       title: Text(
                    //         'ફોન નંબર',
                    //         style: GoogleFonts.lato(
                    //           textStyle:
                    //               Theme.of(context).textTheme.subtitle.copyWith(
                    //                     color: Colors.black87,
                    //                   ),
                    //         ),
                    //       ),
                    //       subtitle: Text(
                    //         '',
                    //         // '+91-${9408393331}',
                    //         style: GoogleFonts.lato(
                    //           textStyle:
                    //               Theme.of(context).textTheme.subhead.copyWith(
                    //                     fontWeight: FontWeight.bold,
                    //                   ),
                    //         ),
                    //       ),
                    //       leading: Icon(
                    //         Icons.phone_android,
                    //         size: 28.0,
                    //       ),
                    //     ),
                    //     Padding(
                    //       padding: const EdgeInsets.all(8.0),
                    //       child: RaisedButton(
                    //         padding: EdgeInsets.all(16.0),
                    //         shape: RoundedRectangleBorder(
                    //           borderRadius: BorderRadius.circular(4.0),
                    //         ),
                    //         color: Theme.of(context).primaryColor,
                    //         child: Text(
                    //           'પૂછપરછ',
                    //           style: GoogleFonts.lato(
                    //             textStyle:
                    //                 Theme.of(context).textTheme.title.copyWith(
                    //                       fontWeight: FontWeight.bold,
                    //                       color: Colors.white,
                    //                     ),
                    //           ),
                    //         ),
                    //         onPressed: () {
                    //           print('ProductPage: 458 - ${widget.product}');
                    //           Navigator.push(
                    //             context,
                    //             MaterialPageRoute(
                    //               builder: (context) => OrderInquiryPage(
                    //                 productId: productId,
                    //                 unitId: widget.product['unit'],
                    //                 // product: widget.product['Data'][0],
                    //                 // productData: widget.productData,
                    //               ),
                    //             ),
                    //           );
                    //         },
                    //       ),
                    //     )
                    //   ],
                    // ),
                    ListView.separated(
                      itemCount: snapshot.data['Seller'].length,
                      itemBuilder: (context, index) {
                        Map<String, dynamic> seller =
                            snapshot.data['Seller'][index];
                        return ListTile(
                          isThreeLine: true,
                          title: Text(
                            seller['Name'].toString(),
                            style: GoogleFonts.lato(
                              textStyle:
                                  Theme.of(context).textTheme.title.copyWith(
                                      // color: Colors.black87,
                                      ),
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                '${seller['Village']}, ${seller['City']}, ${seller['Dist']}, ${seller['State']}',
                                style: GoogleFonts.lato(
                                  textStyle: Theme.of(context)
                                      .textTheme
                                      .subtitle
                                      .copyWith(
                                          // color: Colors.black87,
                                          ),
                                ),
                              ),
                              SizedBox(
                                height: 2.0,
                              ),
                              Text(
                                'Phone - ${seller['Mobile']}',
                                style: GoogleFonts.lato(
                                  textStyle: Theme.of(context)
                                      .textTheme
                                      .subtitle
                                      .copyWith(
                                          // color: Colors.black87,
                                          ),
                                ),
                              ),
                            ],
                          ),
                          trailing: Container(
                            width: 140.0,
                            height: 56.0,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                InkWell(
                                  onTap: () async {
                                    String url = 'tel:+91${seller['Mobile']}';
                                    if (await canLaunch(url)) {
                                      await launch(url);
                                    } else {
                                      throw 'Could not launch $url';
                                    }
                                  },
                                  child: Container(
                                    height: 40.0,
                                    width: 40.0,
                                    child: Image.asset('call.png'),
                                  ),
                                ),
                                InkWell(
                                  onTap: () async {
                                    String url =
                                        'https://wa.me/91${seller['Mobile']}';
                                    if (await canLaunch(url)) {
                                      await launch(url);
                                    } else {
                                      throw 'Could not launch $url';
                                    }
                                  },
                                  child: Container(
                                    width: 40.0,
                                    height: 40.0,
                                    child: Image.asset('whatsapp.png'),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    print(
                                        'ProductPage: 458 - ${widget.product}');
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => OrderInquiryPage(
                                          productId: productId,
                                          unitId: widget.product['unit'],
                                          sellerId: seller['Id'],
                                          // product: widget.product['Data'][0],
                                          // productData: widget.productData,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    height: 40.0,
                                    width: 40.0,
                                    child: Image.asset('email.png'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return Divider();
                      },
                    ),
                  ],
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }
}
