import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:strict_exam/features/authentication/screens/masuk.dart';
import 'package:strict_exam/firebase_options.dart';
import 'package:strict_exam/repository/authentication_repository/authentication_repository.dart';
import 'package:strict_exam/routing/navigation.dart';
import 'features/authentication/screens/splash.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((value) => Get.put(AuthenticationRepository()));
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  // SharedPreferences prefs = await SharedPreferences.getInstance();
  // var enter = prefs.getBool('enter');
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(primaryColor: Colors.blue),
    defaultTransition: Transition.leftToRightWithFade,
    transitionDuration: const Duration(milliseconds: 400),
    home: const Splash(),
    getPages: AppNavigation.pages,
  ));
}
