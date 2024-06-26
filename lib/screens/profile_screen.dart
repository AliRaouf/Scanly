import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scanly/bloc/user/user_cubit.dart';
import 'package:scanly/components/custom_form_text_field.dart';

import '../generated/l10n.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = UserCubit.get(context);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    var nameController = TextEditingController(text: cubit.userName);
    var emailController = TextEditingController(text: FirebaseAuth.instance.currentUser!.email);
    var phoneController = TextEditingController(text: "${cubit.phoneNumber}");
    var genderController = TextEditingController(text: "${cubit.gender}");
    var heightController = TextEditingController(text: " ${cubit.height} CM");
    var weightController = TextEditingController(text: " ${cubit.weight} KG");
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          body: Container(
              width: screenWidth,
              height: screenHeight,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/Scanly_bg.png"),
                      fit: BoxFit.cover)),
              child: Column(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: screenWidth * 0.2,
                    backgroundColor: Colors.transparent,
                    child: ClipOval(
                      child: CachedNetworkImage(
                        imageUrl: cubit.imageUrl,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) =>
                                CircularProgressIndicator(
                                    value: downloadProgress.progress),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.65,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: screenWidth * 0.6667,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left:
                                            screenWidth * 0.02037037037),
                                    child: Text(
                                      S.of(context).user_name,
                                      style: GoogleFonts.nunito(
                                          fontSize: screenWidth * 0.04,
                                          color: const Color(0xff232425)),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.circular(10)),
                                child: CustomTextFormField(
                                    preIcon: const Icon(
                                        CupertinoIcons.profile_circled),
                                    controller: nameController,
                                    readOnly: true,
                                    hint: "UserName",
                                    obscureText: false),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: screenWidth * 0.6667,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left:
                                            screenWidth * 0.02037037037),
                                    child: Text(
                                      S.of(context).email,
                                      style: GoogleFonts.nunito(
                                          fontSize: screenWidth * 0.04,
                                          color: const Color(0xff232425)),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.circular(10)),
                                child: CustomTextFormField(
                                    preIcon: const Icon(Icons.email_outlined),
                                    controller: emailController,
                                    readOnly: true,
                                    hint: "Email",
                                    obscureText: false),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: screenWidth * 0.6667,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left:
                                            screenWidth * 0.02037037037),
                                    child: Text(
                                      S.of(context).phone,
                                      style: GoogleFonts.nunito(
                                          fontSize: screenWidth * 0.04,
                                          color: const Color(0xff232425)),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.circular(10)),
                                child: CustomTextFormField(
                                    preIcon: const Icon(Icons.phone_outlined),
                                    controller: phoneController,
                                    readOnly: true,
                                    hint: "PhoneNumber",
                                    obscureText:
                                        phoneController.text == "1"
                                            ? true
                                            : false),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.08148148148),
                          child: Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    S.of(context).height,
                                    style: GoogleFonts.nunito(
                                        fontSize: screenWidth * 0.04,
                                        color: const Color(0xff232425)),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    width: screenWidth * 0.25,
                                    child: CustomTextFormField(
                                        type: TextInputType.number,
                                        controller: heightController,
                                        readOnly: true,
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
                                        fontSize: screenWidth * 0.04,
                                        color: const Color(0xff232425)),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    width: screenWidth * 0.25,
                                    child: CustomTextFormField(
                                        type: TextInputType.number,
                                        controller: weightController,
                                        readOnly: true,
                                        hint: "   70 KG",
                                        obscureText: false),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          width: screenWidth * 0.6667,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left:
                                            screenWidth * 0.02037037037),
                                    child: Text(
                                      S.of(context).gender,
                                      style: GoogleFonts.nunito(
                                          fontSize: screenWidth * 0.04,
                                          color: const Color(0xff232425)),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.circular(10)),
                                child: CustomTextFormField(
                                    preIcon: cubit.gender == "Male"
                                        ? const Icon(Icons.male)
                                        : const Icon(Icons.female_outlined),
                                    controller: genderController,
                                    readOnly: true,
                                    hint: "Gender",
                                    obscureText: false),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: screenWidth * 0.6667,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left:
                                            screenWidth * 0.02037037037),
                                    child: Text(
                                      S.of(context).medical_history,
                                      style: GoogleFonts.nunito(
                                          fontSize: screenWidth * 0.04,
                                          color: const Color(0xff232425)),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                width: screenWidth * 0.6667,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.circular(10),
                                    border: Border.all(
                                        color: const Color(0xff179BE8))),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.all(
                                            screenWidth * 0.0385),
                                        child: Text(
                                          cubit.diseases!.join(', '),
                                          style: GoogleFonts.nunito(
                                            fontSize: screenWidth * 0.04,
                                            color:
                                                const Color(0xff232425),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )),
        );
      },
    );
  }
}
