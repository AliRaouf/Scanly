
import 'package:flutter/material.dart';
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
import 'package:colorful_safe_area/colorful_safe_area.dart';
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
  final formKey3 = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery
        .of(context)
        .size
        .height;
    double screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    var cubit = RegisterCubit.get(context);
    return Scaffold(
      backgroundColor: Color(0xffFAFAFA),
      body: ColorfulSafeArea(color : Color(0xff80c6dc),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SingleChildScrollView(
                  child: Stack(
                    children: [
                      Container(
                        height: screenHeight * 0.4625,
                        width: screenWidth,
                        decoration: BoxDecoration(
                            boxShadow: [BoxShadow(blurRadius: 4)],
                            image: DecorationImage(
                                image: AssetImage("assets/images/Scanly_bg.png"),
                                fit: BoxFit.cover),
                            borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(30))),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal:screenWidth*0.06111111111),
                          child: Column(
                            children: [
                              Text(
                                "Create a New Account",
                                style: GoogleFonts.openSans(
                                    fontSize: screenWidth * 0.0556,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff232425)),
                              ),
                              Text(
                                "Add a profile picture",
                                style: GoogleFonts.openSans(
                                    fontSize: screenWidth * 0.04444,
                                    color: Color(0xff232425)),
                              ),
                              Stack(children: [
                                Center(
                                    child: Container(
                                      margin: EdgeInsets.symmetric(
                                          vertical: screenHeight * 0.05),
                                      child: cubit.image != null
                                          ? CircleAvatar(
                                        radius: 80,
                                        backgroundImage: MemoryImage(
                                            cubit.image!),
                                      )
                                          : CircleAvatar(
                                        backgroundColor: Colors.transparent,
                                        radius: screenWidth*0.2037037037,
                                        backgroundImage: AssetImage(
                                            "assets/images/avatar.png"),
                                      ),
                                    )),
                                Positioned(
                                    bottom: screenHeight * 0.02,
                                    left: screenWidth * 0.57,
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
              top: screenHeight * 0.38,
              left: screenWidth*0.03819444444,
              right: screenWidth*0.03819444444,
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
                            content: RegisterStep2(
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
                              height: screenHeight * 0.37,
                              child: Form(
                                  key: formKey3,
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                    children: [
                                      Column(
                                        children: [
                                          Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 0.02037037037),
                                                child: Text(
                                                  "Gender",
                                                  style: GoogleFonts.openSans(
                                                      fontSize:
                                                      screenWidth * 0.04,
                                                      color: Color(0xff232425)),
                                                ),
                                              ),
                                            ],
                                          ),
                                          GenderDropDown(screenWidth: screenWidth, screenHeight: screenHeight, genderController: genderController),
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
                                                    "Height",
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
                                                    "Weight",
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
                                      Column(
                                        children: [
                                          Row(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: screenWidth*0.02037037037),
                                                child: Text(
                                                  "Medical History",
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
                                      )
                                    ],
                                  )),
                            ))
                      ],
                      controlsBuilder: (context, details) {
                        return Container(
                          margin:
                          EdgeInsets.symmetric(vertical: screenHeight * 0.03),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomButton(
                                  screenWidth: screenWidth * 0.35,
                                  screenHeight: screenHeight * 0.0625,
                                  text: "Continue",
                                  onpressed: () async {
                                    if (index == 2) {
                                      cubit.diseases =
                                          diseaseController.selectedOptions
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
                                          cubit.height??0,
                                          cubit.weight??0,
                                          cubit.diseases??[],
                                          cubit.image);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => LoginScreen()));
                                    } else if (index == 0 &&
                                        formKey1.currentState!.validate()) {
                                      cubit.name = nameController.text;
                                      cubit.email = emailController.text;
                                      cubit.phoneNumber =
                                          int.parse(phoneController.text);
                                      print(
                                          "name=${cubit.name}\nemail=${cubit
                                              .email}\nnumber=${cubit
                                              .phoneNumber}");
                                      setState(() {
                                        index++;
                                      });
                                    } else if (index == 1 &&
                                        formKey2.currentState!.validate()) {
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
                                  textStyle: GoogleFonts.openSans(
                                      fontWeight: FontWeight.bold,
                                      fontSize: screenWidth * 0.04444,
                                      color: Colors.white)),
                              CustomButton(
                                  screenWidth: screenWidth * 0.35,
                                  screenHeight: screenHeight * 0.0625,
                                  text: "Back",
                                  onpressed: () {
                                    if (index <= 2 && index > 0) {
                                      setState(() {
                                        index--;
                                        print(index);
                                      });
                                    } else if (index == 0) {
                                      Navigator.pop(context);
                                    }
                                  },
                                  bColor: Color(0xffFAFAFA),
                                  borderColor: Color(0xff179BE8),
                                  textStyle: GoogleFonts.openSans(
                                      fontWeight: FontWeight.bold,
                                      fontSize: screenWidth * 0.04444,
                                      color: Color(0xff179BE8))),
                            ],
                          ),
                        );
                      })),
            ),
          ],
        ),
      ),
    );
  }
}




