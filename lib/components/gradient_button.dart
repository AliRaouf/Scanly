import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GradientButton extends StatelessWidget {
  const GradientButton({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
    required this.text,
    required this.onpressed,
    required this.fontSize,
    required this.border,
  });

  final double screenWidth;
  final double screenHeight;
  final String text;
  final void Function()? onpressed;
  final double fontSize;
  final double border;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth,
      height: screenHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(border),
        gradient: const LinearGradient(
          colors: [Color(0xff00D1FF), Color(0xff04657A)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: ElevatedButton(
        style: ButtonStyle(
            backgroundColor: const MaterialStatePropertyAll(Colors.transparent),
            shadowColor: const MaterialStatePropertyAll(Colors.transparent),
            shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(border)))),
        onPressed: onpressed,
        child: Text(
          text,
          style: GoogleFonts.nunito(color: const Color(0xfffafafa), fontSize: fontSize,fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}