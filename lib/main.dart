import 'package:assignment/app.dart';
import 'package:assignment/util/PrefKey.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Color(0xff1B1DC7),
  ));

  final _isAuthenticated = await isUserLogin();

  runApp(MyApplication(_isAuthenticated));
}

Future<bool> isUserLogin() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return await prefs.getString(PrefKey.PREF_KEY_USERID) != null;
}