import 'package:farmcart/pages/seller/add_product_page.dart';
import 'package:farmcart/pages/seller/auth_pages/auth_page.dart';
// import 'package:farmcart/pages/manage_sub_category_page/manage_sub_category_page.dart';
// import 'package:farmcart/pages/manage_under_sub_category_page/manage_under_sub_category_page.dart';
import 'package:farmcart/services/auth_service.dart';
import 'package:farmcart/services/product_service.dart';
import 'package:flutter/material.dart';
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
                    builder: (context) => AuthPage(
                        // isSeller: false,
                        ),
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AuthPage(
                        // isSeller: false,
                        ),
                  ),
                );
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
              return ListView.builder(
                padding: EdgeInsets.all(16.0),
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(snapshot.data[index]['ProductName']),
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
        floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColor,
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddProductPage(),
              ),
            );
          },
        ),
      ),
    );
  }
}
