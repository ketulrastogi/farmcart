import 'package:carousel_slider/carousel_slider.dart';
import 'package:farmcart/services/carousel_slider_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
