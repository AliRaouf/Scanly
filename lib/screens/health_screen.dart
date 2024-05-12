import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:intl/intl.dart';

import '../components/line_chart.dart';
import '../generated/l10n.dart';

class HealthScreen extends StatefulWidget {
  HealthScreen(
      {super.key, required this.testScores, required this.warningIcon});

  var testScores;
  String warningIcon;

  @override
  State<HealthScreen> createState() => _HealthScreenState();
}

class _HealthScreenState extends State<HealthScreen> {
  var testController = TextEditingController();
  List<double>? testScr;
  Set? testNames;
  List<double>? scoresList;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/Scanly_bg.png"),
              fit: BoxFit.cover)),
      child: StreamBuilder<List<dynamic>>(
          stream: widget.testScores,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
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
              if (Intl.getCurrentLocale()=='en') {
                testNames =
                    scores.map((map) => (map['testName'].toString())).toSet();
                scoresList = scores
                    .map((map) => double.parse(map['healthScore'].toString()))
                    .toList();
              }else{
                testNames =
                scores.map((map) => (map['testName_ar'].toString())).toSet();
                scoresList = scores
                    .map((map) => double.parse(map['healthScore'].toString()))
                    .toList();
              }
              List<double> lastTenItems = scoresList!.sublist(
                  max(0, scoresList!.length - 10), scoresList!.length);
              return scores.isEmpty || scores.length == 1
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("assets/images/no_data.png"),
                        Text(
                          S.of(context).no_tests_added,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.nunito(
                              fontSize: 18.sp, color: Color(0xff232425)),
                        )
                      ],
                    )
                  : Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 40.h, horizontal: 8.w),
                      child: Column(
                        children: [
                          Container(decoration: BoxDecoration(color: Color(0xfffefefe),borderRadius: BorderRadius.circular(10)),
                            child: DropdownMenu(hintText: Intl.getCurrentLocale()=='en' ?"Select a Test":"اختار تحليل",
                              onSelected: (value){
                                testController.text=value;
                                if (Intl.getCurrentLocale()=='en') {
                                  testScr=scores.where((element) => element['testName']==testController.text).map((map) => double.parse(map['healthScore'].toString()))
                                      .toList();
                                }else{
                                  testScr=scores.where((element) => element['testName_ar']==testController.text).map((map) => double.parse(map['healthScore'].toString()))
                                      .toList();
                                }
                              setState(() {
                                print(testScr);
                              });
                            },
                              controller: testController,
                              inputDecorationTheme: InputDecorationTheme(
                                constraints: BoxConstraints(maxHeight: 0.075.sh),
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        color: Color(0xff3DADA1))),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        color: Color(0xff3DADA1))),
                              ),
                              dropdownMenuEntries: testNames!.map((item) {
                                return DropdownMenuEntry(
                                  value: item,
                                  label: item.toString(),
                                );
                              }).toList(),
                            ),
                          ),
                          Column(
                            children: [
                              testScr!=null?
                              Column(
                                children: [
                                  LineChartSample2(
                                    score: testScr!
                                  ),
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
                                  // lastTenItems[(lastTenItems.length - 1)] >=
                                  //         lastTenItems[(lastTenItems.length - 2)]
                                          testScr!.length>=2?testScr![(testScr!.length-1)] >= testScr![(testScr!.length-2)]
                                      ? Container(
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(right: 8.0.w),
                                                child: Icon(Icons.check_circle_rounded,
                                                    color: Color(0xff2a7f2d),
                                                    size: 40.w),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  S.of(context).good_health,
                                                  style: GoogleFonts.nunito(
                                                      color: Color(0xff232425),
                                                      fontSize: 14.sp,
                                                      fontWeight: FontWeight.w600),
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
                                                padding: EdgeInsets.only(right: 8.0.w),
                                                child: Iconify(widget.warningIcon,
                                                    color: Color(0xffd22424),
                                                    size: 40.w),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  S.of(context).bad_health,
                                                  style: GoogleFonts.nunito(
                                                      color: Color(0xff232425),
                                                      fontSize: 14.sp,
                                                      fontWeight: FontWeight.w600),
                                                ),
                                              )
                                            ],
                                          ),
                                        ):
                                          Intl.getCurrentLocale()=='en'?Text("You need at least 2 tests",style: GoogleFonts.nunito(),):Text("تحتاج إلى اختبارين على الأقل",style: GoogleFonts.nunito(),)
                                ],
                              ):SizedBox.shrink()
                            ],
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
                      fontSize: 18.sp, color: Color(0xff232425)),
                )
              ],
            );
          }),
    );
  }
}
