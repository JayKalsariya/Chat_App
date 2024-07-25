import 'package:counter/firebase_options.dart';
import 'package:counter/myapp.dart';
import 'package:counter/services/firestore_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // await FireStoreService.instance.getUser();
  runApp(
    const MyApp(),
  );
}
