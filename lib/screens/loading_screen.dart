import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Color(0xfffafafa),
      body: Column(mainAxisAlignment: MainAxisAlignment.center,
              children: [
      Text(
        "Getting Your Results!",
        style: GoogleFonts.nunito(
            fontSize: 24.sp,
            fontWeight: FontWeight.w600,
            color: Color(0xff232425)),
      ),
      Image.asset('assets/images/Waiting.gif'),
      Padding(
        padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 8.h),
        child: LinearProgressIndicator(
          minHeight: 5.h,
          borderRadius: BorderRadius.circular(15.r),
          color: Color(0xff1984B2),
        ),
      ),
                Container(height: 100.h,padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: AnimatedTextKit(totalRepeatCount: 5,
                    animatedTexts: [
                      RotateAnimatedText(duration: Duration(seconds: 4),
                        "Feeling tired? Drinking plenty of water can boost your energy levels.",
                        textStyle: GoogleFonts.nunito(
                          fontSize: 16.sp,
                          color:Color(0xff2b2b2b),
                        ),
                      ),
                      RotateAnimatedText(duration: Duration(seconds: 4),
                        "Getting enough sleep is essential for managing stress, Aim for 7-9 hours of quality sleep per night",
                        textStyle: GoogleFonts.nunito(
                          fontSize: 16.sp,
                          color:Color(0xff2b2b2b),
                        ),

                      ),
                      RotateAnimatedText(duration: Duration(seconds: 4),
                        "Swap out sugary snacks for healthier options like fruit, yogurt, or nuts to keep your energy up",
                        textStyle: GoogleFonts.nunito(
                          fontSize: 16.sp,
                          color:Color(0xff2b2b2b),
                        ),

                      ),
                      RotateAnimatedText(duration: Duration(seconds: 4),
                        "Break up long periods of sitting by stretching or taking short walks to keep your body feeling good",
                        textStyle: GoogleFonts.nunito(
                          fontSize: 16.sp,
                          color:Color(0xff2b2b2b),
                        ),

                      )
                    ],
                    pause: const Duration(milliseconds: 250),
                  ),
                )
              ],
            ),
    );
  }
}