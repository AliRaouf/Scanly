import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../bloc/user/user_cubit.dart';
import '../components/custom_form_text_field.dart';
import '../components/custom_page_route.dart';
import '../components/gradient_button.dart';
import 'login_screen.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  var oldPasswordController = TextEditingController();
  var newPasswordController = TextEditingController();
  var confirmNewPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    var cubit = UserCubit.get(context);
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {
        if (state is ChangeUserPasswordSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Password Changed Successfully")));
          Navigator.pushReplacement(
              context,
              AnimatedRoute(page: LoginScreen()));
        }else if (state is ChangeUserPasswordErrorState){
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Failed To Change Password")));
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: const Color(0xfffafafa),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ListView(children: [
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back_ios_new_outlined)),
                ],
              ),
              Container(
                  margin: EdgeInsets.symmetric(
                      vertical: screenHeight * 0.04, horizontal: 16),
                  child: Text(
                    "Want to Change your Password?",
                    style: GoogleFonts.nunito(fontSize: 18.sp,color:Color(0xff232425)),
                  )),
              Form(key: formKey,
                child: Column(
                  children: [
                    Container(
                      width: screenWidth * 0.8,
                      margin: EdgeInsets.only(bottom: screenHeight * 0.05),
                      child: Column(
                        children: [
                          CustomTextFormField(
                            hint: "Old Password",
                            controller: oldPasswordController,
                            obscureText: cubit.isOldPasswordObscured,
                            icon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    cubit.toggleOldPasswordVisibility();
                                  });
                                },
                                icon: Icon(cubit.isOldPasswordObscured
                                    ? Icons.visibility
                                    : Icons.visibility_off)),
                            iconColor: cubit.isOldPasswordObscured
                                ? Colors.blue
                                : Colors.grey,
                            readOnly: false,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: screenWidth * 0.8,
                      margin: EdgeInsets.only(bottom: screenHeight * 0.05),
                      child: Column(children: [
                        CustomTextFormField(
                          hint: "New Password",
                          controller: newPasswordController,
                          obscureText: cubit.isNewPasswordObscured,
                          icon: IconButton(
                              onPressed: () {
                                setState(() {
                                  cubit.toggleNewPasswordVisibility();
                                });
                              },
                              icon: Icon(cubit.isNewPasswordObscured
                                  ? Icons.visibility
                                  : Icons.visibility_off)),
                          iconColor: cubit.isNewPasswordObscured
                              ? Colors.blue
                              : Colors.grey,
                          readOnly: false,
                        ),
                        FlutterPwValidator(
                            controller: newPasswordController,
                            minLength: 8,
                            uppercaseCharCount: 1,
                            numericCharCount: 1,
                            width: 1.sw,
                            height: 105.h,
                            onSuccess: () {
                              print("Success");
                            })
                      ]),
                    ),
                    Container(
                      width: screenWidth * 0.8,
                      margin: EdgeInsets.only(bottom: screenHeight * 0.05),
                      child: CustomTextFormField(
                        validate: (data) {
                          if (confirmNewPasswordController.text !=
                              newPasswordController.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                        hint: "Confirm New Password",
                        controller: confirmNewPasswordController,
                        obscureText: cubit.isConfirmNewPasswordObscured,
                        icon: IconButton(
                            onPressed: () {
                              setState(() {
                                cubit.toggleConfirmNewPasswordVisibility();
                              });
                            },
                            icon: Icon(cubit.isConfirmNewPasswordObscured
                                ? Icons.visibility
                                : Icons.visibility_off)),
                        iconColor: cubit.isConfirmNewPasswordObscured
                            ? Colors.blue
                            : Colors.grey,
                        readOnly: false,
                      ),
                    ),
                    GradientButton(
                      screenWidth: screenWidth * 0.6,
                      screenHeight: screenHeight * 0.075,
                      text: 'Change Password',
                      onpressed: () {
                        if (formKey.currentState!.validate()) {
                          cubit.changeUserPassword(oldPasswordController.text,
                              newPasswordController.text);
                        }
                      },
                      fontSize: 18.sp,
                      border: 20,
                    ),
                  ],
                ),
              )
            ]),
          ),
        );
      },
    );
  }
}
