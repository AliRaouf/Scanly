import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mlkit_document_scanner/google_mlkit_document_scanner.dart';
import 'package:intl/intl.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:scanly/bloc/user/user_cubit.dart';
import 'package:scanly/components/qrscan.dart';
import 'package:scanly/screens/upload_file_confirm.dart';

import '../bloc/textract/textract_cubit.dart';
import '../generated/l10n.dart';


class ScanBottomSheetPopup extends StatefulWidget {
  ScanBottomSheetPopup({
    super.key,required this.testName,required this.testName_ar
  });
String testName;
String testName_ar;
  @override
  State<ScanBottomSheetPopup> createState() => _ScanBottomSheetPopupState();
}
class _ScanBottomSheetPopupState extends State<ScanBottomSheetPopup> {
  late DocumentScanner documentScanner;
  DocumentScannerOptions options = DocumentScannerOptions(
    documentFormat: DocumentFormat.jpeg,
    mode: ScannerMode.full,
    isGalleryImport: true,
    pageLimit: 1,
  );
  late MemoryImage? _selectedImage;
  @override
  void initState() {
    documentScanner = DocumentScanner(options: options);
    super.initState();
  }
  @override
  void dispose() {
    documentScanner.close();
    super.dispose();
  }
  Widget build(BuildContext context) {
    var cubit = UserCubit.get(context);
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setModalState) {
      return SizedBox(
        height: 400.h,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 40.h,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    Intl.getCurrentLocale()=='ar'?widget.testName_ar:widget.testName,
                    style: GoogleFonts.nunito(
                        fontSize: 16.sp,
                        color: Color(0xff232425),
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  try {
                    var documents = await documentScanner.scanDocument();
                    print('documents: ${documents.images[0]}');
                    TextractCubit.get(context).image= await FlutterImageCompress.compressWithFile(documents.images[0],quality: 90,);
                    pushScreen(
                      context,
                      screen: UploadFileConfirm(testName: widget.testName,testName_ar: widget.testName_ar,),
                      withNavBar: false,
                    );
                  } catch (e) {
                    print('Error: $e');
                  }
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
                      Icon(Icons.document_scanner_outlined
                        ,
                        size: 50.w,
                        color: Color(0xff179BE8),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Text(
                          S.of(context).Upload_test,
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
              Padding(
                padding: EdgeInsets.symmetric(vertical: 12.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        await TextractCubit.get(context).pickFile();
                        TextractCubit.get(context).fileToDisplay==null? null :
                        pushScreen(
                          context,
                          screen: UploadFileConfirm(testName: widget.testName,testName_ar: widget.testName_ar,),
                          withNavBar: false,
                        );
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
                            Icon(Icons.file_upload_outlined
                              ,
                              size: 50.w,
                              color: Color(0xff179BE8),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 8.h),
                              child: Text(
                               Intl.getCurrentLocale()=='en'?"Upload a PDF":"قم تحميل ملف PDF",
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
                        pushScreen(
                          context,
                          screen: QRScan(),
                          withNavBar: false,
                        );
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
                                  S.of(context).Scan_QR,
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
              ),
            ],
          ),
        ),
      );
    });
  }
}
