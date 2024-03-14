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
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return AnimatedSplashScreen(animationDuration:const Duration(seconds:2),
        splash: Image.asset("assets/images/Logo.png"),
        nextScreen: StartScreen(),
        splashTransition: SplashTransition.scaleTransition,
      pageTransitionType: PageTransitionType.topToBottom,
        backgroundColor: Color(0xff80c6dc),
        duration:2100,
        splashIconSize:screenWidth*0.6,

      );
  }
}