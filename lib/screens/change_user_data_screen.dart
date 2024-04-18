import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scanly/components/custom_button.dart';
import 'package:scanly/components/custom_form_text_field.dart';
import 'package:scanly/screens/login_screen.dart';
import '../bloc/user/user_cubit.dart';
import '../components/custom_page_route.dart';
import '../components/gradient_button.dart';

class ChangeUserDataScreen extends StatefulWidget {
  const ChangeUserDataScreen({super.key});

  @override
  State<ChangeUserDataScreen> createState() => _ChangeUserDataScreenState();
}

class _ChangeUserDataScreenState extends State<ChangeUserDataScreen> {
  var oldPasswordController = TextEditingController();
  var newPasswordController = TextEditingController();
  var confirmNewPasswordController = TextEditingController();
  late MemoryImage? _selectedImage;

  @override
  Widget build(BuildContext context) {
    var cubit = UserCubit.get(context);
    var nameController = TextEditingController(text: cubit.userName);
    var heightController = TextEditingController(text: "${cubit.height}");
    var weightController = TextEditingController(text: "${cubit.weight}");
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {
      if (state is UpdateUserDataSuccess || state is UpdateUserImageSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Data Changed Successfully")));
        Navigator.pushReplacement(
            context,
            AnimatedRoute(page: LoginScreen()));
      }else if (state is UpdateUserDataFailure || state is UpdateUserDataFailure) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Failed To Change Data")));
      }
      },
      builder: (context, state) {
        return Scaffold(
            backgroundColor: Color(0xfffafafa),
            body: ListView(
              children: [
                Stack(
                  children: [
                    Container(
                      height: 300.h,
                      width: 1.sw,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 12.w, vertical: 10.h),
                        child: Column(
                          children: [
                            Text(
                              "Change your Data",
                              style: GoogleFonts.nunito(
                                  fontSize: 22.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff232425)),
                            ),
                            Text(
                              "Choose a new Profile Picture",
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
                                        backgroundImage:
                                            NetworkImage(cubit.imageUrl),
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
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.h, horizontal: 30.w),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "UserName",
                            style: GoogleFonts.nunito(
                                fontSize: 14.sp, color: Color(0xff232425)),
                          ),
                        ],
                      ),
                      CustomTextFormField(
                        controller: nameController,
                        readOnly: false,
                        hint: "UserName",
                        obscureText: false,
                        preIcon: Icon(Icons.person_outline),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.h, horizontal: 30.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: .35.sw,
                        child: Column(
                          children: [
                            Text(
                              "Height",
                              style: GoogleFonts.nunito(
                                  fontSize: 14.sp, color: Color(0xff232425)),
                            ),
                            CustomTextFormField(type: TextInputType.number,
                                controller: heightController,
                                preIcon: Icon(Icons.height_rounded),
                                readOnly: false,
                                hint: "Height",
                                obscureText: false)
                          ],
                        ),
                      ),
                      Container(
                        width: .35.sw,
                        child: Column(
                          children: [
                            Text(
                              "Weight",
                              style: GoogleFonts.nunito(
                                  fontSize: 14.sp, color: Color(0xff232425)),
                            ),
                            CustomTextFormField(type: TextInputType.number,
                                controller: weightController,
                                preIcon: Icon(Icons.monitor_weight_outlined),
                                readOnly: false,
                                hint: "Weight",
                                obscureText: false)
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: .1.sh,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CustomButton(
                        textStyle: GoogleFonts.nunito(
                            fontSize: 14.sp, color: Color(0xff1A83B6),fontWeight:FontWeight.w600),
                        screenWidth: .3.sw,
                        screenHeight: .065.sh,
                        text: "Close",
                        onpressed: () {
                          Navigator.pop(context);
                        },
                        bColor: Color(0xfffafafa),
                        borderColor: Color(0xff1A83B6)),
                    GradientButton(
                      screenWidth: .3.sw,
                      screenHeight: .065.sh,
                      text: 'Save',
                      onpressed: () async {
                        if (cubit.image != null) {
                          String imageUrl = await cubit.uploadImage(
                              cubit.image!, cubit.user!.email);
                          cubit.updateUserImage(imageUrl);
                          await cubit.updateUserData(nameController.text, int.parse(heightController.text), int.parse(weightController.text));
                          cubit.logout();
                        }else{
                          print("else");
                          await cubit.updateUserData(nameController.text, int.parse(heightController.text), int.parse(weightController.text));
                          cubit.logout();
                        }
                      },
                      fontSize: 18.sp,
                      border: 30,
                    ),
                  ],
                )
              ],
            ));
      },
    );
  }
}
