import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scanly/firebase_options.dart';
import 'package:scanly/src/app_root.dart';

Future<void>main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    // Add DeviceOrientation.portraitDown if you also want upside-down portrait
  ]);
  runApp(const AppRoot());
}