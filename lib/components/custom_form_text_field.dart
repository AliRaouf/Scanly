import 'package:flutter/material.dart';


class CustomTextFormField extends StatefulWidget {
  String? hint;
  TextEditingController? controller;
  bool? obscureText;
  IconButton? icon;
  Icon? preIcon;
  Color? iconColor;
  String? Function(String?)? validate;
  bool readOnly;
  void Function()? onTap;
  TextInputType? type;

  CustomTextFormField(
      {super.key,
        this.type,
        required this.readOnly,
        required this.hint,
        this.controller,
        required this.obscureText,
        this.icon,
        this.iconColor,
        this.validate,
        this.onTap,
      this.preIcon});

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
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
    return TextFormField(
      keyboardType:widget.type,
      onTap:widget.onTap,
      readOnly: widget.readOnly,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: widget.controller,
      obscureText: widget.obscureText!,
      validator: widget.validate,
      decoration: InputDecoration(alignLabelWithHint: true,prefixIcon: widget.preIcon,prefixIconColor: Color(0xff179BE8),
          contentPadding:
          EdgeInsets.symmetric(vertical:screenWidth*0.03819444444 , horizontal: screenWidth*0.03819444444),
          hintText: widget.hint,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Color(0xff3DADA1))),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Color(0xff3DADA1))),
          suffixIcon: widget.icon,
          suffixIconColor: widget.iconColor,
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Color(0xff3DADA1))),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Color(0xff3DADA1)))),
    );
  }
}