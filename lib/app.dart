import 'package:assignment/model/OrderModel.dart';
import 'package:assignment/screen/HomeScreen.dart';
import 'package:assignment/screen/LoginScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyApplication extends StatelessWidget {
  final bool _isAuthenticated;

  MyApplication(
      this._isAuthenticated);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => OrderModel()),
      ],
      child: MaterialApp(
        supportedLocales: [Locale('en', 'US'), Locale('hi', '')],
        title: 'Assignment',
        initialRoute: '/',
        routes: {
          // When we navigate to the "/" route, build the FirstScreen Widget after checing the user is logged in or not
          '/': (context) => _isAuthenticated
              ? HomeScreen()
              : LoginScreen(),
          '/home': (context) => HomeScreen(),
          '/login': (context) => LoginScreen()
        },
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Color(0xff1B1DC7),
          accentColor: Color(0xff1B1DC7),
        ),
      ),
    );;
  }
}