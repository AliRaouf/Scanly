import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scanly/screens/home_screen.dart';
import 'package:scanly/screens/profile_screen.dart';

class AppBottomAppBar extends StatelessWidget {
  const AppBottomAppBar({
    required this.color,
    super.key,
  });

  final Color color;
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
        width: screenWidth * 0.9,
        height: screenHeight * 0.08,
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(30)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: screenWidth * 0.28,
              child: ElevatedButton(
                onPressed: () {
    Navigator.push(context,
    MaterialPageRoute(builder: (context) => const HomeScreen()));
                },
                style: const ButtonStyle(
                    backgroundColor:
                    MaterialStatePropertyAll(Colors.transparent),
                    elevation: MaterialStatePropertyAll(0)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(width: screenWidth*0.09,
                        child:
                      Image.asset("assets/images/test_icon.png")),
                    Text(
                      "Tests",
                      style: GoogleFonts.openSans(fontSize: screenWidth*0.0445,
                          color: const Color(0xff232425),
                          fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              width: screenWidth * 0.29,
              child: ElevatedButton(
                onPressed: () {},
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.transparent),
                  elevation: MaterialStatePropertyAll(0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(width: screenWidth*0.09,
                        child:
                        Image.asset("assets/images/history_icon.png")),
                    Text(
                      "History",
                      style: GoogleFonts.openSans(fontSize: screenWidth*0.0445,
                          color: const Color(0xff232425),
                          fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              width: screenWidth * 0.28,
              child: ElevatedButton(
                onPressed: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const ProfileScreen()));
                },
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.transparent),
                  elevation: MaterialStatePropertyAll(0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(width: screenWidth*0.0815,
                        child:
                        Image.asset("assets/images/profile_icon.png")),
                    Text(
                      "Profile",
                      style: GoogleFonts.openSans(fontSize: screenWidth*0.0445,
                          color: const Color(0xff232425),
                          fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              ),
            )
          ],
        ));
  }
}