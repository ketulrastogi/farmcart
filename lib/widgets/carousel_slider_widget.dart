import 'package:carousel_slider/carousel_slider.dart';
import 'package:farmcart/models/main_category_model.dart';
import 'package:farmcart/services/carousel_slider_service.dart';
import 'package:farmcart/services/category_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

class CarouselSliderWidget extends StatefulWidget {
  @override
  _CarouselSliderWidgetState createState() => _CarouselSliderWidgetState();
}

class _CarouselSliderWidgetState extends State<CarouselSliderWidget> {
  @override
  Widget build(BuildContext context) {
    CarouselSliderService carouselSliderService =
        Provider.of<CarouselSliderService>(context);

    return FutureBuilder<List<CarouselSliderImage>>(
        future: carouselSliderService.getSliderImages(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return CarouselSlider(
              height: 200.0,
              items: snapshot.data.map((image) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin:
                          EdgeInsets.symmetric(horizontal: 5.0, vertical: 8.0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.shade300,
                                blurRadius: 2.0,
                                spreadRadius: 1.0)
                          ]),
                      child: ClipRRect(
                        borderRadius: new BorderRadius.circular(8.0),
                        child: Image.network(
                          image.image,
                          fit: BoxFit.fill,
                          scale: 1.1,
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
              // aspectRatio: 16 / 9,
              viewportFraction: 0.95,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              pauseAutoPlayOnTouch: Duration(seconds: 10),
              enlargeCenterPage: true,
              onPageChanged: null,
              scrollDirection: Axis.horizontal,
            );
          } else {
            return Container(
              height: 200.0,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }
}

class CategorySliderWidget extends StatefulWidget {
  @override
  _CategorySliderWidgetState createState() => _CategorySliderWidgetState();
}

class _CategorySliderWidgetState extends State<CategorySliderWidget> {
  @override
  Widget build(BuildContext context) {
    CarouselSliderService carouselSliderService =
        Provider.of<CarouselSliderService>(context);
    final CategoryService categoryService =
        Provider.of<CategoryService>(context);
    return FutureBuilder<List<MainCategoryModel>>(
        future: categoryService.getMainCategories(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return CarouselSlider(
              height: 200.0,
              items: snapshot.data.map((product) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      // height: 120.0,
                      width: MediaQuery.of(context).size.width,
                      margin:
                          EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
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
                            bottom: 0.0,
                            // left: 0.0,
                            child: Container(
                              width: MediaQuery.of(context).size.width - 32,
                              color: Colors.grey.shade50,
                              child: Center(
                                child: Text(
                                  product.name.trim(),
                                  style: GoogleFonts.lato(
                                    textStyle: Theme.of(context)
                                        .textTheme
                                        .title
                                        .copyWith(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }).toList(),
              // aspectRatio: 16 / 9,
              viewportFraction: 0.95,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              pauseAutoPlayOnTouch: Duration(seconds: 10),
              enlargeCenterPage: true,
              onPageChanged: null,
              scrollDirection: Axis.horizontal,
            );
          } else {
            return Container(
              height: 200.0,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }
}
