import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:scanly/bloc/register/register_cubit.dart';
import 'package:scanly/bloc/user/user_cubit.dart';
import 'package:scanly/components/custom_button.dart';
import 'package:scanly/components/custom_form_text_field.dart';
import 'package:scanly/components/disease_dropdown.dart';
import 'package:scanly/components/gender_dropdown.dart';
import 'package:scanly/screens/home_screen.dart';

import '../generated/l10n.dart';

class ContinueLoginScreen extends StatefulWidget {
  ContinueLoginScreen({super.key, required this.user});

  final User user;

  @override
  State<ContinueLoginScreen> createState() => _ContinueLoginScreenState();
}

class _ContinueLoginScreenState extends State<ContinueLoginScreen> {
  var heightController = TextEditingController();
  var weightController = TextEditingController();
  var genderController = TextEditingController();
  DateTime? date;
  final MultiSelectController diseaseController = MultiSelectController();
  var dateController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    late MemoryImage? _selectedImage;
    var cubit = RegisterCubit.get(context);
    return BlocConsumer<UserCubit, UserState>(
  listener: (context, state) {
  },
  builder: (context, state) {
    if(state is SaveUserLoadingState || state is SaveUserSuccessState || state is ReceiveUserNameLoadingState){
      return Scaffold(
        body:
        Container(decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/Scanly_bg.png"),
                fit: BoxFit.cover)),
          child:Center(child: Column(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              Text("Logging in",style: GoogleFonts.montserrat(fontSize:20.sp,color:Color(0xff232425),fontWeight:FontWeight.w600),)
            ],
          )) ,
        ),
      );
    }
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(
                  children: [
            Container(decoration: BoxDecoration(borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),color: Color(0xffaaddf1)),
              child: SafeArea(
                child: Container(
                  height: screenHeight * 0.3758,
                  width: screenWidth,
                  decoration: BoxDecoration(
                      boxShadow: [BoxShadow(blurRadius: 4)],
                      image: DecorationImage(
                          image: AssetImage("assets/images/Scanly_bg.png"),
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.vertical(bottom: Radius.circular(30))),
                  child: Padding(
                    padding:EdgeInsets.symmetric(horizontal: screenWidth*0.06111111111),
                    child: Column(
                      children: [
                        Text(
                          "Hi ${widget.user.displayName ?? ""}",
                          style: GoogleFonts.openSans(
                              fontSize: screenWidth *0.05092592592,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff232425)),
                        ),
                        Text(
                          "Continue With Login Process",
                          style: GoogleFonts.openSans(
                              fontSize: screenWidth *0.05092592592,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff232425)),
                        ),
                        Text(
                          S.of(context).add_picture,
                          style: GoogleFonts.openSans(
                              fontSize: screenWidth * 0.04444,
                              color: Color(0xff232425)),
                        ),
                        Stack(children: [
                          Center(
                              child: Container(
                            margin: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                            child: RegisterCubit.get(context).image != null
                                ? CircleAvatar(
                                    radius: screenWidth*0.2037037037,
                                    backgroundImage:
                                        MemoryImage(cubit.image!),
                                  )
                                : CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    radius: screenWidth*0.2037037037,
                                    backgroundImage:
                                        NetworkImage(widget.user.photoURL!),
                                  ),
                          )),
                          Positioned(
                              bottom: 0,
                              left: screenWidth * 0.57,
                              child: IconButton(
                                  onPressed: () {
                                    RegisterCubit.get(context)
                                        .selectImage()
                                        .then((image) {
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
              ),
            ),
            Container(margin: EdgeInsets.symmetric(vertical: screenHeight*0.02),padding: EdgeInsets.symmetric(horizontal:screenWidth*0.1),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(S.of(context).birth),
                    ],
                  ),
                  CustomTextFormField(
                    controller: dateController,
                      readOnly: false,
                      hint: "DD/M/YYYY",
                      obscureText: false,
                  onTap: () async {
                    date = await showDatePicker(
                        context: context,
                        initialDate: DateTime(2000),
                        firstDate: DateTime(1950),
                        lastDate: DateTime(2012));
                    if (date != null) {
                      setState(() {
                        dateController.text=DateFormat('d/M/yyyy').format(date!);
                      });
                    }
                  },),
                ],
              ),
            ),
            Column(
              children: [
                Container(
                    margin: EdgeInsets.symmetric(horizontal: screenWidth*0.1),
                    child: Row(
                      children: [
                        Text(S.of(context).gender),
                      ],
                    )),
                GenderDropDown(screenWidth: screenWidth, screenHeight: screenHeight, genderController: genderController),
              ],
            ),
            Container(margin: EdgeInsets.symmetric(horizontal: screenWidth*0.1,vertical: screenHeight*0.02),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(
                            S.of(context).height,
                            style: GoogleFonts.openSans(
                                fontSize:
                                screenWidth * 0.04,
                                color: Color(0xff232425)),
                          ),
                          Container(
                            width: screenWidth * 0.25,
                            child: CustomTextFormField(type: TextInputType.number,
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
                            style: GoogleFonts.openSans(
                                fontSize:
                                screenWidth * 0.04,
                                color: Color(0xff232425)),
                          ),
                          Container(
                            width: screenWidth * 0.25,
                            child: CustomTextFormField(type: TextInputType.number,
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
            ), Container(margin: EdgeInsets.symmetric(horizontal: screenWidth*0.1),
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: screenWidth*0.02037037037),
                        child: Text(
                          S.of(context).medical_history,
                          style: GoogleFonts.openSans(
                              fontSize:
                              screenWidth * 0.04,
                              color: Color(0xff232425)),
                        ),
                      ),
                    ],
                  ),
                  DiseaseDropDown(diseaseController: diseaseController, screenHeight: screenHeight)
                ],
              ),
            ),
                    Container(margin: EdgeInsets.only(top: screenHeight*0.015),
                      child: CustomButton(
                          screenWidth: screenWidth * 0.7,
                          screenHeight: screenHeight * 0.0625,
                          text: S.of(context).continue_message,
                          onpressed: () async{
                            if (genderController.text.isNotEmpty && heightController.text.isNotEmpty && weightController.text.isNotEmpty) {
                              Uint8List image= await cubit.getDefaultImageBytesFromImage(widget.user.photoURL??"");
                              await cubit.saveUser(
                                  widget.user.email,
                                  "",
                                  widget.user.displayName,
                                  1,
                                  DateFormat('d/M/yyyy').format(date!),
                                  genderController.text,
                                  int.parse(heightController.text),
                                  int.parse(weightController.text),
                                  diseaseController.selectedOptions
                                      .map((option) => option.value)
                                      .toList(),
                                cubit.image ?? image
                                  );
                              await UserCubit.get(context).receiverUserData();
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          HomeScreen()
                                          ));
                            }
                          },
                          bColor: Color(0xff179BE8),
                          borderColor: Colors.transparent,
                          textStyle: GoogleFonts.openSans(
                              fontWeight: FontWeight.bold,
                              fontSize: screenWidth * 0.04444,
                              color: Colors.white)),
                    )
                  ],
                ),
          ),
        );
  },
);
  }
}
