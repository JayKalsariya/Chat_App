import 'package:counter/screens/chatpage/chat_page.dart';
import 'package:counter/screens/friendspage/friends_page.dart';
import 'package:counter/screens/homepage/home_page.dart';
import 'package:counter/screens/signinpage/phonelogin/phone_login.dart';
import 'package:counter/screens/signinpage/sign_in_page.dart';
import 'package:counter/screens/signuppage/sign_up_page.dart';
import 'package:counter/screens/splashpage/splash_screen.dart';
import 'package:flutter/material.dart';

class MyRoutes {
  static const String splash = '/';
  static const String signin = 'signin';
  static const String phone = 'phone';
  static const String signup = 'signup';
  static const String home = 'home';
  static const String friends = 'friends';
  static const String chat = 'chat';

  static Map<String, Widget Function(BuildContext)> routes = {
    '/': (context) => const SplashScreen(),
    signin: (context) => const SigningPage(),
    signup: (context) => const SignUpPage(),
    phone: (context) => const PhoneLogin(),
    home: (context) => const HomePage(),
    friends: (context) => const FriendsPage(),
    chat: (context) => const ChatPage(),
  };
}
