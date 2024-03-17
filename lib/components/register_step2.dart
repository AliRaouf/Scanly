import 'package:flutter/material.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scanly/components/custom_form_text_field.dart';

class RegisterStep2 extends StatelessWidget {
  RegisterStep2({
    super.key,
    required this.formKey2,
    required this.dateController,
    required this.passwordController,
    required this.confirmPasswordController,
    this.onTap
  });

  final GlobalKey<FormState> formKey2;
  final TextEditingController dateController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 320.h,
      child: Form(
        key: formKey2,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: 8.w),
                        child: Text("Date Of Birth",
                          style: GoogleFonts.openSans(fontSize: 12.sp, color: Color(0xff232425)),),
                      ),
                    ],
                  ),
                  CustomTextFormField(
                      controller: dateController,
                      readOnly: false,
                      hint: "DD/M/YYYY",
                      obscureText: false,
                      onTap: onTap),
                ],
              ),
              Container(height: 100.h,margin: EdgeInsets.only(top: 8.h),
                child: ListView(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 8.w),
                          child: Text("Password", style: GoogleFonts.openSans(
                              fontSize: 12.sp,
                              color: Color(0xff232425)),),
                        ),
                      ],
                    ),
                    CustomTextFormField(
                        controller: passwordController,
                        readOnly: false,
                        hint: "********",
                        obscureText: true),
                    FlutterPwValidator(
                      controller: passwordController,
                      minLength: 8,
                      uppercaseCharCount: 1,
                      numericCharCount: 1,
                      width: 1.sw,
                      height: 110.h,
                      onSuccess: () {
                        print("Success");
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
                        padding: EdgeInsets.only(
                            left: 8.w),
                        child: Text("Confirm Password",
                          style: GoogleFonts.openSans(fontSize: 12.sp, color: Color(0xff232425)),),
                      ),
                    ],
                  ), CustomTextFormField(validate: (data) {
                    if (confirmPasswordController.text !=
                        passwordController.text) {
                      return 'Passwords do not match';
                    }
                  },
                      controller: confirmPasswordController,
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