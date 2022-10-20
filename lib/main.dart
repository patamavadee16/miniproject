import 'package:flutter/material.dart';
import 'package:miniproject_1/editProfilePic.dart';
import 'package:miniproject_1/favorite_Page.dart';
import 'package:miniproject_1/addUserData.dart';
import 'package:miniproject_1/cart_Page.dart';
import 'package:miniproject_1/displayProduct_Page.dart';
import 'package:miniproject_1/editProfile_Page.dart';
import 'package:miniproject_1/forgotPassword_Page.dart';
import 'package:miniproject_1/homepage.dart';
import 'package:miniproject_1/login_Page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:miniproject_1/order_Page.dart';
import 'package:miniproject_1/profile_page.dart';
import 'package:miniproject_1/register_Page.dart';
import 'package:miniproject_1/createReview_Page.dart';
import 'package:miniproject_1/reviewPage.dart';

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
        primarySwatch: Colors.grey
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
         '/register': (context) => RegisterPage(),
         '/homepage': (context) => Homepage(),
         '/forgotPasswordPage': (context) => ForgetPasswordPage(),
         '/displayProductPage': (context) => displayProduct(),
         '/Favourite': (context) => Favourite(),
         '/Cart': (context) => Cart(),
         '/orderPage': (context) =>orderPage(),
         '/userForm': (context) =>UserForm(),
         '/profile_page': (context) =>Profile(),
         '/editProfile_page': (context) =>editProfile(),
         '/createReview': (context) =>createReviewPost(),
         '/reviewPage': (context) =>reviewPage(),
         '/editProfilePic': (context) =>editProfilePic()
        //  '/ShowDetailPost': (context) =>ShowDetailPost(),
      },
    );
  }
}
