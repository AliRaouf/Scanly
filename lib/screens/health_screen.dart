import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconify_flutter/iconify_flutter.dart';

import '../components/line_chart.dart';
import '../generated/l10n.dart';

class HealthScreen extends StatelessWidget {
   HealthScreen({super.key,required this.testScores,required this.warningIcon});
var testScores;
String warningIcon;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/Scanly_bg.png"),
              fit: BoxFit.cover)),
      child: StreamBuilder<List<dynamic>>(
          stream: testScores,
          builder: (context, snapshot) {
            if (snapshot.connectionState ==
                ConnectionState.waiting) {
              CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Center(
                child: Text("error"),
              );
            } else if (snapshot.hasData) {
              //Todo: Implement Health Score List!!!!!!
              final scores = snapshot.data!;
              scores.sort((a, b) {
                List<String> datePartsA = a['Date'].split('/');
                List<String> datePartsB = b['Date'].split('/');
                int dayA = int.parse(datePartsA[0]);
                int monthA = int.parse(datePartsA[1]);
                int yearA = int.parse(datePartsA[2]);
                int dayB = int.parse(datePartsB[0]);
                int monthB = int.parse(datePartsB[1]);
                int yearB = int.parse(datePartsB[2]);
                DateTime date1 = DateTime(yearA, monthA, dayA);
                DateTime date2 = DateTime(yearB, monthB, dayB);
                return date1.compareTo(date2);
              });
              Set testNames =scores.map((map) => (map['testName'].toString())).toSet();
              List<double> scoresList = scores.map((map) => double.parse(map['healthScore'].toString())).toList();
              List<double> lastTenItems = scoresList.sublist(max(0, scoresList.length - 10), scoresList.length);
              print(testNames);
              return scores.isEmpty || scores.length==1?
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/images/no_data.png"),
                  Text(
                    S.of(context).no_tests_added,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.nunito(
                        fontSize: 18.sp,
                        color: Color(0xff232425)),
                  )
                ],
              ) :Padding(
                padding: EdgeInsets.symmetric(
                    vertical: 32.h, horizontal: 8.w),
                child: Column(
                  children: [
                    LineChartSample2(score:lastTenItems,),
                    Row(
                      children: [
                        Text(
                          S.of(context).health_check,
                          style: GoogleFonts.nunito(
                              fontSize: 20.sp,
                              color: Color(0xff232425),
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    lastTenItems[(lastTenItems.length - 1)] >=
                        lastTenItems[(lastTenItems.length - 2)]
                        ? Container(
                      child: Row(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                            EdgeInsets.only(right: 8.0.w),
                            child: Icon(
                                Icons.check_circle_rounded,
                                color: Color(0xff2a7f2d),
                                size: 40.w),
                          ),
                          Expanded(
                            child: Text(
                              S.of(context).good_health,
                              style: GoogleFonts.nunito(
                                  color: Color(0xff232425),
                                  fontSize: 14.sp,
                                  fontWeight:
                                  FontWeight.w600),
                            ),
                          )
                        ],
                      ),
                    )
                        : Container(
                      child: Row(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                            EdgeInsets.only(right: 8.0.w),
                            child: Iconify(warningIcon,
                                color: Color(0xffd22424),
                                size: 40.w),
                          ),
                          Expanded(
                            child: Text(
                              S.of(context).bad_health,
                              style: GoogleFonts.nunito(
                                  color: Color(0xff232425),
                                  fontSize: 14.sp,
                                  fontWeight:
                                  FontWeight.w600),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              );
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/images/no_data.png"),
                Text(
                  S.of(context).no_tests_added,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.nunito(
                      fontSize: 18.sp,
                      color: Color(0xff232425)),
                )
              ],
            );
          }),
    );
  }
}
