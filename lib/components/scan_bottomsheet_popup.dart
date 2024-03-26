import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    var cubit = UserCubit.get(context);
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setModalState) {
      return SizedBox(
        height: 400.h,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              SizedBox(
                height: 40.h,
                child: Text(
                  widget.testName,
                  style: GoogleFonts.nunito(
                      fontSize: 16.sp,
                      color: Color(0xff232425),
                      fontWeight: FontWeight.w600),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  await cubit.pickFile();
                  cubit.fileToDisplay==null? null :
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              UploadFileConfirm(testName: widget.testName)));
                },
                child: Container(
                  width: 310.w,
                  height: 160.h,
                  decoration: BoxDecoration(
                      border: Border.all(color: Color(0xff179BE8)),
                      borderRadius: BorderRadius.circular(28),
                      color: Color(0xfffafafa)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.file_upload_outlined,
                        size: 50.w,
                        color: Color(0xff179BE8),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Text(
                          "Upload your test",
                          style: GoogleFonts.nunito(
                              fontSize: 14.sp,
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
                      width: 144.w,
                      height: 120.h,
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
                            size: 50.w,
                            color: Color(0xff179BE8),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 8.h),
                            child: Text(
                              "Use your Camera",
                              style: GoogleFonts.nunito(
                                  fontSize: 12.sp,
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
                      width: 144.w,
                      height: 120.h,
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
                            size: 50.w,
                            color: Color(0xff179BE8),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.all(8),
                            child: Center(
                              child: Text(
                                "Scan QR Code",
                                style: GoogleFonts.nunito(
                                  fontSize: 12.sp,
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
  }
}
