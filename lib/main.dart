import 'package:flutter/material.dart';
import 'package:miniproject_1/FavoritePage.dart';
import 'package:miniproject_1/cartPage.dart';
import 'package:miniproject_1/displayProductPage.dart';
import 'package:miniproject_1/forgetPasswordPage.dart';
import 'package:miniproject_1/homepage.dart';
import 'package:miniproject_1/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:miniproject_1/orderPage.dart';
import 'package:miniproject_1/register.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return buildMaterialApp();
  }

  MaterialApp buildMaterialApp() {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
         '/register': (context) => RegisterPage(),
         '/homepage': (context) => Homepage(),
         '/forgetPasswordPage': (context) => ForgetPasswordPage(),
         '/displayProductPage': (context) => displayProduct(),
         '/Favourite': (context) => Favourite(),
         '/Cart': (context) => Cart(),
         '/orderPage': (context) =>orderPage(),
      },
    );
  }
}
