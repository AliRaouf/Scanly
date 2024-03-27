
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scanly/bloc/test/test_cubit.dart';
import 'package:scanly/components/bottom_test_appbar.dart';
import 'package:scanly/components/scan_bottomsheet_popup.dart';
import 'package:scanly/screens/home_screen.dart';

import '../bloc/user/user_cubit.dart';
import '../components/gradient_button.dart';

class GeneticScreen extends StatefulWidget {
  const GeneticScreen({super.key});

  @override
  State<GeneticScreen> createState() => _GeneticScreenState();
}

class _GeneticScreenState extends State<GeneticScreen> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    var cubit = TestCubit.get(context);
    var uCubit = UserCubit.get(context);
    return BlocConsumer<TestCubit, TestState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return PopScope(canPop:
        false,
          child: Scaffold(
            body: Container(
                  width: screenWidth,
                  height: screenHeight,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/Scanly_bg.png"),
                          fit: BoxFit.cover)),
                  child: Column(mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          Row(
                            children: [
                              IconButton(
                                  color: const Color(0xff232425),
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                HomeScreen())
                                    );
                                  },
                                  icon: const Icon(Icons.arrow_back_ios_new_outlined)),],),
                          Center(
                            child: Text("Genetic",style: GoogleFonts.montserrat(
                                fontSize: screenWidth * 0.06,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xff232425)),),
                          ),
                        ],
                      ),
                      Container(
                        height: screenHeight * 0.78,
                        child: ListView.builder(
                            itemCount: cubit.geneticTests.length,
                            padding: EdgeInsets.symmetric(
                                vertical: 4, horizontal: 16),
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                const EdgeInsets.symmetric(vertical: 4),
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 8,vertical: 8),
                                  decoration: BoxDecoration(
                                      color: Color(0xfffafafa),
                                      borderRadius: BorderRadius.circular(10)),
                                  height: screenHeight * 0.05,
                                  width: screenWidth * 0.9,
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          cubit.geneticTests[index],
                                          style: GoogleFonts.openSans(
                                              fontSize: screenWidth * 0.04,
                                              color: Color(0xff232425),
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      BlocBuilder<UserCubit, UserState>(
                                        builder: (context, state) {
                                          return GradientButton(
                                            screenWidth: screenWidth * 0.2,
                                            screenHeight: screenHeight * 0.0375,
                                            text: "Scan",
                                            onpressed: () {
                                              uCubit.pickedFile = null;
                                              showModalBottomSheet(
                                                  context: context,
                                                  builder: (context) {
                                                    return ScanBottomSheetPopup(testName: TestCubit.get(
                                                        context)
                                                        .geneticTests[index]);
                                                  });
                                            },
                                            fontSize: screenWidth * 0.033,
                                            border: 6,
                                          );
                                        },
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ),
                      Padding(
                        padding: EdgeInsets.all(screenWidth*0.02430555555),
                        child: BottomTestAppBar(),
                      )
                    ],
                  ),
                )),
          );
      },
    );
  }
}
