import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scanly/bloc/api/api_cubit.dart';
import 'package:scanly/bloc/user/user_cubit.dart';

class TestScreen extends StatelessWidget {
  final Future<Map<String, dynamic>> jsonDataFuture;

  TestScreen({required this.jsonDataFuture});

  @override
  Widget build(BuildContext context) {
    var cubit = ApiCubit.get(context);
    return Scaffold(
      backgroundColor: Color(0xfffafafa),
      body: FutureBuilder<Map<String, dynamic>>(
        future: jsonDataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
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
                    padding:
                        EdgeInsets.only(left: 20.w, right: 20.w, bottom: 8.h),
                    child: LinearProgressIndicator(
                      minHeight: 5.h,
                      borderRadius: BorderRadius.circular(15.r),
                      color: Color(0xff1984B2),
                    ),
                  ),
                  Container(
                    height: 100.h,
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: AnimatedTextKit(
                      totalRepeatCount: 5,
                      animatedTexts: [
                        RotateAnimatedText(
                          duration: Duration(seconds: 4),
                          "Feeling tired? Drinking plenty of water can boost your energy levels.",
                          textStyle: GoogleFonts.nunito(
                            fontSize: 16.sp,
                            color: Color(0xff2b2b2b),
                          ),
                        ),
                        RotateAnimatedText(
                          duration: Duration(seconds: 4),
                          "Getting enough sleep is essential for managing stress, Aim for 7-9 hours of quality sleep per night",
                          textStyle: GoogleFonts.nunito(
                            fontSize: 16.sp,
                            color: Color(0xff2b2b2b),
                          ),
                        ),
                        RotateAnimatedText(
                          duration: Duration(seconds: 4),
                          "Swap out sugary snacks for healthier options like fruit, yogurt, or nuts to keep your energy up",
                          textStyle: GoogleFonts.nunito(
                            fontSize: 16.sp,
                            color: Color(0xff2b2b2b),
                          ),
                        ),
                        RotateAnimatedText(
                          duration: Duration(seconds: 4),
                          "Break up long periods of sitting by stretching or taking short walks to keep your body feeling good",
                          textStyle: GoogleFonts.nunito(
                            fontSize: 16.sp,
                            color: Color(0xff2b2b2b),
                          ),
                        )
                      ],
                      pause: const Duration(milliseconds: 250),
                    ),
                  )
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            Map<String, dynamic> jsonData = snapshot.data!;
            return Container(
              width: 1.sw,
              height: 1.sh,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/Scanly_bg.png"),
                      fit: BoxFit.cover)),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SafeArea(
                        child: Text("Result",style: GoogleFonts.nunito(fontSize:24.sp,fontWeight:FontWeight.w600,color:Color(0xff232425)),)
                ),
                    Container(
                        height: 400.h,
                        width: .9.sw,
                        child:  UserCubit.get(context).extension != null
                            ? UserCubit.get(context).extension == 'pdf'
                            ? ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: PDFView(
                              filePath: UserCubit.get(context).pickedFile?.path ?? "",
                              enableSwipe: true,
                              swipeHorizontal: true,
                              autoSpacing: false,
                              pageFling: false,
                              onRender: (_pages) {
                              }),
                        )
                            : ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.file(
                            UserCubit.get(context).fileToDisplay!,
                            fit: BoxFit.contain,
                          ),
                        )
                            : ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image(
                            image: MemoryImage(UserCubit.get(context).image ?? Uint8List(0)),
                            fit: BoxFit.cover,
                          ),
                        )),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("${jsonData["Explanation"]}",style: GoogleFonts.nunito(fontSize:16.sp,color:Color(0xff232425)),),
                    )
                  ],
                ),
              ),
            );
          } else {
            return Center(
              child: Text('No data'),
            );
          }
        },
      ),
    );
  }
}
