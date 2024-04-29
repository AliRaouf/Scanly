import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scanly/bloc/login/login_cubit.dart';
import 'package:scanly/components/custom_button.dart';
import 'package:scanly/screens/register_screen.dart';
import 'package:scanly/screens/login_screen.dart';

import '../components/custom_page_route.dart';
import '../generated/l10n.dart';
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
    return Scaffold(
        body: Container(color: Color(0xff80c6dc),
          child: Container(
              height: 1.sh,
              width: 1.sw,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/Scanly_bg.png"),
                      fit: BoxFit.cover)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                      height: 300.h,
                      child: Image.asset("assets/images/logo_only.png")),
                  Column(
                    children: [
                      Text(
                        "${S.of(context).welcome}",textAlign: TextAlign.center,
                        style: GoogleFonts.montserrat(
                            fontSize: 44.sp,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xff232425)),
                      ),

                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 12.w),
                        child: Center(
                            child: Text(
                              S.of(context).start,
                              style: GoogleFonts.nunito(
                                  fontSize: 16.sp,
                                  color: Color(0xff777777)),
                              textAlign: TextAlign.center,
                            )),
                      ),
                    ],
                  ),
                  Container(
                    height: 130.h,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomButton(
                            screenWidth: 280.w,
                            screenHeight: 50.h,
                            text: S.of(context).login,
                            onpressed: () async {
                              await LoginCubit.get(context).loadUserEmailPassword();
                              Navigator.push(
                                  context,
                                  AnimatedRoute(page: LoginScreen()));
                              },
                            bColor: Color(0xff1A83B6),
                            borderColor: Colors.transparent,
                            textStyle: GoogleFonts.nunito(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.sp,
                                color: Colors.white)),
                        CustomButton(
                            screenWidth: 280.w,
                            screenHeight: 50.h,
                            text: S.of(context).create_account,
                            onpressed: () {
                              Navigator.push(
                                  context,
                                  AnimatedRoute(page: RegisterScreen()));
                            },
                            bColor: Color(0xffFAFAFA),
                            borderColor: Color(0xff1A83B6),
                            textStyle: GoogleFonts.nunito(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.sp,
                                color: Color(0xff1A83B6))),
                      ],
                    ),
                  )
                ],
              )),
        ));
  }
}
