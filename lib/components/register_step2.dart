import 'package:flutter/material.dart';
import 'package:flutter_pw_validator/Resource/Strings.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:scanly/components/custom_form_text_field.dart';

import '../bloc/register/register_cubit.dart';
import '../generated/l10n.dart';

class CustomPwValidatorStringsAR extends FlutterPwValidatorStrings {
  @override
  final String atLeast = "- أحرف على الأقل";

  @override
  final String normalLetters = "- أحرف";

  @override
  final String uppercaseLetters = "- الأحرف الكبيرة";

  @override
  final String lowercaseLetters = "- أحرف صغيرة";

  @override
  final String numericCharacters = "- أرقام";

  @override
  final String specialCharacters = "- Special character";
}
class CustomPwValidatorStrings extends FlutterPwValidatorStrings {
  @override
  final String atLeast = "At least - character";

  @override
  final String normalLetters = "- Letter";

  @override
  final String uppercaseLetters = "- Uppercase letter";

  @override
  final String lowercaseLetters = "- Lowercase letter";

  @override
  final String numericCharacters = "- Numeric character";

  @override
  final String specialCharacters = "- Special character";
}
class RegisterStep2 extends StatefulWidget {
  RegisterStep2(
      {super.key,
      required this.formKey2,
      required this.dateController,
      required this.passwordController,
      required this.confirmPasswordController,
      this.onTap, required this.pwKey});

  final GlobalKey<FormState> formKey2;
  final GlobalKey<FormState> pwKey;
  final TextEditingController dateController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  void Function()? onTap;

  @override
  State<RegisterStep2> createState() => _RegisterStep2State();
}

class _RegisterStep2State extends State<RegisterStep2> {
  @override
  void initState() {
    RegisterCubit.get(context).pwValidate=false;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 320.h,
      child: Form(
        key: widget.formKey2,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 8.w,top: 20.h),
                        child: Text(
                          S.of(context).birth,
                          style: GoogleFonts.nunito(
                              fontSize: 12.sp, color: Color(0xff232425)),
                        ),
                      ),
                    ],
                  ),
                  CustomTextFormField(
                      controller: widget.dateController,
                      readOnly: true,
                      hint: "DD/M/YYYY",
                      obscureText: false,
                      onTap: widget.onTap),
                ],
              ),
              Container(
                height: 120.h,
                child: ListView(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 8.w),
                          child: Text(
                            S.of(context).password,
                            style: GoogleFonts.nunito(
                                fontSize: 12.sp, color: Color(0xff232425)),
                          ),
                        ),
                      ],
                    ),
                    CustomTextFormField(
                        controller: widget.passwordController,
                        readOnly: false,
                        hint: "********",
                        obscureText: true),
                    FlutterPwValidator(strings:Intl.getCurrentLocale()=="ar"?CustomPwValidatorStringsAR():CustomPwValidatorStrings(),
                      controller: widget.passwordController,
                      minLength: 8,
                      uppercaseCharCount: 1,
                      numericCharCount: 1,
                      width: 1.sw,
                      height: 115.h,
                      onSuccess: () {
                        print("Success");
                        RegisterCubit.get(context).pwValidate=true;
                        print(RegisterCubit.get(context).pwValidate);
                      },
                    )
                  ],
                ),
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 8.w),
                        child: Text(
                          S.of(context).confirm_password,
                          style: GoogleFonts.nunito(
                              fontSize: 12.sp, color: Color(0xff232425)),
                        ),
                      ),
                    ],
                  ),
                  CustomTextFormField(
                      validate: (data) {
                        if (widget.confirmPasswordController.text !=
                            widget.passwordController.text) {
                          return S.of(context).password_not_match;
                        }
                      },
                      controller: widget.confirmPasswordController,
                      readOnly: false,
                      hint: "********",
                      obscureText: true),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
