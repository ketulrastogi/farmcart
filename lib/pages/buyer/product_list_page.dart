import 'package:farmcart/pages/buyer/order_inquiry_page.dart';
import 'package:farmcart/pages/buyer/product_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductListPage extends StatefulWidget {
  final List<Map<String, dynamic>> products;

  const ProductListPage({Key key, this.products}) : super(key: key);
  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'પ્રોડક્ટ લિસ્ટ',
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
        backgroundColor: Colors.green.shade100,
        body: (widget.products == null || widget.products.length == 0)
            ? Center(
                child: Text('Products are not available.'),
              )
            : ListView.separated(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                itemCount: widget.products.length,
                itemBuilder: (context, index) {
                  Map<String, dynamic> product = widget.products[index];

                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 16.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(32.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.green.shade200,
                            blurRadius: 4.0,
                            spreadRadius: 4.0,
                          ),
                        ]),
                    child: ListTile(
                      isThreeLine: true,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductPage(
                              product: product,
                            ),
                          ),
                        );
                      },
                      leading: Container(
                        // alignment: Alignment.center,
                        // padding: EdgeInsets.only(top: 12.0),
                        // color: Colors.amber,
                        width: 56.0,
                        height: 56.0,
                        // child: Image.asset('no-image.png'),
                        child: Image.network(product['nImage']),
                      ),
                      title: Text(
                        product['Productname'],
                        style: GoogleFonts.lato(
                          textStyle: Theme.of(context).textTheme.title.copyWith(
                                fontWeight: FontWeight.w600,
                                color: Colors.grey.shade700,
                              ),
                        ),
                      ),
                      subtitle: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Text(
                            '₹ ${product['OrignalPrice']} / ${product['unit']}',
                            style: GoogleFonts.lato(
                              textStyle:
                                  Theme.of(context).textTheme.subhead.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.grey.shade600,
                                      ),
                            ),
                          ),
                          Text(
                            'Post by : ${product['personname']}',
                            style: GoogleFonts.lato(
                              textStyle:
                                  Theme.of(context).textTheme.subtitle.copyWith(
                                        // fontWeight: FontWeight.w500,
                                        color: Colors.grey.shade600,
                                      ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: 16.0,
                  );
                },
              ),
      ),
    );
  }
}
