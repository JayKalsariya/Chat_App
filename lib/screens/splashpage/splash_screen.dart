import 'package:counter/global.dart';
import 'package:counter/myroutes/routes.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    whereToNext();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Splash Screen',
          style: TextStyle(fontSize: 30),
        ),
      ),
    );
  }

  Future<void> whereToNext() async {
    var pref = await SharedPreferences.getInstance();
    var isLoggedIn = pref.getBool(Global.isLogin);
    Future.delayed(
      const Duration(seconds: 3),
      () {
        if (isLoggedIn != null) {
          (isLoggedIn)
              ? Navigator.pushReplacementNamed(context, MyRoutes.home)
              : Navigator.pushReplacementNamed(context, MyRoutes.signin);
        } else {
          Navigator.pushReplacementNamed(context, MyRoutes.signin);
        }
      },
    );
  }
}
