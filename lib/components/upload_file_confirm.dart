import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scanly/bloc/user/user_cubit.dart';
import 'package:scanly/components/custom_button.dart';
import 'package:scanly/components/gradient_button.dart';
import 'package:scanly/screens/home_screen.dart';

class UploadFileConfirm extends StatefulWidget {
  UploadFileConfirm({super.key, required this.testName});

  String testName;

  @override
  State<UploadFileConfirm> createState() => _UploadFileConfirmState();
}

class _UploadFileConfirmState extends State<UploadFileConfirm> {
  int? pages = 0;
  bool isReady = false;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    var cubit = UserCubit.get(context);
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
                style: GoogleFonts.openSans(
                    fontSize: screenWidth * 0.06,
                    color: Color(0xff232425),
                    fontWeight: FontWeight.w600),
              ),
            ),
            Container(
                height: screenHeight * 0.6,
                width: screenWidth * 0.9,
                child: cubit.extension != null
                    ? cubit.extension == 'pdf'
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(15),
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
                                  });
                                }),
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.file(
                              cubit.fileToDisplay!,
                              fit: BoxFit.fill,
                            ),
                          )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image(image: MemoryImage(cubit.image!),fit: BoxFit.cover,),
                      )),
            Padding(
              padding: EdgeInsets.all(screenWidth*0.05590277777),
              child: Center(
                  child: Text(
                    "Are you sure you want to upload this Test?",
                    style: GoogleFonts.openSans(
                        fontSize: screenWidth * 0.045,
                        color: Color(0xff4b4b4b)),
                    textAlign: TextAlign.center,
                  )),
            )
            ,
            Padding(
              padding: EdgeInsets.all(screenWidth*0.05590277777),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomButton(
                      screenWidth: screenWidth * 0.35,
                      screenHeight: screenHeight * 0.0625,
                      text: "Back",
                      onpressed: () {
                        cubit.extension =null;
                        cubit.pickedFile ??= null;
                        cubit.image ??= null;
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreen()));
                      },
                      bColor: Color(0xffFAFAFA),
                      borderColor: Color(0xff179BE8),
                      textStyle: GoogleFonts.openSans(
                          fontWeight: FontWeight.bold,
                          fontSize: screenWidth * 0.04444,
                          color: Color(0xff179BE8))),
                  GradientButton(
                      screenWidth: screenWidth * 0.35,
                      screenHeight: screenHeight * 0.0625,
                      text: "Continue",
                      onpressed: (){},
                      fontSize: screenWidth * 0.04444,
                      border: 30),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
