import 'package:farmcart/pages/buyer/product_search_page.dart';
import 'package:farmcart/pages/contact_us_page.dart';
import 'package:farmcart/pages/home_page/home_page.dart';
import 'package:farmcart/pages/seller/add_product_page.dart';
import 'package:farmcart/pages/seller/auth_pages/auth_page.dart';
import 'package:farmcart/pages/seller/auth_pages/change_password_page.dart';
import 'package:farmcart/pages/seller/order_inquiry_List_page.dart';
import 'package:farmcart/pages/web_viewer_page.dart';
import 'package:farmcart/services/auth_service.dart';
import 'package:farmcart/services/product_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SellerHomePage extends StatefulWidget {
  @override
  _SellerHomePageState createState() => _SellerHomePageState();
}

class _SellerHomePageState extends State<SellerHomePage> {
  @override
  Widget build(BuildContext context) {
    final AuthService _authService = Provider.of<AuthService>(context);
    final ProductService _productService = Provider.of<ProductService>(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'FARM CART',
            style: GoogleFonts.lato(
              textStyle: Theme.of(context).textTheme.title.copyWith(
                    fontWeight: FontWeight.w900,
                    color: Theme.of(context).primaryColor,
                  ),
            ),
          ),
          actions: <Widget>[
            RaisedButton(
              color: Theme.of(context).primaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0)),
              child: Text(
                'ખરીદ',
                style: GoogleFonts.lato(
                  textStyle: Theme.of(context).textTheme.title.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductSearchPage(),
                  ),
                );
              },
            ),
            RaisedButton(
              color: Theme.of(context).accentColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0)),
              child: Text(
                'વેચાણ',
                style: GoogleFonts.lato(
                  textStyle: Theme.of(context).textTheme.title.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                ),
              ),
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => AuthPage(
                //         // isSeller: false,
                //         ),
                //   ),
                // );
              },
            ),
          ],
          titleSpacing: 0.0,
          elevation: 1.0,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(
              // color: Theme.of(context).primaryColor,
              // color: Colors.white,
              ),
        ),
        drawer: Drawer(
          child: Container(
            height: 112.0,
            child: ListView(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height / 4,
                  // color: Colors.green,
                  padding: EdgeInsets.all(0.0),
                  child: Image.asset(
                    'farmcartlogo.png',
                    fit: BoxFit.cover,
                  ),
                ),
                Divider(
                  height: 2.0,
                  thickness: 2.0,
                ),
                ListTile(
                  title: Text(
                    'Home',
                    style: GoogleFonts.lato(fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(),
                      ),
                    );
                  },
                ),
                Divider(
                  indent: 16.0,
                ),
                ListTile(
                  title: Text(
                    'My Order Inquiries',
                    style: GoogleFonts.lato(fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OrderInquiryListPage(),
                      ),
                    );
                  },
                ),
                Divider(
                  indent: 16.0,
                ),
                ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ContactUsPage(),
                      ),
                    );
                  },
                  title: Text('Contact Us'),
                ),
                Divider(
                  indent: 16.0,
                ),
                ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WebViewerPage(
                          title: 'Privacy Policy',
                          url:
                              'https://farmcart.in/Pagedetail.aspx?pageid=n47QIBL1esUajosHZp2n',
                        ),
                      ),
                    );
                  },
                  title: Text('Privacy Policy'),
                ),
                Divider(
                  indent: 16.0,
                ),
                ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WebViewerPage(
                          title: 'Terms & Conditions',
                          url:
                              'https://farmcart.in/Pagedetail.aspx?pageid=5KZCNN649fc8Jcq26Cui',
                        ),
                      ),
                    );
                  },
                  title: Text('Terms & Conditions'),
                ),
                Divider(
                  indent: 16.0,
                ),
                ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WebViewerPage(
                          title: 'Return & Refund Policy',
                          url:
                              'https://farmcart.in/Pagedetail.aspx?pageid=X6j6KR2mVubBHB0QPedw',
                        ),
                      ),
                    );
                  },
                  title: Text('Return & Refund Policy'),
                ),
                Divider(
                  indent: 16.0,
                ),
                ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChangePasswordPage(),
                      ),
                    );
                  },
                  title: Text('Change Password'),
                ),
                Divider(
                  indent: 16.0,
                ),
                ListTile(
                  onTap: () {
                    _authService.signOut();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AuthPage(
                            // isSeller: false,
                            ),
                      ),
                    );
                  },
                  title: Text('Sign out'),
                ),
                Divider(
                  indent: 16.0,
                ),
              ],
            ),
          ),
        ),
        backgroundColor: Colors.orange.shade100,
        body: FutureBuilder<List<Map<String, dynamic>>>(
          future: _productService.getProducts(),
          builder:
              (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
            if (snapshot.hasData) {
              // print(snapshot.data);
              return ListView.separated(
                // padding: EdgeInsets.all(16.0),
                itemCount: snapshot.data.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return ListTile(
                      title: Text(
                        'મારી પ્રોડક્ટ',
                        style: GoogleFonts.lato(
                          textStyle:
                              Theme.of(context).textTheme.headline.copyWith(
                                    fontWeight: FontWeight.bold,
                                    // color: Colors.white,
                                  ),
                        ),
                      ),
                    );
                  }
                  Map<String, dynamic> product = snapshot.data[index - 1];
                  return Slidable(
                    actionPane: SlidableDrawerActionPane(),
                    actionExtentRatio: 0.25,
                    secondaryActions: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(32.0),
                        child: IconSlideAction(
                          caption: 'સુધારો',
                          color: Colors.yellow,
                          icon: Icons.edit,
                          onTap: () async {
                            Map<String, dynamic> data = await _productService
                                .getSingleProductById(product['Id']);
                            // print(data);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddProductPage(
                                  productId: product['Id'],
                                  product: {...data, 'Photo': product['Photo']},
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(32.0),
                        child: IconSlideAction(
                          caption: 'ડીલીટ',
                          color: Colors.red,
                          icon: Icons.delete,
                          onTap: () async {
                            try {
                              await _productService
                                  .deleteProductById(product['Id']);
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text('SUCCESS'),
                                      content: Text(
                                          'Product is deleted successfully.'),
                                      actions: <Widget>[
                                        FlatButton(
                                          color: Theme.of(context).primaryColor,
                                          child: Text(
                                            'OK',
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ],
                                    );
                                  });
                              setState(() {});
                            } catch (e) {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text('ERROR'),
                                      content: Text(
                                          'An error occured while deleting a product.'),
                                      actions: <Widget>[
                                        FlatButton(
                                          color: Theme.of(context).primaryColor,
                                          child: Text(
                                            'OK',
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ],
                                    );
                                  });
                            }
                            // print(data);
                          },
                        ),
                      ),
                    ],
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 16.0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(32.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.orange.shade200,
                              blurRadius: 4.0,
                              spreadRadius: 4.0,
                            ),
                          ]),
                      child: ListTile(
                        title: Text(
                          product['ProductName'],
                          style: GoogleFonts.lato(
                            textStyle:
                                Theme.of(context).textTheme.title.copyWith(
                                      fontWeight: FontWeight.w700,
                                      color: Colors.orange,
                                    ),
                          ),
                        ),
                        contentPadding: EdgeInsets.only(left: 0.0, right: 16.0),
                        leading: Container(
                          height: 56.0,
                          width: 56.0,
                          // margin: EdgeInsets.only(left: 8.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(32.0),
                            color: Colors.white,
                            // boxShadow: [
                            //   BoxShadow(
                            //     color: Colors.orange.shade100,
                            //     blurRadius: 4.0,
                            //     spreadRadius: 4.0,
                            //   ),
                            // ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(32.0),
                            child: Image.network(
                              product['Photo'],
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        trailing: (product['Status'] == 'Active')
                            ? Icon(
                                Icons.done,
                                color: Colors.green,
                              )
                            : Icon(
                                Icons.close,
                                color: Colors.red,
                              ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  // return Divider();
                  return SizedBox(
                    height: 8.0,
                  );
                },
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
        floatingActionButton: RaisedButton(
          color: Theme.of(context).accentColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Container(
            width: 132.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 4.0,
                ),
                Text(
                  'નવી પ્રોડક્ટ ઉમેરો',
                  style: GoogleFonts.lato(
                    textStyle: Theme.of(context).textTheme.subhead.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                  ),
                ),
              ],
            ),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddProductPage(
                  productId: null,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
