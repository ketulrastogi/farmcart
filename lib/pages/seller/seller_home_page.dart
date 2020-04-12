import 'package:farmcart/pages/buyer/product_search_page.dart';
import 'package:farmcart/pages/home_page/home_page.dart';
import 'package:farmcart/pages/seller/add_product_page.dart';
import 'package:farmcart/pages/seller/auth_pages/auth_page.dart';
import 'package:farmcart/pages/seller/order_inquiry_List_page.dart';
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
                  title: Text('About Us'),
                ),
                Divider(
                  indent: 16.0,
                ),
                ListTile(
                  title: Text('Contact Us'),
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
                        'My Products',
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
                      IconSlideAction(
                        caption: 'Edit',
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
                                product: data,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                    child: ListTile(
                      title: Text(
                        product['ProductName'],
                        style: GoogleFonts.lato(
                          textStyle:
                              Theme.of(context).textTheme.subhead.copyWith(
                                    fontWeight: FontWeight.w700,
                                    // color: Colors.white,
                                  ),
                        ),
                      ),
                      leading: Container(
                        height: 40.0,
                        width: 40.0,
                        child: Image.network(
                          product['Photo'],
                          fit: BoxFit.fill,
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
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider();
                },
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          // backgroundColor: Theme.of(context).primaryColor,
          child: Icon(
            Icons.add,
            color: Colors.white,
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
