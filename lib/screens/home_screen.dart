import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:scanly/bloc/test/test_cubit.dart';
import 'package:scanly/bloc/user/user_cubit.dart';

import 'package:scanly/components/custom_form_text_field.dart';
import 'package:scanly/components/gradient_button.dart';
import 'package:scanly/components/scan_bottomsheet_popup.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

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
var _currentIndex = 0;
String heartOutlineIcon='<svg xmlns="http://www.w3.org/2000/svg" width="1em" height="1em" viewBox="0 0 24 24"><g fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5"><path d="M12 7.194c-1.73-3.92-5.76-4.23-7.64-2.56c-1.53 1.33-2.26 4.66-.87 7.69c2.41 5.21 8.51 8 8.51 8s6.1-2.74 8.51-7.95c1.39-3 .66-6.32-.87-7.69c-1.88-1.72-5.91-1.41-7.64 2.51"/><path d="M3.34 11.964H8l3 3l3-6l2 3h4.66"/></g></svg>';
String heartIcon='<svg xmlns="http://www.w3.org/2000/svg" width="1em" height="1em" viewBox="0 0 24 24"><path fill="currentColor" d="M20.13 4.155a5 5 0 0 0-4.39-1.07A6 6 0 0 0 12 5.665a6 6 0 0 0-3.72-2.58a5.09 5.09 0 0 0-4.4 1c-1.58 1.38-2.45 4.44-1.46 7.54c.112.342.246.676.4 1c.04.075.077.152.11.23c2.57 5.24 8.51 8 8.77 8.13a.672.672 0 0 0 .31.07a.702.702 0 0 0 .31-.07c.25-.11 6.25-2.85 8.8-8.15l.08-.17c.158-.34.295-.691.41-1.05c.94-3 .08-6.06-1.48-7.46m-.31 7.93c-.14.314-.3.618-.48.91h-3.31a1 1 0 0 1-.83-.45l-1.05-1.56l-2.23 4.46a1 1 0 0 1-.73.54h-.16a1 1 0 0 1-.71-.3l-2.71-2.7H4.7a10.595 10.595 0 0 1-.5-1a6.336 6.336 0 0 1-.38-1h4.21a.999.999 0 0 1 .71.29l2 2l2.38-4.76a1 1 0 0 1 .84-.55a1 1 0 0 1 .89.44l1.7 2.56h3.7a6.572 6.572 0 0 1-.43 1.12"/></svg>';
String historyIcon='<svg xmlns="http://www.w3.org/2000/svg" width="1em" height="1em" viewBox="0 0 24 24"><path fill="currentColor" fill-rule="evenodd" d="M8.672 7.542h6.656c3.374 0 5.062 0 6.01.987c.947.987.724 2.511.278 5.56l-.422 2.892c-.35 2.391-.525 3.587-1.422 4.303c-.897.716-2.22.716-4.867.716h-5.81c-2.646 0-3.97 0-4.867-.716c-.897-.716-1.072-1.912-1.422-4.303l-.422-2.892c-.447-3.049-.67-4.573.278-5.56c.948-.987 2.636-.987 6.01-.987M8 18c0-.414.373-.75.833-.75h6.334c.46 0 .833.336.833.75s-.373.75-.833.75H8.833c-.46 0-.833-.336-.833-.75" clip-rule="evenodd"/><path fill="currentColor" d="M8.51 2h6.98c.233 0 .41 0 .567.015c1.108.109 2.014.775 2.399 1.672H5.544c.385-.897 1.292-1.563 2.4-1.672C8.099 2 8.278 2 8.51 2" opacity="0.4"/><path fill="currentColor" d="M6.31 4.723c-1.39 0-2.53.84-2.91 1.953a2.623 2.623 0 0 0-.024.07a7.69 7.69 0 0 1 1.232-.253c1.08-.138 2.446-.138 4.032-.138h6.892c1.586 0 2.952 0 4.032.138c.42.054.834.133 1.232.253a2.817 2.817 0 0 0-.023-.07c-.38-1.114-1.52-1.953-2.911-1.953z" opacity="0.7"/></svg>';
String historyIconOutlined='<svg xmlns="http://www.w3.org/2000/svg" width="1em" height="1em" viewBox="0 0 24 24"><g fill="none" stroke="currentColor" stroke-width="1.5"><path d="M19.562 7a2.132 2.132 0 0 0-2.1-2.5H6.538a2.132 2.132 0 0 0-2.1 2.5M17.5 4.5c.028-.26.043-.389.043-.496a2 2 0 0 0-1.787-1.993C15.65 2 15.52 2 15.26 2H8.74c-.26 0-.391 0-.497.011a2 2 0 0 0-1.787 1.993c0 .107.014.237.043.496" opacity="0.5"/><path stroke-linecap="round" d="M15 18H9"/><path d="M2.384 13.793c-.447-3.164-.67-4.745.278-5.77C3.61 7 5.298 7 8.672 7h6.656c3.374 0 5.062 0 6.01 1.024c.947 1.024.724 2.605.278 5.769l-.422 3c-.35 2.48-.525 3.721-1.422 4.464c-.897.743-2.22.743-4.867.743h-5.81c-2.646 0-3.97 0-4.867-.743c-.897-.743-1.072-1.983-1.422-4.464z"/></g></svg>';
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
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          extendBody: true,
          bottomNavigationBar: SalomonBottomBar(
            backgroundColor: Color(0xffd9d9d9).withOpacity(0.25),
            unselectedItemColor: Color(0xff232425),
            selectedItemColor: Color(0xff04657A ),
            curve: Curves.linearToEaseOut,
            currentIndex: _currentIndex,
            onTap: (i) => setState(() => _currentIndex = i),
            items: [
              /// Home
              SalomonBottomBarItem(
                icon: Icon(Icons.home_outlined),
                title: Text("Home"),
                activeIcon: Icon(Icons.home_rounded)
              ),
              SalomonBottomBarItem(activeIcon: Iconify(historyIcon,color:Color(0xff04657A)),
                icon: Iconify(historyIconOutlined,color: Color(0xff232425),),
                title: Text("History"),
              ),
              /// Likes
              SalomonBottomBarItem(
                icon: Iconify(heartOutlineIcon,color: Color(0xff232425),),
                title: Text("Health"),
                activeIcon: Iconify(heartIcon,color:Color(0xff04657A) ,)
              ),

              /// Search

              /// Profile
              SalomonBottomBarItem(activeIcon: Icon(Icons.settings_rounded),
                icon: Icon(Icons.settings_outlined),
                title: Text("Settings"),
              ),
            ],
          ),
          body: IndexedStack(
            index: _currentIndex,
            children: [
              Container(
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
                                      errorWidget: (context, url, error) => const Image(
                                          image: NetworkImage(
                                              'https://static.vecteezy.com/system/resources/previews/009/292/244/original/default-avatar-icon-of-social-media-user-vector.jpg')),
                                      imageUrl: cubit.imageUrl,
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      height: double.infinity,
                                      progressIndicatorBuilder:
                                          (context, url, downloadProgress) =>
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
                        margin: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
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
                            padding:
                            EdgeInsets.only(left: screenWidth * 0.04583333333),
                            child: Text(
                              "Common Tests",
                              style: GoogleFonts.openSans(
                                  fontSize: screenWidth * 0.044442,
                                  color: Color(0xff232425),
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          CommonTestSelection(
                              screenHeight: screenHeight, screenWidth: screenWidth),
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
                            itemCount: TestCubit.get(context).filteredTests.length,
                            padding:
                            EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 4),
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
                                                    return ScanBottomSheetPopup(
                                                        testName: TestCubit.get(
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
                    ],
                  ),
                ),
              ),
          Container(
          color: Colors.red,
          child: Center(
            child: Text("Health Page"),
          ),
        ),
          // Replace with your settings page widget
          Container(
            color: Colors.yellow,
            child: Center(
              child: Text("Settings Page"),
            ),)
            ],
          ),
        );
      },
    );
  }
}
