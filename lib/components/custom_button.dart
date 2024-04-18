import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  CustomButton(
      {super.key,
      this.textStyle,
      required this.screenWidth,
      required this.screenHeight,
      required this.text,
      required this.onpressed,
      required this.bColor,
      this.sColor,
      required this.borderColor});

  final double screenWidth;
  final double screenHeight;
  final String text;
  final Function() onpressed;
  final Color bColor;
  Color? sColor;
  final Color borderColor;
  TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth,
      height: screenHeight,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: borderColor)),
      child: ElevatedButton(
        style: ButtonStyle(elevation: MaterialStatePropertyAll(0),
            side: MaterialStatePropertyAll(
                BorderSide(color: sColor ?? Colors.transparent)),
            backgroundColor: MaterialStatePropertyAll(bColor),
            shadowColor: const MaterialStatePropertyAll(Colors.transparent),
            shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30)))),
        onPressed: onpressed,
        child: Text(text, style: textStyle),
      ),
    );
  }
}
