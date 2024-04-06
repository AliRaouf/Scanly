import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scanly/bloc/api/api_cubit.dart';

class TestScreen extends StatelessWidget {
  Map<String, dynamic> jsonTest;

  TestScreen({super.key, required this.jsonTest});

  @override
  Widget build(BuildContext context) {
    var cubit = ApiCubit.get(context);
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/Scanly_bg.png"),fit: BoxFit.cover)),
      child: Column(
        children: [
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
                      children: [
                        Column(children: [
                          Text(
                            "$key: ",
                            style: GoogleFonts.nunito(
                                fontSize: 12.sp, fontWeight: FontWeight.w700),
                          ),
                        ]),
                        ...value.entries.map((nestedEntry) {
                          return Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    nestedEntry.value.toString(),
                                    style: GoogleFonts.nunito(fontSize: 12.sp),
                                  ),
                                )
                              ],
                            ),
                          );
                          //   ListTile(
                          //   title: Text(
                          //     nestedEntry.key,
                          //     style: TextStyle(fontSize: 18),
                          //   ),
                          //   subtitle: Text(
                          //     nestedEntry.value.toString(),
                          //     style: TextStyle(fontSize: 18),
                          //   ),
                          // );
                        }).toList(),
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
