import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../generated/l10n.dart';

class HistoryTestScreen extends StatefulWidget {
  HistoryTestScreen({super.key, required this.testData});
  Map<String, dynamic> testData;

  @override
  State<HistoryTestScreen> createState() => _HistoryTestScreenState();
}

class _HistoryTestScreenState extends State<HistoryTestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 1.sw,
        height: 1.sh,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/Scanly_bg.png"),
                fit: BoxFit.cover)),
        child: Column(
          children: [
            SafeArea(
                child:Container(height: 400.h,
                  child:
                      widget.testData["image"].toString().contains(".Document")?
                          SizedBox.shrink()
                          :
                  Image(
                          image: NetworkImage(widget.testData["image"]),
                          fit: BoxFit.cover,
                        ),
                ),
                    ),
            SizedBox(height: 10.h,),
            Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color:Color(0xfffafafa).withOpacity(0.3)),

              width: 1.sw,height: 200.h,
              child: ListView.builder(shrinkWrap: true,physics: ClampingScrollPhysics(),
                itemCount:widget.testData["diagnosis"].trim().split('. ').length,
                itemBuilder: (context, index) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 8.0, left: 8),
                        child: Text("•",
                            style: GoogleFonts.nunito(
                                fontSize: 12.sp, color: Color(0xff232425))),
                      ),
                      Expanded(
                        child: Text("${widget.testData["diagnosis"].trim().split('. ')[index]}.",style: GoogleFonts.nunito(
                            fontSize: 12.sp, color: Color(0xff232425))),
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
                      "${widget.testData["Recommendation"]}",
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
    );
  }
}
