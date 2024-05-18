import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:intl/intl.dart';
import 'package:scanly/screens/profile_screen.dart';

import '../bloc/language/language_cubit.dart';
import '../bloc/user/user_cubit.dart';
import '../components/custom_page_route.dart';
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
    String editUserIcon =
        '<svg xmlns="http://www.w3.org/2000/svg" width="1em" height="1em" viewBox="0 0 24 24"><g fill="none" fill-rule="evenodd"><path d="M24 0v24H0V0zM12.594 23.258l-.012.002l-.071.035l-.02.004l-.014-.004l-.071-.036c-.01-.003-.019 0-.024.006l-.004.01l-.017.428l.005.02l.01.013l.104.074l.015.004l.012-.004l.104-.074l.012-.016l.004-.017l-.017-.427c-.002-.01-.009-.017-.016-.018m.264-.113l-.014.002l-.184.093l-.01.01l-.003.011l.018.43l.005.012l.008.008l.201.092c.012.004.023 0 .029-.008l.004-.014l-.034-.614c-.003-.012-.01-.02-.02-.022m-.715.002a.023.023 0 0 0-.027.006l-.006.014l-.034.614c0 .012.007.02.017.024l.015-.002l.201-.093l.01-.008l.003-.011l.018-.43l-.003-.012l-.01-.01z"/><path fill="currentColor" d="M6 7a5 5 0 1 1 10 0A5 5 0 0 1 6 7m5-3a3 3 0 1 0 0 6a3 3 0 0 0 0-6M4.413 17.601c-.323.41-.413.72-.413.899c0 .118.035.232.205.384c.197.176.55.37 1.11.543c1.12.346 2.756.521 4.706.563a1 1 0 1 1-.042 2c-1.997-.043-3.86-.221-5.254-.652c-.696-.216-1.354-.517-1.852-.962C2.347 19.906 2 19.274 2 18.5c0-.787.358-1.523.844-2.139c.494-.625 1.177-1.2 1.978-1.69C6.425 13.695 8.605 13 11 13c.447 0 .887.024 1.316.07a1 1 0 0 1-.211 1.989C11.745 15.02 11.375 15 11 15c-2.023 0-3.843.59-5.136 1.379c-.647.394-1.135.822-1.45 1.222Zm16.8-3.567a2.5 2.5 0 0 0-3.536 0l-3.418 3.417a1.5 1.5 0 0 0-.424.849l-.33 2.308a1.001 1.001 0 0 0 1.133 1.133l2.308-.33a1.5 1.5 0 0 0 .849-.424l3.417-3.418a2.5 2.5 0 0 0 0-3.535Zm-2.122 1.414a.5.5 0 0 1 .707.707l-3.3 3.3l-.825.118l.118-.825z"/></g></svg>';
    String legalIcon =
        '<svg xmlns="http://www.w3.org/2000/svg" width="1em" height="1em" viewBox="0 0 24 24"><path fill="currentColor" d="M12 3c-1.27 0-2.4.8-2.82 2H3v2h1.95L2 14c-.47 2 1 3 3.5 3s4.06-1 3.5-3L6.05 7h3.12c.33.85.98 1.5 1.83 1.83V20H2v2h20v-2h-9V8.82c.85-.32 1.5-.97 1.82-1.82h3.13L15 14c-.47 2 1 3 3.5 3s4.06-1 3.5-3l-2.95-7H21V5h-6.17C14.4 3.8 13.27 3 12 3m0 2a1 1 0 0 1 1 1a1 1 0 0 1-1 1a1 1 0 0 1-1-1a1 1 0 0 1 1-1m-6.5 5.25L7 14H4zm13 0L20 14h-3z"/></svg>';
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/Scanly_bg.png"),
              fit: BoxFit.cover)),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom:8.0),
                child: Text(
                  S.of(context).account,
                  style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.bold, fontSize: 20.sp),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Color(0xfff1f1f1),
                    borderRadius: BorderRadius.circular(15)),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextButton(
                              onPressed: () {
                                Navigator.push(context,
                                    AnimatedRoute(page: ProfileScreen()));
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.person_outline,
                                      color: Color(0xff232425),
                                    ),
                                    Text(Intl.getCurrentLocale()=='ar'?" عرض بيانات المستخدم":
                                      "  View Profile",
                                      style: GoogleFonts.nunito(
                                          color: Color(0xff232425),
                                          fontSize: 16.sp),
                                    ),
                                  ],
                                ),
                              )),
                        ),
                      ],
                    ),
                    Divider(),
                    Row(
                      children: [
                        Expanded(
                          child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    AnimatedRoute(
                                        page: ChangeUserDataScreen()));
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Iconify(
                                      editUserIcon,
                                      color: Color(0xff232425),
                                    ),
                                    Text(
                                      "  ${S.of(context).change_userdata}",
                                      style: GoogleFonts.nunito(
                                          color: Color(0xff232425),
                                          fontSize: 16.sp),
                                    ),
                                  ],
                                ),
                              )),
                        ),
                      ],
                    ),
                    Divider(),
                    Row(
                      children: [
                        Expanded(
                          child: TextButton(
                              onPressed: () async {
                                return await LanguageCubit.get(context)
                                    .showLanguageDialog(context);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(
                                        shadows: [BoxShadow()],
                                        color: Color(0xff232425),
                                        Icons.language_rounded),
                                    Text(
                                      "  ${S.of(context).change_language}",
                                      style: GoogleFonts.nunito(
                                          color: Color(0xff232425),
                                          fontSize: 16.sp),
                                    ),
                                  ],
                                ),
                              )),
                        ),
                      ],
                    ),
                    Divider(),
                    Row(
                      children: [
                        Expanded(
                          child: TextButton(
                              onPressed: () {
                                cubit.logout();
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.logout,
                                      color: Color(0xff232425),
                                    ),
                                    Text(
                                      "  ${S.of(context).logout}",
                                      style: GoogleFonts.nunito(
                                          color: Color(0xff232425),
                                          fontSize: 16.sp),
                                    ),
                                  ],
                                ),
                              )),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical:8.0),
                child: Text(
                  S.of(context).security,
                  style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.bold, fontSize: 20.sp),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Color(0xfff1f1f1),
                    borderRadius: BorderRadius.circular(15)),
                child: Row(
                  children: [
                    Expanded(
                      child: TextButton(
                          onPressed: () {
                            Navigator.push(context,
                                AnimatedRoute(page: ChangePasswordScreen()));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.lock_outline,
                                  color: Color(0xff232425),
                                ),
                                Text(
                                  "  ${S.of(context).change_password}",
                                  style: GoogleFonts.nunito(
                                      color: Color(0xff232425),
                                      fontSize: 16.sp),
                                ),
                              ],
                            ),
                          )),
                    ),
                  ],
                ),
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(vertical:8.0),
                child: Text(
                  S.of(context).legal,
                  style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.bold, fontSize: 20.sp),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Color(0xfff1f1f1),
                    borderRadius: BorderRadius.circular(15)),
                child: Row(
                  children: [
                    Expanded(
                      child: TextButton(
                          onPressed: () {
                            Navigator.push(context,
                                AnimatedRoute(page: LegalTermsConditions()));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Iconify(
                                  legalIcon,
                                  color: Color(0xff232425),
                                ),
                                Text(
                                  "  ${S.of(context).view_legal}",
                                  style: GoogleFonts.nunito(
                                      color: Color(0xff232425),
                                      fontSize: 16.sp),
                                ),
                              ],
                            ),
                          )),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
