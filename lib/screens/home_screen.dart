import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scanly/bloc/user/user_cubit.dart';
import 'package:scanly/components/bottom_appbar.dart';
import 'package:scanly/components/custom_form_text_field.dart';
import 'package:scanly/components/gradient_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    List<String> tests = [
      "Cholestrol",
      "Blood Picture (CBP)",
      "Thyroid Test",
      "Urine Analysis",
      "AminoGram",
      "Anti MCV",
      "Genetic Test",
      "Serum Ferritin"
    ];
    var searchController = TextEditingController();
    var cubit = UserCubit.get(context);
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          body: Container(color: Color(0xff80c6dc),
            child: SafeArea(
              child: Container(
                width: screenWidth,
                height: screenHeight,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/Scanly_bg.png"),
                        fit: BoxFit.cover)),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal:screenWidth*0.05092592592),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: screenWidth*0.06111111111,
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
                              width: screenWidth * 0.2,
                            ),
                            Text(
                              "Welcome ${cubit.userName ?? ""}",
                              style: GoogleFonts.openSans(
                                  fontSize: screenWidth * 0.044442,
                                  color: Color(0xff232425),
                                  fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                      ),
                      Container(margin: EdgeInsets.symmetric(vertical: screenHeight*0.01),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        width: screenWidth * 0.6667,
                        child: CustomTextFormField(
                            controller: searchController,
                            icon: IconButton(
                                color: Color(0xff179BE8),
                                onPressed: () {},
                                icon: Icon(Icons.search_rounded)),
                            readOnly: false,
                            hint: "Search for a test",
                            obscureText: false),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: screenWidth*0.04583333333),
                            child: Text(
                              "Common Tests",
                              style: GoogleFonts.openSans(
                                  fontSize: screenWidth * 0.044442,
                                  color: Color(0xff232425),
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          Container(
                            height: screenHeight * 0.175,
                            width: screenWidth,
                            decoration: BoxDecoration(
                                color: Color(0xff1A83B6).withOpacity(0.25),
                                borderRadius: BorderRadius.circular(30)),
                            child: Padding(
                              padding: EdgeInsets.all(screenWidth*0.02546296296),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                      width: screenWidth * 0.25,
                                      height: screenHeight * 0.12,
                                      decoration: BoxDecoration(
                                          color: Color(0xfffafafa),
                                          borderRadius: BorderRadius.circular(20)),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          SizedBox(
                                              width: screenWidth * 0.163,
                                              child: Image.asset(
                                                  "assets/images/blood.png")),
                                          Text(
                                            "Blood",
                                            style: GoogleFonts.openSans(
                                                fontSize: screenWidth * 0.044442,
                                                color: Color(0xff232425),
                                                fontWeight: FontWeight.w600),
                                          )
                                        ],
                                      )),
                                  Container(
                                      width: screenWidth * 0.25,
                                      height: screenHeight * 0.12,
                                      decoration: BoxDecoration(
                                          color: Color(0xfffafafa),
                                          borderRadius: BorderRadius.circular(20)),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          SizedBox(
                                              width: screenWidth * 0.163,
                                              child: Image.asset(
                                                  "assets/images/gene.png")),
                                          Text(
                                            "Genetic",
                                            style: GoogleFonts.openSans(
                                                fontSize: screenWidth * 0.044442,
                                                color: Color(0xff232425),
                                                fontWeight: FontWeight.w600),
                                          )
                                        ],
                                      )),
                                  Container(
                                      width: screenWidth * 0.25,
                                      height: screenHeight * 0.12,
                                      decoration: BoxDecoration(
                                          color: Color(0xfffafafa),
                                          borderRadius: BorderRadius.circular(20)),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Container(
                                              width: screenWidth * 0.1583,
                                              margin: EdgeInsets.only(
                                                  left: screenWidth * 0.02),
                                              child: Image.asset(
                                                  "assets/images/urine.png")),
                                          Text(
                                            "Urine",
                                            style: GoogleFonts.openSans(
                                                fontSize: screenWidth * 0.04442,
                                                color: Color(0xff232425),
                                                fontWeight: FontWeight.w600),
                                          )
                                        ],
                                      )),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: screenHeight * 0.02,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 18.0),
                            child: Text(
                              "Tests",
                              style: GoogleFonts.openSans(
                                  fontSize: screenWidth * 0.044442,
                                  color: Color(0xff232425),
                                  fontWeight: FontWeight.w600),
                            ),
                          )
                        ],
                      ),
                      Container(
                        height: screenHeight * 0.45,
                        child: ListView.builder(
                            itemCount: tests.length,
                            padding: EdgeInsets.symmetric(
                                vertical: 4, horizontal: 16),
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 4),
                                child: Container(padding: EdgeInsets.symmetric(horizontal: 8),
                                  decoration: BoxDecoration(
                                      color: Color(0xfffafafa),
                                      borderRadius: BorderRadius.circular(10)),
                                  height: screenHeight * 0.05,
                                  width: screenWidth * 0.9,
                                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        tests[index],
                                        style: GoogleFonts.openSans(
                                            fontSize: screenWidth * 0.04,
                                            color: Color(0xff232425),
                                            fontWeight: FontWeight.w600),
                                      ),
                                      GradientButton(
                                          screenWidth: screenWidth * 0.2,
                                          screenHeight: screenHeight * 0.0375,
                                          text: "Scan",
                                          onpressed: (){
                                            print(MediaQuery.of(context).size.height);
                                            print(MediaQuery.of(context).size.width);
                                          },
                                          fontSize: screenWidth*0.033)
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ),Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: AppBottomAppBar(color: Color(0xffD9D9D9).withOpacity(0.6)),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
