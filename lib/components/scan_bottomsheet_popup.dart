import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scanly/components/gradient_button.dart';

class ScanBottomSheetPopup extends StatelessWidget {
  ScanBottomSheetPopup({super.key,required this.testName});
String testName;
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return GradientButton(
        screenWidth: screenWidth * 0.2,
        screenHeight: screenHeight * 0.0375,
        text: "Scan",
        onpressed: () {
          showModalBottomSheet<void>(
            backgroundColor: Color(0xffFAFAFA),
            context: context,
            builder: (BuildContext context) {
              return SizedBox(
                height: screenHeight * 0.5,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(
                        testName,
                        style: GoogleFonts.openSans(
                            fontSize: screenWidth * 0.06,
                            color: Color(0xff232425),
                            fontWeight: FontWeight.w600),
                      ),
                      Container(
                        width: screenWidth * 0.86,
                        height: screenHeight * 0.2,
                        decoration: BoxDecoration(
                            border: Border.all(color: Color(0xff179BE8)),
                            borderRadius: BorderRadius.circular(20),
                            color: Color(0xfffafafa)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.file_upload_outlined,
                              size: screenWidth*0.11666666666,
                              color: Color(0xff179BE8),
                            ),
                            Padding(
                              padding: EdgeInsets.all(screenWidth*0.01944444444),
                              child: Text(
                                "Upload your test",
                                style: GoogleFonts.openSans(
                                    fontSize: screenWidth * 0.04,
                                    color: Color(0xff232425),
                                    fontWeight: FontWeight.w600),
                              ),
                            )
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: screenWidth * 0.4,
                            height: screenHeight * 0.15,
                            decoration: BoxDecoration(
                                border: Border.all(color: Color(0xff179BE8)),
                                borderRadius: BorderRadius.circular(20),
                                color: Color(0xfffafafa)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.camera_alt_outlined,
                                  size: screenWidth*0.11666666666,
                                  color: Color(0xff179BE8),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: screenWidth*0.01944444444),
                                  child: Text(
                                    "Use your Camera",
                                    style: GoogleFonts.openSans(
                                        fontSize: screenWidth * 0.035,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xff232425)),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            width: screenWidth * 0.4,
                            height: screenHeight * 0.15,
                            decoration: BoxDecoration(
                                border: Border.all(color: Color(0xff179BE8)),
                                borderRadius: BorderRadius.circular(20),
                                color: Color(0xfffafafa)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.qr_code_scanner_outlined,
                                  size: screenWidth*0.11666666666
                                  ,
                                  color: Color(0xff179BE8),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(screenWidth*0.01944444444),
                                  child: Center(
                                    child: Text(
                                      "Scan QR Code",
                                      style: GoogleFonts.openSans(
                                          fontSize: screenWidth * 0.035,
                                        fontWeight: FontWeight.w600,
                                          color: Color(0xff232425),),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        fontSize: screenWidth * 0.033);
  }
}
