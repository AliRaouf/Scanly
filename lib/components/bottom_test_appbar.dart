import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scanly/bloc/test/test_cubit.dart';
import 'package:scanly/screens/blood_screen.dart';
import 'package:scanly/screens/genetic_screen.dart';
import 'package:scanly/screens/urine_screen.dart';

class BottomTestAppBar extends StatelessWidget {
  const BottomTestAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      height: screenHeight * 0.1,
      width: screenWidth * 0.9,
      decoration: BoxDecoration(
          color: Color(0xffD9D9D9).withOpacity(0.4),
          borderRadius: BorderRadius.circular(30)),
      child: Padding(
        padding: EdgeInsets.all(screenWidth * 0.02546296296),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                width: screenWidth * 0.25,
                height: screenHeight * 0.08,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20)),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => BloodScreen()));
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll(Colors.transparent),
                    padding: MaterialStatePropertyAll(EdgeInsets.zero),
                    shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20))),
                    elevation: MaterialStatePropertyAll(0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                          width: screenWidth * 0.08,
                          child: Image.asset("assets/images/blood.png")),
                      Text(
                        "Blood",
                        style: GoogleFonts.openSans(
                            fontSize: screenWidth * 0.044442,
                            color: Color(0xff232425),
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                )),
            Container(
                width: screenWidth * 0.25,
                height: screenHeight * 0.08,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20)),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => GeneticScreen()));
                  },
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll(Colors.transparent),
                      padding: MaterialStatePropertyAll(EdgeInsets.zero),
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                      elevation: MaterialStatePropertyAll(0)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                          width: screenWidth * 0.08,
                          child: Image.asset("assets/images/gene.png")),
                      Text(
                        "Genetic",
                        style: GoogleFonts.openSans(
                            fontSize: screenWidth * 0.044442,
                            color: Color(0xff232425),
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                )),
            Container(
                width: screenWidth * 0.25,
                height: screenHeight * 0.08,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20)),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => UrineScreen()));
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll(Colors.transparent),
                    padding: MaterialStatePropertyAll(EdgeInsets.zero),
                    shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20))),
                    elevation: MaterialStatePropertyAll(0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                          width: screenWidth * 0.075,
                          margin: EdgeInsets.only(left: screenWidth * 0.02),
                          child: Image.asset("assets/images/urine.png")),
                      Text(
                        "Urine",
                        style: GoogleFonts.openSans(
                            fontSize: screenWidth * 0.04442,
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
