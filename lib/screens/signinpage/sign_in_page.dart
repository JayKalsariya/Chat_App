import 'package:counter/global.dart';
import 'package:counter/myroutes/routes.dart';
import 'package:counter/services/auth_services.dart';
import 'package:counter/services/firestore_service.dart';
import 'package:counter/utils/extension.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SigningPage extends StatelessWidget {
  const SigningPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController email = TextEditingController();
    TextEditingController password = TextEditingController();

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
//Profile Pic
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blue.shade400,
                          blurRadius: 10,
                          spreadRadius: 5,
                          offset: const Offset(0, 0),
                        ),
                      ],
                    ),
                    child: const CircleAvatar(
                      radius: 50.0,
                      backgroundColor: Color(0xff1F1B24),
                      child: Icon(
                        size: 70,
                        Icons.person,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  40.0.height,
//Email
                  TextFormField(
                    controller: email,
                    decoration: InputDecoration(
                      labelStyle: TextStyle(
                        color: Colors.blue.shade400,
                      ),
                      labelText: 'Email',
                      focusedBorder: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(30.0),
                        ),
                        borderSide: BorderSide(
                          color: Colors.blue.shade400,
                        ),
                      ),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(30.0),
                        ),
                      ),
                    ),
                  ),
                  15.0.height,
//Password
                  TextFormField(
                    obscureText: true,
                    controller: password,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(
                        color: Colors.blue.shade400,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(30.0),
                        ),
                        borderSide: BorderSide(
                          color: Colors.blue.shade400,
                        ),
                      ),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(30.0),
                        ),
                      ),
                    ),
                  ),
                  10.0.height,
//Forgot Password
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(
                        color: Colors.blue.shade400,
                      ),
                    ),
                  ),
                  40.0.height,
//Sign In Button
                  SizedBox(
                    height: 50.0,
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade400,
                      ),
                      onPressed: () async {
                        User? user = await AuthServices.instance
                            .signIn(email: email.text, password: password.text);
                        // AuthServices.instance.anonymousLogin().then((value) {
                        //   Navigator.pushReplacementNamed(
                        //       context, MyRoutes.home);
                        // });
                        if (user != null) {
                          await FireStoreService.instance.getUser();
                          var pref = await SharedPreferences.getInstance();
                          pref.setBool(Global.isLogin, true);
                          Navigator.pushReplacementNamed(
                              context, MyRoutes.home);
                        }
                      },
                      child: const Text(
                        'Sign In',
                        style: TextStyle(
                          color: Color(0xff1F1B24),
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  ),
                  20.0.height,
//Or
                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: Colors.blue.shade400,
                        ),
                      ),
                      const Text('  Or  '),
                      Expanded(
                        child: Divider(
                          color: Colors.blue.shade400,
                        ),
                      ),
                    ],
                  ),
                  35.0.height,
//Sign in with
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
//Phone
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, MyRoutes.phone);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.blue.shade400,
                                blurRadius: 5,
                                spreadRadius: 3,
                                offset: const Offset(0, 0),
                              ),
                            ],
                          ),
                          child: const CircleAvatar(
                            radius: 25.0,
                            backgroundColor: Color(0xff1F1B24),
                            child: Icon(
                              Icons.phone_android_outlined,
                            ),
                          ),
                        ),
                      ),
                      20.0.width,
//Facebook
//                       Container(
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.blue.shade400,
//                               blurRadius: 5,
//                               spreadRadius: 3,
//                               offset: const Offset(0, 0),
//                             ),
//                           ],
//                         ),
//                         child: const CircleAvatar(
//                           radius: 25.0,
//                           backgroundColor: Color(0xff1F1B24),
//                           child: Text(
//                             'f',
//                             style: TextStyle(fontSize: 30),
//                           ),
//                         ),
//                       ),
//                       20.0.width,
//Google
                      GestureDetector(
                        onTap: () async {
                          UserCredential userCredential =
                              await AuthServices.instance.signInWithGoogle();
                          User? user = userCredential.user;

                          if (user != null) {
                            await FireStoreService.instance.addUser(user: user);
                            await FireStoreService.instance.getUser();
                            Navigator.pushReplacementNamed(
                              context,
                              'home',
                            );
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.blue.shade400,
                                blurRadius: 5,
                                spreadRadius: 3,
                                offset: const Offset(0, 0),
                              ),
                            ],
                          ),
                          child: const CircleAvatar(
                            radius: 25.0,
                            backgroundColor: Color(0xff1F1B24),
                            child: Text(
                              'G',
                              style: TextStyle(fontSize: 26),
                            ),
                          ),
                        ),
                      ),
                      20.0.width,
//Apple
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blue.shade400,
                              blurRadius: 5,
                              spreadRadius: 3,
                              offset: const Offset(0, 0),
                            ),
                          ],
                        ),
                        child: const CircleAvatar(
                          radius: 25.0,
                          backgroundColor: Color(0xff1F1B24),
                          child: Icon(
                            Icons.apple,
                            color: Colors.white,
                            size: 26.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                  20.0.height,
//Sign Up
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Don\'t have an account?'),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                            context,
                            'signup',
                          );
                        },
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            color: Colors.blue.shade400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
