import 'package:flutter/material.dart';
import 'package:manage_product/screens/login.dart';
import 'package:manage_product/screens/products.dart';
import 'package:manage_product/screens/screen1.dart';
import 'package:manage_product/screens/signup.dart';
import 'constant.dart';

import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var email = prefs.getString('user_token');
  runApp(
      MaterialApp(
      title: 'Manage Product',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          useMaterial3: false,
          primaryColor: primaryColor,
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: customMaterialColor,
          ),
          scaffoldBackgroundColor: backgroundColor,
      ),
      home: email == null ? const LoginPage() : const ProductPage()));
}
