import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../bloc/language/language_cubit.dart';
import '../bloc/user/user_cubit.dart';
import '../components/custom_page_route.dart';
import '../components/gradient_button.dart';
import '../generated/l10n.dart';
import 'change_password_screen.dart';
import 'change_user_data_screen.dart';
import 'legal_terms_conditions.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({
    super.key,
    required this.cubit,
  });

  final UserCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/Scanly_bg.png"),
              fit: BoxFit.cover)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Center(
          child: Container(
            height: 500.h,
            padding: EdgeInsets.symmetric(
                vertical: 15.h, horizontal: 30.w),
            decoration: BoxDecoration(
                color: Color(0xfffafafa),
                borderRadius: BorderRadius.circular(30)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          S.of(context).account,
                          style: GoogleFonts.nunito(
                              color: Color(0xff232425),
                              fontWeight: FontWeight.w700,
                              fontSize: 20.sp),
                        ),
                      ],
                    ),
                    Container(
                      width: 1.sw,
                      decoration: BoxDecoration(
                          color: Color(0xfffafafa),
                          borderRadius: BorderRadius.all(
                              Radius.circular(15.r))),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          AnimatedRoute(
                                              page:
                                              ChangeUserDataScreen()));
                                    },
                                    child: Padding(
                                      padding:
                                      const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment
                                            .spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Text(
                                             S.of(context).change_userdata,
                                              style: GoogleFonts
                                                  .nunito(
                                                color: Color(
                                                    0xff232425),
                                              ),
                                            ),
                                          ),
                                          Icon(
                                            Icons
                                                .arrow_forward_ios_rounded,
                                            size: 18,
                                            color:
                                            Color(0xff232425),
                                          )
                                        ],
                                      ),
                                    )),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: TextButton(
                                    onPressed: ()async{
                                      return await LanguageCubit.get(context).showLanguageDialog(context);
                                    },
                                    child: Padding(
                                      padding:
                                      const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment
                                            .spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              S.of(context).change_language,
                                              style: GoogleFonts
                                                  .nunito(
                                                color: Color(
                                                    0xff232425),
                                              ),
                                            ),
                                          ),
                                          Icon(
                                            Icons
                                                .arrow_forward_ios_rounded,
                                            size: 18,
                                            color:
                                            Color(0xff232425),
                                          )
                                        ],
                                      ),
                                    )),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          S.of(context).security,
                          style: GoogleFonts.nunito(
                              color: Color(0xff232425),
                              fontWeight: FontWeight.w700,
                              fontSize: 20.sp),
                        ),
                      ],
                    ),
                    Container(
                      width: 1.sw,
                      decoration: BoxDecoration(
                          color: Color(0xfffafafa),
                          borderRadius: BorderRadius.all(
                              Radius.circular(15.r))),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          AnimatedRoute(
                                              page:
                                              ChangePasswordScreen()));
                                    },
                                    child: Padding(
                                      padding:
                                      const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment
                                            .spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              S.of(context).change_password,
                                              style: GoogleFonts
                                                  .nunito(
                                                color: Color(
                                                    0xff232425),
                                              ),
                                            ),
                                          ),
                                          Icon(
                                            Icons
                                                .arrow_forward_ios_rounded,
                                            size: 18,
                                            color:
                                            Color(0xff232425),
                                          )
                                        ],
                                      ),
                                    )),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          S.of(context).legal,
                          style: GoogleFonts.nunito(
                              color: Color(0xff232425),
                              fontWeight: FontWeight.w700,
                              fontSize: 20.sp),
                        ),
                      ],
                    ),
                    Container(
                      width: 1.sw,
                      decoration: BoxDecoration(
                          color: Color(0xfffafafa),
                          borderRadius: BorderRadius.all(
                              Radius.circular(15.r))),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          AnimatedRoute(
                                              page:
                                              LegalTermsConditions()));
                                    },
                                    child: Padding(
                                      padding:
                                      const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment
                                            .spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              S.of(context).view_legal,
                                              style: GoogleFonts
                                                  .nunito(
                                                color: Color(
                                                    0xff232425),
                                              ),
                                            ),
                                          ),
                                          Icon(
                                            Icons
                                                .arrow_forward_ios_rounded,
                                            size: 18,
                                            color:
                                            Color(0xff232425),
                                          )
                                        ],
                                      ),
                                    )),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                GradientButton(
                    screenWidth: 0.4.sw,
                    screenHeight: 45.h,
                    text: S.of(context).logout,
                    onpressed: () {
                      cubit.logout();
                    },
                    fontSize: 20.sp,
                    border: 10.r)
              ],
            ),
          ),
        ),
      ),
    );
  }
}