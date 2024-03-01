import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:scanly/bloc/login/login_cubit.dart';
import 'package:scanly/bloc/user/user_cubit.dart';
import 'package:scanly/components/checkbox.dart';
import 'package:scanly/components/custom_button.dart';
import 'package:scanly/components/custom_form_text_field.dart';
import 'package:scanly/screens/continue_login_screen.dart';
import 'package:scanly/screens/home_screen.dart';

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
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    var cubit = LoginCubit.get(context);
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state)async{
        if (state is LoginSuccessState) {
          await UserCubit.get(context).receiverUserData();
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => HomeScreen()));
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: ColorfulSafeArea(
            color: Color(0xff80c6dc),
            child: Container(
              width: screenWidth,
              height: screenHeight,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/Scanly_bg.png"),
                      fit: BoxFit.cover)),
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                  child: Column(children: [
                    Container(
                        margin: EdgeInsets.only(bottom: screenHeight * 0.01),
                        height: screenHeight * 0.3,
                        child: Image.asset("assets/images/Logo.png")),
                    Text(
                      "Sign in",
                      style: GoogleFonts.montserrat(
                          fontSize: screenWidth * 0.12,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xff232425)),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: screenHeight * 0.01),
                      height: screenHeight * 0.22,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: screenWidth * 0.13),
                                    child: Text(
                                      "Email",
                                      style: GoogleFonts.openSans(
                                          fontSize: screenWidth * 0.04,
                                          color: Color(0xff232425)),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)),
                                width: screenWidth * 0.8,
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
                                    padding:
                                        EdgeInsets.only(left: screenWidth * 0.13),
                                    child: Text(
                                      "Password",
                                      style: GoogleFonts.openSans(
                                          fontSize: screenWidth * 0.04,
                                          color: Color(0xff232425)),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)),
                                width: screenWidth * 0.8,
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
                              style: GoogleFonts.openSans(
                                  color: Color(0xff232425),
                                  fontSize: 0.04 * screenWidth),
                            )
                          ],
                        ),
                        TextButton(
                            onPressed: () {},
                            child: Text(
                              "Forgot Your Password?",
                              style: GoogleFonts.openSans(
                                  color: Color(0xff232425).withOpacity(0.8),
                                  fontSize: screenWidth * 0.04),
                            )),
                      ],
                    ),
                    SizedBox(
                      height: screenHeight * 0.03,
                    ),
                    CustomButton(
                        screenWidth: screenWidth * 0.778,
                        screenHeight: screenHeight * 0.065,
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
                        textStyle: GoogleFonts.openSans(
                            fontWeight: FontWeight.bold,
                            fontSize: screenWidth * 0.05556,
                            color: Colors.white)),
                    SizedBox(
                      height: screenHeight * 0.03,
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
                                if (cubit.isExist==true) {
                                  await UserCubit.get(context).getUserData();
                                  await UserCubit.get(context).receiverUserData();
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => HomeScreen()));
                                }else if (cubit.isExist==false) {
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
                              width: screenWidth * 0.122,
                              height: screenHeight * 0.055,
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
                                await cubit.doesEmailExist(user!.email!);
                                if (cubit.isExist==true) {
                                  await UserCubit.get(context).getUserData();
                                  await UserCubit.get(context).receiverUserData();
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => HomeScreen()));
                                }else if (cubit.isExist==false) {
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
                              width: screenWidth * 0.122,
                              height: screenHeight * 0.055,
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
                              width: screenWidth * 0.122,
                              height: screenHeight * 0.055,
                              child: ClipRRect(
                                child: Image.asset("assets/images/apple.png"),
                              ),
                            ))
                      ],
                    ),
                    SizedBox(
                      height: screenHeight * 0.02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Dont have an account?",
                          style: GoogleFonts.openSans(
                            fontSize: screenWidth * 0.0444,
                            color: Color(0xff232425).withOpacity(0.8),
                          ),
                        ),
                        TextButton(
                            onPressed: () {},
                            child: Text(
                              "Sign Up!",
                              style: GoogleFonts.openSans(
                                  fontSize: screenWidth * 0.055556,
                                  color: Color(0xff1d80b5),
                                  fontWeight: FontWeight.bold),
                            ))
                      ],
                    )
                  ]),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
