import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:scanly/bloc/login/login_cubit.dart';
import 'package:scanly/bloc/user/user_cubit.dart';
import 'package:scanly/components/checkbox.dart';
import 'package:scanly/components/custom_button.dart';
import 'package:scanly/components/custom_form_text_field.dart';
import 'package:scanly/components/custom_page_route.dart';
import 'package:scanly/screens/continue_login_screen.dart';
import 'package:scanly/screens/home_screen.dart';
import 'package:scanly/screens/register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

var emailController = TextEditingController();
var passwordController = TextEditingController();
late GoogleSignInAccount currentUser;

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    emailController.text = LoginCubit.get(context).emailText ?? "";
    passwordController.text = LoginCubit.get(context).passwordText ?? "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var cubit = LoginCubit.get(context);
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) async {
        if (state is LoginSuccessState) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
              elevation: 0,
              behavior: SnackBarBehavior.fixed,
              backgroundColor: Colors.transparent,
              content: AwesomeSnackbarContent(
                title: 'Congrats',
                message:
                'Welcome to Scanly',
                contentType: ContentType.success,color: Color(0xff04657A),
              ),
            ));
          await UserCubit.get(context).receiverUserData();
          Navigator.pushReplacement(
              context,
              AnimatedRoute(page: HomeScreen()));
        }else if(state is LoginErrorState){
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
              elevation: 0,
              behavior: SnackBarBehavior.fixed,
              backgroundColor: Colors.transparent,
              content: AwesomeSnackbarContent(
                title: 'Error',
                message:
                LoginCubit.get(context).error!,
                contentType: ContentType.failure,
              ),
            ));
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Container(
            width: 1.sw,
            height: 1.sh,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/Scanly_bg.png"),
                    fit: BoxFit.cover)),
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 32.h),
                child: Column(children: [
                  Container(
                      margin: EdgeInsets.only(bottom: 5.h),
                      height: 240.h,
                      child: Image.asset("assets/images/Logo.png")),
                  Text(
                    "Sign in",
                    style: GoogleFonts.montserrat(
                        fontSize: 38.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xff232425)),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5.h),
                    height: 160.h,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 45.w),
                                  child: Text(
                                    "Email",
                                    style: GoogleFonts.nunito(
                                        fontSize: 12.sp,
                                        color: Color(0xff232425)),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              width: 280.w,
                              child: CustomTextFormField(
                                  controller: emailController,
                                  readOnly: false,
                                  hint: "Email@mail.com",
                                  obscureText: false),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 45.w),
                                  child: Text(
                                    "Password",
                                    style: GoogleFonts.nunito(
                                        fontSize: 12.sp,
                                        color: Color(0xff232425)),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              width: 280.w,
                              child: CustomTextFormField(
                                  controller: passwordController,
                                  readOnly: false,
                                  hint: " ********",
                                  obscureText: true),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CheckBox(),
                          Text(
                            "Remember Me",
                            style: GoogleFonts.nunito(
                                color: Color(0xff232425), fontSize: 14.sp),
                          )
                        ],
                      ),
                      TextButton(
                          onPressed: () {},
                          child: Text(
                            "Forgot Your Password?",
                            style: GoogleFonts.nunito(
                                color: Color(0xff232425).withOpacity(0.8),
                                fontSize: 14.sp),
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  CustomButton(
                      screenWidth: 280.w,
                      screenHeight: 50.h,
                      text: "Login",
                      onpressed: () async {
                        await cubit.handleRemeberme(
                            emailController.text, passwordController.text);
                        await cubit.signInWithEmail(
                            emailController.text, passwordController.text);
                        await UserCubit.get(context).getUserData();
                        await UserCubit.get(context).receiverUserData();
                      },
                      bColor: Color(0xff1A83B6),
                      borderColor: Colors.transparent,
                      textStyle: GoogleFonts.nunito(
                          fontWeight: FontWeight.bold,
                          fontSize: 22.sp,
                          color: Colors.white)),
                  SizedBox(
                    height: 24.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Colors.transparent),
                              elevation: MaterialStatePropertyAll(0)),
                          onPressed: () async {
                            try {
                              final user = await cubit.signInWithFacebook();
                              await cubit.doesEmailExist(user!.email!);
                              if (cubit.isExist == true) {
                                await UserCubit.get(context).getUserData();
                                await UserCubit.get(context).receiverUserData();
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomeScreen()));
                              } else if (cubit.isExist == false) {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ContinueLoginScreen(
                                              user: user,
                                            )));
                              }
                            } on FirebaseAuthException catch (error) {
                              print(error.message);
                            } catch (e) {
                              print(e);
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(),
                            width: 45.w,
                            height: 44.h,
                            child: ClipRRect(
                              child: Image.asset("assets/images/facebook.png"),
                            ),
                          )),
                      ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Colors.transparent),
                              elevation: MaterialStatePropertyAll(0)),
                          onPressed: () async {
                            try {
                              final user = await cubit.googleSignin();
                              print(user!.email);
                              await cubit.doesEmailExist(user!.email!);
                              if (cubit.isExist == true) {
                                await UserCubit.get(context).getUserData();
                                await UserCubit.get(context).receiverUserData();
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomeScreen()));
                              } else if (cubit.isExist == false) {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ContinueLoginScreen(
                                              user: user,
                                            )));
                              }
                            } on FirebaseAuthException catch (error) {
                              print(error.message);
                            } catch (e) {
                              print(e);
                            }
                          },
                          child: Container(
                            width: 45.w,
                            height: 44.h,
                            child: ClipRRect(
                              child: Image.asset("assets/images/google.png"),
                            ),
                          )),
                      ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Colors.transparent),
                              elevation: MaterialStatePropertyAll(0)),
                          onPressed: () {},
                          child: Container(
                            width: 45.w,
                            height: 44.h,
                            child: ClipRRect(
                              child: Image.asset("assets/images/apple.png"),
                            ),
                          ))
                    ],
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Dont have an account?",
                        style: GoogleFonts.nunito(
                          fontSize: 14.sp,
                          color: Color(0xff232425).withOpacity(0.8),
                        ),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>RegisterScreen()));
                          },
                          child: Text(
                            "Sign Up!",
                            style: GoogleFonts.nunito(
                                fontSize: 16.sp,
                                color: Color(0xff1d80b5),
                                fontWeight: FontWeight.bold),
                          ))
                    ],
                  )
                ]),
              ),
            ),
          ),
        );
      },
    );
  }
}
