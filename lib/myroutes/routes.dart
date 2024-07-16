import 'package:counter/screens/homepage/home_page.dart';
import 'package:counter/screens/signinpage/phone_login.dart';
import 'package:counter/screens/signinpage/sign_in_page.dart';
import 'package:counter/screens/signuppage/sign_up_page.dart';
import 'package:flutter/material.dart';

class MyRoutes {
  static const String signin = '/';
  static const String phone = 'phone';
  static const String signup = 'signup';
  static const String home = 'home';

  static Map<String, Widget Function(BuildContext)> routes = {
    home: (context) => const HomePage(),
    phone: (context) => const PhoneLogin(),
    '/': (context) => const SigningPage(),
    signup: (context) => const SignUpPage(),
  };
}
