import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scanly/bloc/user/user_cubit.dart';
import 'package:scanly/components/qrscan.dart';
import 'package:scanly/screens/upload_file_confirm.dart';


class ScanBottomSheetPopup extends StatefulWidget {
  ScanBottomSheetPopup({
    super.key,required this.testName
  });
String testName;
  @override
  State<ScanBottomSheetPopup> createState() => _ScanBottomSheetPopupState();
}

class _ScanBottomSheetPopupState extends State<ScanBottomSheetPopup> {
  late MemoryImage? _selectedImage;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    var cubit = UserCubit.get(context);
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setModalState) {
      return SizedBox(
        height: screenHeight * 0.5,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              SizedBox(
                height: screenHeight * 0.05,
                child: Text(
                  widget.testName,
                  style: GoogleFonts.openSans(
                      fontSize: screenWidth * 0.06,
                      color: Color(0xff232425),
                      fontWeight: FontWeight.w600),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  await cubit.pickFile();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              UploadFileConfirm(testName: widget.testName)));
                },
                child: Container(
                  width: screenWidth * 0.86,
                  height: screenHeight * 0.2,
                  decoration: BoxDecoration(
                      border: Border.all(color: Color(0xff179BE8)),
                      borderRadius: BorderRadius.circular(28),
                      color: Color(0xfffafafa)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.file_upload_outlined,
                        size: screenWidth * 0.11666666666,
                        color: Color(0xff179BE8),
                      ),
                      Padding(
                        padding: EdgeInsets.all(screenWidth * 0.01944444444),
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
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () async {
                      await cubit.selectImage().then((image) {
                        setState(() {
                          _selectedImage = image;
                        });
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UploadFileConfirm(
                                    testName: widget.testName)));
                      });
                    },
                    child: Container(
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
                            Icons.camera_alt_outlined,
                            size: screenWidth * 0.11666666666,
                            color: Color(0xff179BE8),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: screenWidth * 0.01944444444),
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
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => QRScan()));
                    },
                    child: Container(
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
                            size: screenWidth * 0.11666666666,
                            color: Color(0xff179BE8),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.all(screenWidth * 0.01944444444),
                            child: Center(
                              child: Text(
                                "Scan QR Code",
                                style: GoogleFonts.openSans(
                                  fontSize: screenWidth * 0.035,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xff232425),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      );
    });
    ;
  }
}
