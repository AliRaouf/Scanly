import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:scanly/bloc/test/test_cubit.dart';
import 'package:scanly/components/scan_bottomsheet_popup.dart';
import 'package:scanly/screens/home_screen.dart';

import '../bloc/user/user_cubit.dart';
import '../components/custom_page_route.dart';
import '../components/gradient_button.dart';
import '../generated/l10n.dart';

class UrineScreen extends StatefulWidget {
  const UrineScreen({super.key});

  @override
  State<UrineScreen> createState() => _UrineScreenState();
}

class _UrineScreenState extends State<UrineScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    var cubit = TestCubit.get(context);
    var uCubit = UserCubit.get(context);
    return BlocConsumer<TestCubit, TestState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return PopScope(
          onPopInvoked: (didPop) =>
              Navigator.push(context, AnimatedRoute(page: HomeScreen())),
          child: Container(
            color: Color(0xff7fc6da),
            child: SafeArea(
              child: Scaffold(
                  body: Container(
                width: screenWidth,
                height: screenHeight,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/Scanly_bg.png"),
                        fit: BoxFit.cover)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Row(
                          children: [
                            IconButton(
                                color: const Color(0xff232425),
                                onPressed: () {
                                  pushScreen(
                                    context,
                                    screen: HomeScreen(),
                                    withNavBar: false,
                                  );
                                },
                                icon: const Icon(
                                    Icons.arrow_back_ios_new_outlined)),
                          ],
                        ),
                        Center(
                          child: Text(
                            S.of(context).urine,
                            style: GoogleFonts.montserrat(
                                fontSize: screenWidth * 0.06,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xff232425)),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: screenHeight * 0.78,
                      child: ListView.builder(
                          itemCount: Intl.getCurrentLocale() == 'ar'
                              ? cubit.urineTests_ar.length
                              : cubit.urineTests.length,
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
                                        Intl.getCurrentLocale() == 'ar'
                                            ? cubit.urineTests_ar[index]
                                            : cubit.urineTests[index],
                                        style: GoogleFonts.nunito(
                                            fontSize: 13.sp,
                                            color: Color(0xff232425),
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    BlocBuilder<UserCubit, UserState>(
                                      builder: (context, state) {
                                        return GradientButton(
                                          screenWidth: screenWidth * 0.2,
                                          screenHeight: screenHeight * 0.0375,
                                          text: S.of(context).scan,
                                          onpressed: () {
                                            uCubit.pickedFile = null;
                                            showModalBottomSheet(
                                                context: context,
                                                builder: (context) {
                                                  return ScanBottomSheetPopup(
                                                    testName:
                                                        TestCubit.get(context)
                                                            .urineTests[index],
                                                    testName_ar:TestCubit.get(context)
                                                        .urineTests_ar[index] ,
                                                  );
                                                });
                                          },
                                          fontSize: Intl.getCurrentLocale()=='en'?13.sp:11.sp,
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
              )),
            ),
          ),
        );
      },
    );
  }
}
