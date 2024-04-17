import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scanly/bloc/api/api_cubit.dart';

class TestScreen extends StatelessWidget {
  Map<String, dynamic> jsonTest;

  TestScreen({super.key, required this.jsonTest});

  @override
  Widget build(BuildContext context) {
    double value;
    List range;
    var cubit = ApiCubit.get(context);
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/Scanly_bg.png"),
              fit: BoxFit.cover)),
      child: Column(
        children: [
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(
                  Icons.verified_rounded,
                  color: Colors.green,
                  size: 32.sp,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text(
                    "HealthCheck : Good \nComment : ${jsonTest["Comment"]} \n${jsonTest["Recommendation"]}",
                    style: GoogleFonts.nunito(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff232425)),
                  ),
                ),
              ],
            ),
            width: 1.sw,
            height: 200.h,
            decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(15)),
                color: Colors.white54),
          ),
          Expanded(
            child: Container(
              width: 1.sw,
              child: ListView.builder(
                  padding: EdgeInsets.all(12),
                  itemCount: cubit.getNestedKeyValuePairs(jsonTest).length,
                  itemBuilder: (context, index) {
                    MapEntry<String, Map<String, dynamic>> entry =
                        cubit.getNestedKeyValuePairs(jsonTest)[index];
                    String key = entry.key;
                    Map<String, dynamic> value = entry.value;
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(children: [
                          Text(
                            "$key: ",
                            style: GoogleFonts.nunito(
                                fontSize: 12.sp, fontWeight: FontWeight.w700),
                          ),
                        ]),
                        Text("${value["value"]} ${value["range"]}")
                      ],
                    );
                  }),
            ),
          ),
        ],
      ),
    ));
  }
}
