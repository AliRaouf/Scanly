import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:scanly/bloc/register/register_cubit.dart';
import 'package:scanly/components/custom_form_text_field.dart';

class RegisterStep1 extends StatelessWidget {
  const RegisterStep1({
    super.key,
    required this.formKey1,
    required this.nameController,
    required this.emailController,
    required this.cubit,
    required this.phoneController,
  });

  final GlobalKey<FormState> formKey1;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final RegisterCubit cubit;
  final TextEditingController phoneController;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 320.h,
      child: Form(
        key: formKey1,
        child: Column(
          mainAxisAlignment:
          MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 0),
                      child: Text("Name",style: GoogleFonts.openSans(fontSize: 12.sp,color: Color(0xff232425)),),
                    ),
                  ],
                ),
                CustomTextFormField(
                    controller: nameController,
                    readOnly: false,
                    hint: "UserName",
                    obscureText: false),
              ],
            ),
            Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 8.w),
                      child: Text("Email",style: GoogleFonts.openSans(fontSize: 12.sp,color: Color(0xff232425)),),
                    ),
                  ],
                ),
                CustomTextFormField(
                    controller: emailController,
                    validate: cubit.validateEmail,
                    readOnly: false,
                    hint: "Email@mail.com",
                    obscureText: false),
              ],
            ),
            Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 8.w),
                      child: Text("PhoneNumber",style: GoogleFonts.openSans(fontSize: 12.sp,color: Color(0xff232425)),),
                    ),
                  ],
                ),
                IntlPhoneField(
                  controller: phoneController,
                  initialCountryCode: "EG",decoration: InputDecoration(alignLabelWithHint: true,
                    contentPadding:
                    EdgeInsets.symmetric(vertical: 15.h, horizontal: 15.w),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Color(0xff3DADA1))),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Color(0xff3DADA1))),
                    focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Color(0xff3DADA1))),
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Color(0xff3DADA1)))),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
