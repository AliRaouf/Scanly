import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scanly/bloc/login/login_cubit.dart';
import 'package:scanly/components/custom_button.dart';
import 'package:scanly/screens/register_screen.dart';
import 'package:scanly/screens/login_screen.dart';
class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Container(color: Color(0xff80c6dc),
          child: SafeArea(
            child: Container(
                height: screenHeight,
                width: screenWidth,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/Scanly_bg.png"),
                        fit: BoxFit.cover)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                        height: screenHeight * 0.3,
                        child: Image.asset("assets/images/Logo.png")),
                    Column(
                      children: [
                        Container(
                            child: Text(
                              "Welcome To",
                              style: GoogleFonts.montserrat(
                                  fontSize: screenWidth * 0.12,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xff232425)),
                            )),
                        Container(
                            child: Text(
                              "Scanly",
                              style: GoogleFonts.montserrat(
                                  fontSize: screenWidth * 0.1333,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xff232425)),
                            )),
                        Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: screenWidth * 0.045),
                          child: Center(
                              child: Text(
                                "We are Happy that you are here our mission is to provide you with information about your tests from where you are",
                                style: GoogleFonts.openSans(
                                    fontSize: screenWidth * 0.045,
                                    color: Color(0xff777777)),
                                textAlign: TextAlign.center,
                              )),
                        ),
                      ],
                    ),
                    Container(
                      height: screenHeight * 0.18,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomButton(
                              screenWidth: screenWidth * 0.778,
                              screenHeight: screenHeight * 0.0625,
                              text: "Login",
                              onpressed: ()async{
                                await LoginCubit.get(context).loadUserEmailPassword();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginScreen()));
                              },
                              bColor: Color(0xff1A83B6),
                              borderColor: Colors.transparent,
                              textStyle: GoogleFonts.openSans(
                                  fontWeight: FontWeight.bold,
                                  fontSize: screenWidth * 0.05556,
                                  color: Colors.white)),
                          CustomButton(
                              screenWidth: screenWidth * 0.778,
                              screenHeight: screenHeight * 0.0625,
                              text: "Create New Account",
                              onpressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => RegisterScreen()));
                              },
                              bColor: Color(0xffFAFAFA),
                              borderColor: Color(0xff1A83B6),
                              textStyle: GoogleFonts.openSans(
                                  fontWeight: FontWeight.bold,
                                  fontSize: screenWidth * 0.05556,
                                  color: Color(0xff1A83B6))),
                        ],
                      ),
                    )
                  ],
                )),
          ),
        ));
  }
}
