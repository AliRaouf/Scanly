import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scanly/bloc/test/test_cubit.dart';
import 'package:scanly/bloc/user/user_cubit.dart';
import 'package:scanly/components/bottom_appbar.dart';
import 'package:scanly/components/custom_form_text_field.dart';
import 'package:scanly/components/gradient_button.dart';
import 'package:scanly/components/scan_bottomsheet_popup.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

import '../components/common_test_selection.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

var searchController = TextEditingController();
final Completer<PDFViewController> controller = Completer<PDFViewController>();
int? pages = 0;
bool isReady = false;
late MemoryImage? _selectedImage;

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    TestCubit.get(context).filteredTests = TestCubit.get(context).tests;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    var cubit = UserCubit.get(context);
    TestCubit.get(context).updateFilteredTests(searchController.text);
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {
      },
      builder: (context, state) {
        return Scaffold(
          body: Container(
            color: Color(0xff80c6dc),
            child: SafeArea(
              child: Container(
                width: screenWidth,
                height: screenHeight,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/Scanly_bg.png"),
                        fit: BoxFit.cover)),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.05092592592),
                        child: Stack(
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: screenWidth * 0.06111111111,
                                  backgroundColor: Colors.transparent,
                                  child: ClipOval(
                                    child: CachedNetworkImage(
                                      errorWidget: (context, url, error) =>
                                          const Image(
                                              image: NetworkImage(
                                                  'https://static.vecteezy.com/system/resources/previews/009/292/244/original/default-avatar-icon-of-social-media-user-vector.jpg')),
                                      imageUrl: cubit.imageUrl,
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      height: double.infinity,
                                      progressIndicatorBuilder: (context, url,
                                              downloadProgress) =>
                                          CircularProgressIndicator(
                                              value: downloadProgress.progress),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Center(
                              child: Padding(
                                padding:
                                    EdgeInsets.all(screenWidth * 0.01944444444),
                                child: Text(
                                  "Welcome ${cubit.userName ?? ""}",
                                  style: GoogleFonts.openSans(
                                      fontSize: screenWidth * 0.044442,
                                      color: Color(0xff232425),
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin:
                            EdgeInsets.symmetric(vertical: screenHeight * 0.01),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        width: screenWidth * 0.6667,
                        child: CustomTextFormField(
                            controller: searchController,
                            icon: IconButton(
                                color: Color(0xff179BE8),
                                onPressed: () {},
                                icon: Icon(Icons.search_rounded)),
                            readOnly: false,
                            hint: "Search for a test",
                            obscureText: false),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                left: screenWidth * 0.04583333333),
                            child: Text(
                              "Common Tests",
                              style: GoogleFonts.openSans(
                                  fontSize: screenWidth * 0.044442,
                                  color: Color(0xff232425),
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          CommonTestSelection(screenHeight: screenHeight, screenWidth: screenWidth),
                          SizedBox(
                            height: screenHeight * 0.02,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 18.0),
                            child: Text(
                              "Tests",
                              style: GoogleFonts.openSans(
                                  fontSize: screenWidth * 0.044442,
                                  color: Color(0xff232425),
                                  fontWeight: FontWeight.w600),
                            ),
                          )
                        ],
                      ),
                      Container(
                        height: screenHeight * 0.45,
                        child: ListView.builder(
                            key: ValueKey<String>(
                                TestCubit.get(context).filteredTests.join(',')),
                            itemCount:
                                TestCubit.get(context).filteredTests.length,
                            padding: EdgeInsets.symmetric(
                                vertical: 4, horizontal: 16),
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 8),
                                  decoration: BoxDecoration(
                                      color: Color(0xfffafafa),
                                      borderRadius: BorderRadius.circular(10)),
                                  height: screenHeight * 0.05,
                                  width: screenWidth * 0.9,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          TestCubit.get(context)
                                              .filteredTests[index],
                                          style: GoogleFonts.openSans(
                                              fontSize: screenWidth * 0.04,
                                              color: Color(0xff232425),
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      BlocBuilder<UserCubit, UserState>(
                                        builder: (context, state) {
                                          return GradientButton(
                                            screenWidth: screenWidth * 0.2,
                                            screenHeight: screenHeight * 0.0375,
                                            text: "Scan",
                                            onpressed: () {
                                              cubit.pickedFile = null;
                                              showModalBottomSheet(
                                                  context: context,
                                                  builder: (context) {
                                                    return ScanBottomSheetPopup(testName: TestCubit.get(
                                                        context)
                                                        .filteredTests[index]);
                                                  });
                                            },
                                            fontSize: screenWidth * 0.033,
                                            border: 6,
                                          );
                                        },
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ),
                      Padding(
                        padding: EdgeInsets.all(screenWidth * 0.01944444444),
                        child: AppBottomAppBar(
                            color: Color(0xffD9D9D9).withOpacity(0.6)),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

