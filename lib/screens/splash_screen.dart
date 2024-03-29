import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:scanly/screens/start_screen.dart';
import 'package:page_transition/page_transition.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return AnimatedSplashScreen(animationDuration:const Duration(milliseconds: 1500),
        splash: Image.asset("assets/images/Logo.png"),
        nextScreen:StartScreen(),
        splashTransition: SplashTransition.scaleTransition,
        backgroundColor: Color(0xff80c6dc),
        duration:1000,
      pageTransitionType: PageTransitionType.fade,
        splashIconSize:screenWidth*0.6,

      );
  }
}