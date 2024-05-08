import 'dart:convert';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scanly/bloc/user/user_cubit.dart';

import '../bloc/test/test_cubit.dart';
import '../generated/l10n.dart';

class TestScreen extends StatelessWidget {
  final Future<Map<String, dynamic>> jsonDataFuture;

  TestScreen({required this.jsonDataFuture});

  @override
  Widget build(BuildContext context) {
    var testCubit = TestCubit.get(context);
    var userCubit = UserCubit.get(context);
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
                    S.of(context).loading1,
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
                          duration: Duration(seconds: 7),
                          S.of(context).loading2,
                          textStyle: GoogleFonts.nunito(
                            fontSize: 16.sp,
                            color: Color(0xff2b2b2b),
                          ),
                        ),
                        RotateAnimatedText(
                          duration: Duration(seconds: 7),
                          S.of(context).loading3,
                          textStyle: GoogleFonts.nunito(
                            fontSize: 16.sp,
                            color: Color(0xff2b2b2b),
                          ),
                        ),
                        RotateAnimatedText(
                          duration: Duration(seconds: 7),
                          S.of(context).loading4,
                          textStyle: GoogleFonts.nunito(
                            fontSize: 16.sp,
                            color: Color(0xff2b2b2b),
                          ),
                        ),
                        RotateAnimatedText(
                          duration: Duration(seconds: 7),
                          S.of(context).loading5,
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
            print(snapshot.error);
            return Container(
              width: 1.sw,
              height: 1.sh,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/Scanly_bg.png"),
                      fit: BoxFit.cover)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline_outlined,
                    color: Color(0xffff0000),
                  ),
                  Text(
                      "There was an Error Processing your image\nWe recommend taking a better photo of the test and trying again",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.nunito(
                          fontSize: 12.sp, color: Color(0xff232425)))
                ],
              ),
            );
          }
          else if (snapshot.hasData) {
            Map<String, dynamic> jsonData = snapshot.data!;
            if(jsonData==null || jsonData.isEmpty || jsonData["diagnosis_en"].isEmpty || jsonData["diagnosis_en"] == null || jsonData["Date"] == 'dd/MM/YYYY' || jsonData["Date"]=="DD/MM/YYYY"){
              return Container(
                width: 1.sw,
                height: 1.sh,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/Scanly_bg.png"),
                        fit: BoxFit.cover)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline_outlined,
                      color: Color(0xffff0000),
                    ),
                    Text(
                        "There was an Error Processing your image\nWe recommend taking a better photo of the test and trying again",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.nunito(
                            fontSize: 12.sp, color: Color(0xff232425)))
                  ],
                ),
              );
            }else{
            testCubit
                .uploadImage(userCubit.image!, context)
                .then((downloadUrl) {
              print('image uploaded successfully. Download URL: $downloadUrl');
              jsonData.addAll({
                "image": downloadUrl,
                "uploadDate": FieldValue.serverTimestamp()
              });
              testCubit.saveTest(context, jsonData);
            }).catchError((error) {
              print('Error uploading file: $error');
            });
            return
              Container(
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
                        child: Container(
                            height: 400.h,
                            width: 1.sw,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image(
                                image: MemoryImage(
                                    userCubit.image ?? Uint8List(0)),
                                fit: BoxFit.cover,
                              ),
                            ))),
                    SizedBox(
                      height: 10.h,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xfffafafa).withOpacity(0.3)),
                      width: 1.sw,
                      height: 200.h,
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        itemCount:
                        jsonData.isEmpty? 1:jsonData["diagnosis_en"].trim().split('. ').length,
                        itemBuilder: (context, index) {
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(right: 8.0, left: 8),
                                child: Text("•",
                                    style: GoogleFonts.nunito(
                                        fontSize: 12.sp,
                                        color: Color(0xff232425))),
                              ),
                              Expanded(
                                child: Text(jsonData["diagnosis_en"]==null?"" :
                                    "${jsonData["diagnosis_en"].trim().split('. ')[index]}.",
                                    style: GoogleFonts.nunito(
                                        fontSize: 12.sp,
                                        color: Color(0xff232425))),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    Container(
                      width: 1.sw,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(S.of(context).See_Doctor,
                                style: GoogleFonts.nunito(
                                    fontSize: 16.sp,
                                    color: Color(0xff232425),
                                    fontWeight: FontWeight.bold)),
                            Text(
                              "${jsonData["Recommendation_en"]}",
                              style: GoogleFonts.nunito(
                                  fontSize: 12.sp, color: Color(0xff232425)),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );}
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
