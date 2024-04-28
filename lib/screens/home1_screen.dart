import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scanly/screens/profile_screen.dart';

import '../bloc/test/test_cubit.dart';
import '../bloc/user/user_cubit.dart';
import '../components/common_test_selection.dart';
import '../components/custom_form_text_field.dart';
import '../components/custom_page_route.dart';
import '../components/gradient_button.dart';
import '../components/scan_bottomsheet_popup.dart';

class Home1Screen extends StatefulWidget {
  Home1Screen({super.key});
  @override
  State<Home1Screen> createState() => _Home1ScreenState();
}

class _Home1ScreenState extends State<Home1Screen> {
  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var cubit = UserCubit.get(context);
    return  Container(
      width: 1.sw,
      height: 1.sh,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/Scanly_bg.png"),
              fit: BoxFit.cover)),
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 32.h),
          child: Column(
            children: [
              Stack(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 12.w),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                AnimatedRoute(
                                    page: ProfileScreen()));
                          },
                          child: CircleAvatar(
                            radius: 24.r,
                            backgroundColor: Colors.transparent,
                            child: ClipOval(
                              child: CachedNetworkImage(
                                errorWidget: (context, url,
                                    error) =>
                                const Image(
                                    image: NetworkImage(
                                        'https://static.vecteezy.com/system/resources/previews/009/292/244/original/default-avatar-icon-of-social-media-user-vector.jpg')),
                                imageUrl: cubit.imageUrl,
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: double.infinity,
                                progressIndicatorBuilder: (context,
                                    url, downloadProgress) =>
                                    CircularProgressIndicator(
                                        value: downloadProgress
                                            .progress),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        "Welcome ${cubit.userName?.split(" ")[0] ?? ""}",
                        style: GoogleFonts.nunito(
                            fontSize: 14.sp,
                            color: Color(0xff232425),
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  )
                ],
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 8.h),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                width: 240.w,
                child: CustomTextFormField(
                    controller: searchController,
                    icon: IconButton(
                        color: Color(0xff179BE8),
                        onPressed: () {
                          setState(() {
                            TestCubit.get(context)
                                .updateFilteredTests(
                                searchController.text);
                          });
                        },
                        icon: Icon(Icons.search_rounded)),
                    readOnly: false,
                    hint: "Search for a test",
                    obscureText: false),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 15.w),
                    child: Text(
                      "Common Tests",
                      style: GoogleFonts.nunito(
                          fontSize: 14.sp,
                          color: Color(0xff232425),
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  CommonTestSelection(
                      screenHeight: 1.sh, screenWidth: 1.sw),
                  SizedBox(
                    height: 16.h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 18.w),
                    child: Text(
                      "Tests",
                      style: GoogleFonts.nunito(
                          fontSize: 14.sp,
                          color: Color(0xff232425),
                          fontWeight: FontWeight.w600),
                    ),
                  )
                ],
              ),
              Container(
                height: 380.h,
                child: ListView.builder(
                    key: ValueKey<String>(TestCubit.get(context)
                        .filteredTests
                        .join(',')),
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
                              borderRadius:
                              BorderRadius.circular(10)),
                          height: 40.h,
                          width: 328.w,
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  TestCubit.get(context)
                                      .filteredTests[index],
                                  style: GoogleFonts.nunito(
                                      fontSize: 12.sp,
                                      color: Color(0xff232425),
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              BlocBuilder<UserCubit, UserState>(
                                builder: (context, state) {
                                  return GradientButton(
                                    screenWidth: 75.w,
                                    screenHeight: 30.h,
                                    text: "Scan",
                                    onpressed: () {
                                      cubit.pickedFile = null;
                                      showModalBottomSheet(
                                          context: context,
                                          builder: (context) {
                                            return ScanBottomSheetPopup(
                                                testName: TestCubit.get(
                                                    context)
                                                    .filteredTests[
                                                index]);
                                          });
                                    },
                                    fontSize: 12.sp,
                                    border: 6.r,
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
    );
  }
}