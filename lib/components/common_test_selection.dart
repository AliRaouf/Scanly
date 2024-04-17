import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../screens/common_test_tab_view.dart';
import '../screens/genetic_screen.dart';
import '../screens/urine_screen.dart';

class CommonTestSelection extends StatelessWidget {
  const CommonTestSelection({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
  });

  final double screenHeight;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenHeight * 0.175,
      width: screenWidth,
      decoration: BoxDecoration(
          color: Color(0xff1A83B6).withOpacity(0.25),
          borderRadius: BorderRadius.circular(30)),
      child: Padding(
        padding:
        EdgeInsets.all(screenWidth * 0.02546296296),
        child: Row(
          mainAxisAlignment:
          MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              child: Container(
                  width: screenWidth * 0.25,
                  height: screenHeight * 0.12,
                  decoration: BoxDecoration(
                      color: Color(0xfffafafa),
                      borderRadius:
                      BorderRadius.circular(20)),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  CommonTestTabView(index: 0)));
                    },
                    style: ButtonStyle(
                        padding: MaterialStatePropertyAll(
                            EdgeInsets.zero),
                        shape: MaterialStatePropertyAll(
                            RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(
                                    20))),
                        elevation:
                        MaterialStatePropertyAll(0),
                        backgroundColor:
                        MaterialStatePropertyAll(
                            Color(0xfffafafa))),
                    child: Column(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: SizedBox(
                              width: screenWidth * 0.163,
                              child: Image.asset(
                                  "assets/images/blood.png")),
                        ),
                        Text(
                          "Blood",
                          style: GoogleFonts.nunito(
                              fontSize:
                              screenWidth * 0.044442,
                              color: Color(0xff232425),
                              fontWeight:
                              FontWeight.w600),
                        )
                      ],
                    ),
                  )),
            ),
            Container(
                width: screenWidth * 0.25,
                height: screenHeight * 0.12,
                decoration: BoxDecoration(
                    color: Color(0xfffafafa),
                    borderRadius:
                    BorderRadius.circular(20)),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                CommonTestTabView(index: 1)));
                  },
                  style: ButtonStyle(
                      padding: MaterialStatePropertyAll(
                          EdgeInsets.zero),
                      shape: MaterialStatePropertyAll(
                          RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(
                                  20))),
                      elevation:
                      MaterialStatePropertyAll(0),
                      backgroundColor:
                      MaterialStatePropertyAll(
                          Color(0xfffafafa))),
                  child: Column(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: SizedBox(
                            width: screenWidth * 0.163,
                            child: Image.asset(
                                "assets/images/gene.png")),
                      ),
                      Text(
                        "Genetic",
                        style: GoogleFonts.nunito(
                            fontSize:
                            screenWidth * 0.044442,
                            color: Color(0xff232425),
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                )),
            Container(
                width: screenWidth * 0.25,
                height: screenHeight * 0.12,
                decoration: BoxDecoration(
                    color: Color(0xfffafafa),
                    borderRadius:
                    BorderRadius.circular(20)),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                CommonTestTabView(index: 2)));
                  },
                  style: ButtonStyle(
                      padding: MaterialStatePropertyAll(

                          EdgeInsets.zero),
                      shape: MaterialStatePropertyAll(
                          RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(
                                  20))),
                      elevation:
                      MaterialStatePropertyAll(0),
                      backgroundColor:
                      MaterialStatePropertyAll(
                          Color(0xfffafafa))),
                  child: Column(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: Container(
                            width: screenWidth * 0.1583,
                            margin: EdgeInsets.only(
                                left: screenWidth * 0.02),
                            child: Image.asset(
                                "assets/images/urine.png")),
                      ),
                      Text(
                        "Urine",
                        style: GoogleFonts.nunito(
                            fontSize:
                            screenWidth * 0.04442,
                            color: Color(0xff232425),
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}