import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:google_fonts/google_fonts.dart';
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

class UploadFileConfirm extends StatefulWidget {
  UploadFileConfirm({super.key, required this.testName});
  ScreenshotController screenshotController = ScreenshotController();
  String testName;

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
        MemoryImage(UserCubit.get(context).image ?? Uint8List(0)));
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
                    widget.testName,
                    style: GoogleFonts.nunito(
                        fontSize: screenWidth * 0.06,
                        color: Color(0xff232425),
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Container(
                    height: screenHeight * 0.6,
                    width: screenWidth * 0.9,
                    child: cubit.extension == 'pdf'
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Screenshot(
                              controller: widget.screenshotController,
                              child: PDFView(
                                  filePath: cubit.pickedFile?.path ?? "",
                                  enableSwipe: true,
                                  swipeHorizontal: true,
                                  autoSpacing: false,
                                  pageFling: false,
                                  onRender: (_pages) {
                                    setState(() {
                                      pages = _pages;
                                      isReady = true;
                                      print(pages);
                                    });
                                  }),
                            ),
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image(
                              image: MemoryImage(cubit.image ?? Uint8List(0)),
                              fit: BoxFit.cover,
                            ),
                          )),
                Padding(
                  padding: EdgeInsets.all(screenWidth * 0.05590277777),
                  child: Center(
                      child: Text(
                    "Are you sure you want to upload this Test?",
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
                          text: "Back",
                          onpressed: () {
                            cubit.extension = null;
                            cubit.pickedFile ??= null;
                            cubit.image ??= null;
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
                          text: "Continue",
                          onpressed: () async {
                            if (cubit.extension == 'pdf') {
                              cubit.image = await TestCubit.get(context)
                                  .captureImage(widget.screenshotController);
                              await TextractCubit.get(context)
                                  .createTempFileFromMemoryImage(
                                      MemoryImage(cubit.image!));
                              Future<Map<String, dynamic>> jsonDataFuture =
                                  TextractCubit.get(context)
                                      .createTempFileFromMemoryImage(
                                          MemoryImage(cubit.image!))
                                      .then((_) => TextractCubit.get(context)
                                          .uploadImage(
                                              TextractCubit.get(context)
                                                  .fileImage!))
                                      .then((_) =>
                                          Future.delayed(Duration(seconds: 15)))
                                      .then((_) => TextractCubit.get(context)
                                          .downloadAndGetText())
                                      .then((text) =>
                                          ApiCubit.get(context).getJSONFromPrompt(text, context));
                              Navigator.push(
                                  context,
                                  AnimatedRoute(
                                      page: TestScreen(
                                    jsonDataFuture: jsonDataFuture,
                                  )));
                            } else {
                              print("de7k");
                              Future<Map<String, dynamic>> jsonDataFuture =
                                  TextractCubit.get(context)
                                      .createTempFileFromMemoryImage(
                                          MemoryImage(cubit.image!))
                                      .then((_) => TextractCubit.get(context)
                                          .uploadImage(
                                              TextractCubit.get(context)
                                                  .fileImage!))
                                      .then((_) =>
                                          Future.delayed(Duration(seconds: 15)))
                                      .then((_) => TextractCubit.get(context)
                                          .downloadAndGetText())
                                      .then((text) =>
                                          ApiCubit.get(context).getJSONFromPrompt(text, context));
                              Navigator.push(
                                  context,
                                  AnimatedRoute(
                                      page: TestScreen(
                                    jsonDataFuture: jsonDataFuture,
                                  )));
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
