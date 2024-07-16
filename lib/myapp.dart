import 'package:counter/myroutes/routes.dart';
import 'package:counter/screens/homepage/home_page.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Counter & Firebase',
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      routes: MyRoutes.routes,
    );
  }
}
