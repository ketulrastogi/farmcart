import 'package:farmcart/models/main_category_model.dart';
import 'package:farmcart/pages/buyer/product_search_page.dart';
import 'package:farmcart/pages/contact_us_page.dart';
import 'package:farmcart/pages/seller/auth_pages/auth_page.dart';
import 'package:farmcart/pages/seller/seller_home_page.dart';
import 'package:farmcart/pages/web_viewer_page.dart';
import 'package:farmcart/services/category_service.dart';
import 'package:farmcart/widgets/carousel_slider_widget.dart';
import 'package:farmcart/widgets/marquee_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _is_seller = false;

  @override
  Widget build(BuildContext context) {
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
                borderRadius: BorderRadius.circular(0.0),
              ),
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
                borderRadius: BorderRadius.circular(0.0),
              ),
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
        backgroundColor: Colors.white,
        body: ListView(
          // padding: EdgeInsets.only(top: 8.0),
          children: <Widget>[
            SizedBox(
              height: 8.0,
            ),
            CarouselSliderWidget(),
            SizedBox(
              height: 8.0,
            ),
            AutoScrollText(
              // height: 56.0,
              items: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width * 2.5,
                  alignment: Alignment.center,
                  child: InkWell(
                    onTap: () async {
                      const url =
                          'https://www.youtube.com/channel/UC4YkDw7nT6nZX43Wa85CpIQ';
                      if (await canLaunch(url)) {
                        await launch(url);
                      } else {
                        throw 'Could not launch $url';
                      }
                    },
                    child: Text(
                      "વિડિઓ જોવા માટે અહીંયા ક્લીક કરો.",
                      style: GoogleFonts.lato(
                        textStyle: Theme.of(context).textTheme.subhead.copyWith(
                              fontWeight: FontWeight.w900,
                              color: Theme.of(context).accentColor,
                            ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 16.0,
            ),
            MainCategoriesListWidget(),
          ],
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MainCategoriesListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CategoryService categoryService =
        Provider.of<CategoryService>(context);

    return FutureBuilder<List<MainCategoryModel>>(
        future: categoryService.getMainCategories(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
              height: 420.0,
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: GridView.count(
                crossAxisCount: 3,
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
                childAspectRatio: 1.2,
                padding: EdgeInsets.only(
                    top: 8.0, left: 8.0, right: 8.0, bottom: 64.0),
                children: snapshot.data.map((product) {
                  // Product product = Product.fromFirestore(document);
                  return Container(
                    height: 88.0,
                    width: 88.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.blueGrey.shade50,
                            blurRadius: 2.0,
                            spreadRadius: 2.0)
                      ],
                    ),
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          top: 0.0,
                          left: 0.0,
                          right: 0.0,
                          bottom: 32.0,
                          child: ClipRRect(
                            borderRadius: new BorderRadius.only(
                                topRight: Radius.circular(8.0),
                                topLeft: Radius.circular(8.0)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.network(
                                product.imageUrl,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 8.0,
                          left: 0.0,
                          child: Container(
                            width: MediaQuery.of(context).size.width / 3 - 12,
                            child: Center(
                              child: Text(
                                product.name,
                                style: GoogleFonts.lato(
                                  textStyle: Theme.of(context)
                                      .textTheme
                                      .caption
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            );
          } else {
            return Center(
              child: Container(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }
}
