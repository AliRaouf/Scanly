import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:scanly/firebase_options.dart';
import 'package:scanly/src/app_root.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'amplifyconfiguration.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final onboarding = prefs.getBool("onboarding") ?? false;
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  // Add Storage plugin to Amplify
  await Amplify.addPlugins([AmplifyStorageS3(), AmplifyAuthCognito()]);

  // Configure Amplify
  await Amplify.configure(amplifyconfig);
  runApp(AppRoot(
    onboarding: onboarding,
  ));
}
