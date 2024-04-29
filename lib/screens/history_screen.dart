import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../components/custom_page_route.dart';
import '../generated/l10n.dart';
import 'history_test_screen.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({
    super.key,
    required this.testHistory,
  });

  final testHistory;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 1.sw,
        height: 1.sh,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/Scanly_bg.png"),
                fit: BoxFit.cover)),
        child: StreamBuilder<List<dynamic>>(
          stream: testHistory,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Center(
                child: Text("error"),
              );
            } else if (snapshot.hasData) {
              final tests = snapshot.data!;
              tests.sort((a, b) {
                Timestamp date1 = a["uploadDate"];
                Timestamp date2 = b["uploadDate"];
                return date2.compareTo(date1);
              });
              return SafeArea(
                child: tests.isEmpty
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
                    : ListView.builder(
                        padding: EdgeInsets.symmetric(horizontal: 24.w),
                        physics: BouncingScrollPhysics(),
                        itemCount: tests.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 12.h),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    AnimatedRoute(
                                        page: HistoryTestScreen(
                                            testData: tests[index])));
                              },
                              child: Container(
                                  width: 1.sw,
                                  height: 120.h,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1.5, color: Color(0xff1398b6)),
                                      color: const Color(0xffADD8E6),
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          "${S.of(context).test_Name} ${tests[index]["testName"]}",
                                          style: GoogleFonts.nunito(
                                              color: Color(0xff232425),
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Text(
                                          "${S.of(context).Date_Test}: ${tests[index]["Date"] ?? "Not Included"}",
                                          style: GoogleFonts.nunito(
                                              color: Color(0xff232425),
                                              fontWeight: FontWeight.w600),
                                        )
                                      ],
                                    ),
                                  )),
                            ),
                          );
                        }),
              );
            } else {
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
          },
        ));
  }
}
