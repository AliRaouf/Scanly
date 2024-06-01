import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:scanly/bloc/test/test_cubit.dart';
import 'package:scanly/bloc/user/user_cubit.dart';
import 'package:scanly/components/custom_button.dart';
import 'package:scanly/components/gradient_button.dart';
import 'package:scanly/screens/home_screen.dart';
import 'package:scanly/screens/test_screen.dart';
import 'package:screenshot/screenshot.dart';

import '../bloc/api/api_cubit.dart';
import '../bloc/textract/textract_cubit.dart';
import '../components/custom_page_route.dart';
import '../generated/l10n.dart';

class UploadFileConfirm extends StatefulWidget {
  UploadFileConfirm(
      {super.key, required this.testName, required this.testName_ar});

  ScreenshotController screenshotController = ScreenshotController();
  String testName;
  String testName_ar;

  @override
  State<UploadFileConfirm> createState() => _UploadFileConfirmState();
}

class _UploadFileConfirmState extends State<UploadFileConfirm> {
  int? pages = 0;
  bool isReady = false;
  String? extractedText;

  @override
  void initState() {
    TextractCubit.get(context).createTempFileFromMemoryImage(
        MemoryImage(TextractCubit.get(context).image ?? Uint8List(0)));
    super.initState();
  }

  String? text;
  var isClicked = false;
  late Timer _timer;

  _startTimer() {
    _timer = Timer(Duration(seconds: 5), () => isClicked = false);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    var cubit = UserCubit.get(context);
    return BlocConsumer<TextractCubit, TextractState>(
      listener: (context, state) async {},
      builder: (context, state) {
        return Scaffold(
          body: Container(
            width: screenWidth,
            height: screenHeight,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/Scanly_bg.png"),
                    fit: BoxFit.cover)),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: screenHeight * 0.05),
                  child: Text(
                    Intl.getCurrentLocale() == 'en'
                        ? widget.testName
                        : widget.testName_ar,
                    style: GoogleFonts.nunito(
                        fontSize: screenWidth * 0.06,
                        color: Color(0xff232425),
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Container(
                    height: screenHeight * 0.6,
                    width: screenWidth * 0.9,
                    child: TextractCubit.get(context).extension == 'pdf'
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Screenshot(
                              controller: widget.screenshotController,
                              child: PDFView(
                                  filePath: TextractCubit.get(context).pickedFile?.path ?? "",
                                  enableSwipe: true,
                                  swipeHorizontal: true,
                                  autoSpacing: false,
                                  pageFling: false,
                                  onRender: (_pages) {
                                    setState(() {
                                      pages = _pages;
                                      isReady = true;
                                    });
                                  }),
                            ),
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image(
                              image: MemoryImage(TextractCubit.get(context).image ?? Uint8List(0)),
                              fit: BoxFit.fill,
                            ),
                          )),
                Padding(
                  padding: EdgeInsets.all(screenWidth * 0.05590277777),
                  child: Center(
                      child: Text(
                    S.of(context).upload_message,
                    style: GoogleFonts.nunito(
                        fontSize: screenWidth * 0.045,
                        color: Color(0xff4b4b4b)),
                    textAlign: TextAlign.center,
                  )),
                ),
                Padding(
                  padding: EdgeInsets.all(screenWidth * 0.05590277777),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomButton(
                          screenWidth: screenWidth * 0.35,
                          screenHeight: screenHeight * 0.0625,
                          text: S.of(context).back,
                          onpressed: () {
                            TextractCubit.get(context).extension = null;
                            TextractCubit.get(context).pickedFile ??= null;
                            TextractCubit.get(context).image ??= null;
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomeScreen()));
                          },
                          bColor: Color(0xffFAFAFA),
                          borderColor: Color(0xff179BE8),
                          textStyle: GoogleFonts.nunito(
                              fontWeight: FontWeight.bold,
                              fontSize: screenWidth * 0.04444,
                              color: Color(0xff179BE8))),
                      GradientButton(
                          screenWidth: screenWidth * 0.35,
                          screenHeight: screenHeight * 0.0625,
                          text: S.of(context).continue_message,
                          onpressed: () async {
                            if (TextractCubit.get(context).extension == 'pdf') {
                              TextractCubit.get(context).image = await TestCubit.get(context)
                                  .captureImage(widget.screenshotController);
                              await TextractCubit.get(context)
                                  .createTempFileFromMemoryImage(
                                      MemoryImage(TextractCubit.get(context).image!));
                              Future<Map<String, dynamic>> jsonDataFuture =
                                  TextractCubit.get(context)
                                      .createTempFileFromMemoryImage(
                                          MemoryImage(TextractCubit.get(context).image!))
                                      .then((_) => TextractCubit.get(context)
                                          .uploadImage(
                                              TextractCubit.get(context)
                                                  .fileImage!))
                                      .then((_) =>
                                          Future.delayed(Duration(seconds: 15)))
                                      .then((_) =>
                                          TextractCubit.get(context).downloadAndGetText())
                                      .then((text) => TextractCubit.get(context).validateTest(testName: widget.testName, test: text) ? ApiCubit.get(context).getJSONFromPrompt(text, widget.testName, context, widget.testName_ar) : Future(() => {}));
                              Navigator.push(
                                  context,
                                  AnimatedRoute(
                                      page: TestScreen(
                                    jsonDataFuture: jsonDataFuture,
                                    testName: widget.testName,
                                    testName_ar: widget.testName_ar,
                                  )));
                            } else {
                              Future<Map<String, dynamic>> jsonDataFuture =
                                  TextractCubit.get(context)
                                      .createTempFileFromMemoryImage(
                                          MemoryImage(TextractCubit.get(context).image!))
                                      .then((_) => TextractCubit.get(context)
                                          .uploadImage(
                                              TextractCubit.get(context)
                                                  .fileImage!))
                                      .then((_) =>
                                          Future.delayed(Duration(seconds: 15)))
                                      .then((_) =>
                                          TextractCubit.get(context).downloadAndGetText())
                                      .then((text) => TextractCubit.get(context).validateTest(testName: widget.testName, test: text) ? ApiCubit.get(context).getJSONFromPrompt(text, widget.testName, context, widget.testName_ar) : Future(() => {}));
                              Navigator.push(
                                  context,
                                  AnimatedRoute(
                                      page: TestScreen(
                                          jsonDataFuture: jsonDataFuture,
                                          testName: widget.testName,
                                          testName_ar: widget.testName_ar)));
                            }
                          },
                          fontSize: screenWidth * 0.04444,
                          border: 30),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
