import 'package:counter/myroutes/routes.dart';
import 'package:counter/services/auth_services.dart';
import 'package:counter/utils/extension.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController ec = TextEditingController();
    TextEditingController pc = TextEditingController();
    TextEditingController cpc = TextEditingController();

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
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
                        blurRadius: 5,
                        spreadRadius: 5,
                        offset: const Offset(0, 0),
                      ),
                    ],
                  ),
                  child: const CircleAvatar(
                    radius: 50.0,
                    backgroundColor: Color(0xff1F1B24),
                    child: Icon(
                      size: 50,
                      Icons.person,
                      color: Colors.white,
                    ),
                  ),
                ),
                40.0.height,
                //Email
                TextFormField(
                  controller: ec,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.person),
                    labelStyle: TextStyle(
                      color: Colors.blue.shade400,
                    ),
                    labelText: 'Email',
                    focusedBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(15.0),
                      ),
                      borderSide: BorderSide(
                        color: Colors.blue.shade400,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15.0),
                      ),
                    ),
                  ),
                ),
                15.0.height,
                //Password
                TextFormField(
                  controller: pc,
                  obscureText: true,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.security),
                    labelText: 'Password',
                    labelStyle: TextStyle(
                      color: Colors.blue.shade400,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(15.0),
                      ),
                      borderSide: BorderSide(
                        color: Colors.blue.shade400,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15.0),
                      ),
                    ),
                  ),
                ),
                15.0.height,
                //Confirm Password
                TextFormField(
                  controller: cpc,
                  obscureText: true,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.security),
                    labelText: 'Confirm Password',
                    labelStyle: TextStyle(
                      color: Colors.blue.shade400,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(15.0),
                      ),
                      borderSide: BorderSide(
                        color: Colors.blue.shade400,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15.0),
                      ),
                    ),
                  ),
                ),
                40.0.height,
                //Sign Up Button
                SizedBox(
                  height: 50.0,
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade400,
                    ),
                    onPressed: () async {
                      Logger().i('Button Pressed');
                      if (pc.text == cpc.text) {
                        User? user = await AuthServices.instance.signUp(
                          email: ec.text,
                          password: pc.text,
                        );
                        if (user != null) {
                          Navigator.pushReplacementNamed(
                              context, MyRoutes.home);
                        }
                      }
                    },
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(
                        color: Color(0xff1F1B24),
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ),
                5.0.height,
                //Already have an account?
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Already have an account?'),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/');
                      },
                      child: Text(
                        'Sign In',
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
    );
  }
}
