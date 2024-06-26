import 'dart:async';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:scanly/bloc/register/register_cubit.dart';
import 'package:scanly/components/custom_button.dart';
import 'package:scanly/components/custom_form_text_field.dart';
import 'package:scanly/components/disease_dropdown.dart';
import 'package:scanly/components/register_step1.dart';
import 'package:scanly/components/register_step2.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:scanly/screens/login_screen.dart';
import 'package:scanly/components/gender_dropdown.dart';

import '../generated/l10n.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  int index = 0;
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();
  var genderController = TextEditingController();
  var heightController = TextEditingController();
  var weightController = TextEditingController();
  late MemoryImage? _selectedImage;
  final MultiSelectController diseaseController = MultiSelectController();
  var confirmPasswordController = TextEditingController();
  var dateController = TextEditingController();
  DateTime? date;
  final formKey1 = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();
  final pwKey = GlobalKey<FormState>();
  final formKey3 = GlobalKey<FormState>();
  var isClicked = false;
  late Timer _timer;
  _startTimer() {
    _timer = Timer(Duration(seconds: 5), () => isClicked = false);
  }
  @override
  Widget build(BuildContext context) {
    var cubit = RegisterCubit.get(context);
    return BlocConsumer<RegisterCubit, RegisterState>(
  listener: (context, state) async {
    if (state is RegisterUserSuccess){
      cubit.sendVerificationEmail();
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.fixed,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: S.of(context).Account_Created,
            message:
            S.of(context).sent_mail_verify_account,
            contentType: ContentType.success,color: Color(0xff04657A),
          ),
        ));
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  LoginScreen()));
    }
  },
  builder: (context, state) {
    if(state is SaveUserLoadingState || state is SaveUserSuccessState || state is RegisterUserSuccess || state is RegisterUserLoading){
      return Scaffold(
        body:
        Container(decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/Scanly_bg.png"),
                fit: BoxFit.cover)),
          child:Center(child: Column(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              Text("Creating Account",style: GoogleFonts.montserrat(fontSize:20.sp,color:Color(0xff232425),fontWeight:FontWeight.w600),)
            ],
          )) ,
        ),
      );
    }
    return Scaffold(
      backgroundColor: Color(0xffFAFAFA),
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SingleChildScrollView(
                child: Stack(
                  children: [
                    Container(
                      height: 370.h,
                      width: 1.sw,
                      decoration: BoxDecoration(
                          boxShadow: [BoxShadow(blurRadius: 4)],
                          image: DecorationImage(
                              image: AssetImage("assets/images/Scanly_bg.png"),
                              fit: BoxFit.cover),
                          borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(30))),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 12.w, vertical: 30.h),
                        child: Column(
                          children: [
                            Text(
                              S.of(context).create_account,
                              style: GoogleFonts.nunito(
                                  fontSize: 22.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff232425)),
                            ),
                            Text(
                              S.of(context).add_picture,
                              style: GoogleFonts.nunito(
                                  fontSize: 18.sp, color: Color(0xff232425)),
                            ),
                            Stack(children: [
                              Center(
                                  child: Container(
                                margin: EdgeInsets.symmetric(vertical: 20.h),
                                child: cubit.image != null
                                    ? CircleAvatar(
                                        radius: 80.r,
                                        backgroundImage:
                                            MemoryImage(cubit.image!),
                                      )
                                    : CircleAvatar(
                                        backgroundColor: Colors.transparent,
                                        radius: 80.r,
                                        backgroundImage: AssetImage(
                                            "assets/images/avatar.png"),
                                      ),
                              )),
                              Positioned(
                                  bottom: 3.h,
                                  left: 205.w,
                                  child: IconButton(
                                      onPressed: () {
                                        cubit.selectImage().then((image) {
                                          setState(() {
                                            _selectedImage = image;
                                          });
                                        });
                                      },
                                      icon: const Icon(
                                        Icons.add_a_photo_outlined,
                                        color: Colors.black87,
                                      )))
                            ]),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          Positioned(
            bottom: 0,
            top: 300.h,
            left: 12.w,
            right: 12.w,
            child: Theme(
                data: Theme.of(context).copyWith(
                    canvasColor: Colors.transparent,
                    colorScheme: ColorScheme.light(primary: Color(0xff179BE8))),
                child: Stepper(
                    elevation: 0,
                    connectorThickness: 2,
                    type: StepperType.horizontal,
                    currentStep: index,
                    steps: [
                      Step(
                          state: index <= 0
                              ? StepState.indexed
                              : StepState.complete,
                          isActive: index >= 0,
                          title: SizedBox.shrink(),
                          content: RegisterStep1(
                              formKey1: formKey1,
                              nameController: nameController,
                              emailController: emailController,
                              cubit: cubit,
                              phoneController: phoneController)),
                      Step(
                          state: index <= 1
                              ? StepState.indexed
                              : StepState.complete,
                          isActive: index >= 1,
                          title: SizedBox.shrink(),
                          content: RegisterStep2(pwKey: pwKey,
                              onTap: () async {
                                date = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime(2000),
                                    firstDate: DateTime(1950),
                                    lastDate: DateTime(2012));
                                if (date != null) {
                                  dateController.text =
                                      DateFormat('d/M/yyyy').format(date!);
                                }
                              },
                              formKey2: formKey2,
                              dateController: dateController,
                              passwordController: passwordController,
                              confirmPasswordController:
                                  confirmPasswordController)),
                      Step(
                          state: index <= 2
                              ? StepState.indexed
                              : StepState.complete,
                          isActive: index >= 2,
                          title: SizedBox.shrink(),
                          content: Container(
                            height: 320.h,
                            child: Form(
                                key: formKey3,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(
                                      children: [
                                        Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(left: 8.w),
                                              child: Text(
                                                S.of(context).gender,
                                                style: GoogleFonts.nunito(
                                                    fontSize: 12.sp,
                                                    color: Color(0xff232425)),
                                              ),
                                            ),
                                          ],
                                        ),
                                        GenderDropDown(
                                            screenWidth: 1.sw,
                                            screenHeight: 1.sh,
                                            genderController: genderController),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              children: [
                                                Text(
                                                  S.of(context).height,
                                                  style: GoogleFonts.nunito(
                                                      fontSize: 12.sp,
                                                      color: Color(0xff232425)),
                                                ),
                                                Container(
                                                  width: 90.w,
                                                  child: CustomTextFormField(
                                                      type:
                                                          TextInputType.number,
                                                      controller:
                                                          heightController,
                                                      readOnly: false,
                                                      hint: " 180 Cm",
                                                      obscureText: false),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Text(
                                                  S.of(context).weight,
                                                  style: GoogleFonts.nunito(
                                                      fontSize: 12.sp,
                                                      color: Color(0xff232425)),
                                                ),
                                                Container(
                                                  width: 90.w,
                                                  child: CustomTextFormField(
                                                      type:
                                                          TextInputType.number,
                                                      controller:
                                                          weightController,
                                                      readOnly: false,
                                                      hint: "   70 KG",
                                                      obscureText: false),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(left: 8.w),
                                              child: Text(
                                                S.of(context).medical_history,
                                                style: GoogleFonts.nunito(
                                                    fontSize: 12.sp,
                                                    color: Color(0xff232425)),
                                              ),
                                            ),
                                          ],
                                        ),
                                        DiseaseDropDown(
                                            diseaseController:
                                                diseaseController,
                                            screenHeight: 1.sh)
                                      ],
                                    )
                                  ],
                                )),
                          ))
                    ],
                    controlsBuilder: (context, details) {
                      return Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomButton(
                                screenWidth: 136.w,
                                screenHeight: 50.h,
                                text: S.of(context).back,
                                onpressed: () {
                                  if (index <= 2 && index > 0) {
                                    setState(() {
                                      index--;
                                    });
                                  } else if (index == 0) {
                                    Navigator.pop(context);
                                  }
                                },
                                bColor: Color(0xffFAFAFA),
                                borderColor: Color(0xff179BE8),
                                textStyle: GoogleFonts.nunito(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.sp,
                                    color: Color(0xff179BE8))),
                            CustomButton(
                                screenWidth: 136.w,
                                screenHeight: 50.h,
                                text: S.of(context).continue_message,
                                onpressed: () async {
                                  if (index == 2) {
                                    if(genderController.text==""){
                                      ScaffoldMessenger.of(context)
                                        ..hideCurrentSnackBar()
                                        ..showSnackBar(SnackBar(
                                          elevation: 0,
                                          behavior: SnackBarBehavior.fixed,
                                          backgroundColor: Colors.transparent,
                                          content: AwesomeSnackbarContent(
                                            title: S.of(context).error,
                                            message:
                                            S.of(context).grnder_message,
                                            contentType: ContentType.failure,
                                          ),
                                        ));
                                    }else if(heightController.text==""){
                                      ScaffoldMessenger.of(context)
                                        ..hideCurrentSnackBar()
                                        ..showSnackBar(SnackBar(
                                          elevation: 0,
                                          behavior: SnackBarBehavior.fixed,
                                          backgroundColor: Colors.transparent,
                                          content: AwesomeSnackbarContent(
                                            title: S.of(context).error,
                                            message:
                                            S.of(context).height_message,
                                            contentType: ContentType.failure,
                                          ),
                                        ));
                                    }else if(weightController.text==""){
                                      ScaffoldMessenger.of(context)
                                        ..hideCurrentSnackBar()
                                        ..showSnackBar(SnackBar(
                                          elevation: 0,
                                          behavior: SnackBarBehavior.fixed,
                                          backgroundColor: Colors.transparent,
                                          content: AwesomeSnackbarContent(
                                            title: S.of(context).error,
                                            message:
                                            S.of(context).weight_message,
                                            contentType: ContentType.failure,
                                          ),
                                        ));
                                    }
                                    else {
                                      if (isClicked == false) {
                                        _startTimer();
                                        isClicked = true;
                                        cubit.diseases = diseaseController
                                            .selectedOptions
                                            .map((option) => option.value)
                                            .toList();
                                        cubit.gender = genderController.text;
                                        cubit.height =
                                            int.parse(heightController.text);
                                        cubit.weight =
                                            int.parse(weightController.text);
                                        await cubit.registerUser(
                                            cubit.email, cubit.password);
                                        await cubit.saveUser(
                                            cubit.email,
                                            cubit.password,
                                            cubit.name,
                                            cubit.phoneNumber,
                                            cubit.date,
                                            cubit.gender,
                                            cubit.height ?? 0,
                                            cubit.weight ?? 0,
                                            cubit.diseases ?? [],
                                            cubit.image);
                                      }
                                    }
                                  } else if (index == 0 &&
                                      formKey1.currentState!.validate()) {
                                    if (await cubit.doesEmailExist(emailController.text)) {
                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text("Email Already Exists")));
    }else{
                                      cubit.name = nameController.text;
                                      cubit.email = emailController.text;
                                      cubit.phoneNumber =
                                          int.parse(phoneController.text);
                                      print(
                                          "name=${cubit.name}\nemail=${cubit.email}\nnumber=${cubit.phoneNumber}");
                                      setState(() {
                                        index++;
                                      });
                                    }
                                  } else if (index == 1 &&
                                      formKey2.currentState!.validate() && cubit.pwValidate==true) {
                                    cubit.date = date;
                                    cubit.password =
                                        confirmPasswordController.text;
                                    setState(() {
                                      index++;
                                    });
                                  }
                                },
                                bColor: Color(0xff179BE8),
                                borderColor: Colors.transparent,
                                textStyle: GoogleFonts.nunito(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.sp,
                                    color: Colors.white)),
                          ],
                        ),
                      );
                    })),
          ),
        ],
      ),
    );
  },
);
  }
}
