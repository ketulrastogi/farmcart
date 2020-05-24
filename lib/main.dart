import 'package:farmcart/pages/home_page/home_page.dart';
import 'package:farmcart/services/auth_service.dart';
import 'package:farmcart/services/carousel_slider_service.dart';
import 'package:farmcart/services/category_service.dart';
import 'package:farmcart/services/location_service.dart';
import 'package:farmcart/services/my_team_service.dart';
import 'package:farmcart/services/order_service.dart';
import 'package:farmcart/services/product_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CarouselSliderService>(
          create: (context) => CarouselSliderService(),
        ),
        ChangeNotifierProvider<CategoryService>(
          create: (context) => CategoryService(),
        ),
        ChangeNotifierProvider<LocationService>(
          create: (context) => LocationService(),
        ),
        ChangeNotifierProvider<AuthService>(
          create: (context) => AuthService(),
        ),
        ChangeNotifierProvider<ProductService>(
          create: (context) => ProductService(),
        ),
        ChangeNotifierProvider<OrderService>(
          create: (context) => OrderService(),
        ),
        ChangeNotifierProvider<MyTeamService>(
          create: (context) => MyTeamService(),
        ),
      ],
      child: MaterialApp(
        title: 'Farm Cart',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.green,
          accentColor: Colors.orange,
        ),
        home: HomePage(),
      ),
    );
  }
}
