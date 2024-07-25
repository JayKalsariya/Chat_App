import 'package:counter/myroutes/routes.dart';
import 'package:counter/services/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class OtpPage extends StatelessWidget {
  String? verificationId;
  OtpPage({super.key});

  @override
  Widget build(BuildContext context) {
    String verificationId =
        ModalRoute.of(context)!.settings.arguments as String;

    TextEditingController otp = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('OTP Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextFormField(
              controller: otp,
              keyboardType: TextInputType.phone,
              textAlign: TextAlign.center,
              textInputAction: TextInputAction.done,
              decoration: const InputDecoration(
                hintText: 'Enter OTP',
                labelStyle: TextStyle(
                  color: Colors.blue,
                ),
                labelText: 'Phone Number',
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(30.0),
                  ),
                  borderSide: BorderSide(
                    color: Colors.blue,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(30.0),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 50.0,
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade400,
                ),
                onPressed: () async {
                  try {
                    PhoneAuthCredential credential =
                        await PhoneAuthProvider.credential(
                      verificationId: verificationId,
                      smsCode: otp.text.toString(),
                    );

                    FirebaseAuth.instance
                        .signInWithCredential(credential)
                        .then((value) async {
                      await FireStoreService.instance.getUser();
                      Navigator.pushNamed(context, MyRoutes.home);
                    });
                  } catch (e) {
                    Logger().e(e.toString());
                  }
                },
                child: const Text(
                  'Verify OTP',
                  style: TextStyle(
                    color: Color(0xff1F1B24),
                    fontSize: 18.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
