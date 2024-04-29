import 'package:flutter/material.dart';
import '../generated/l10n.dart';

class GenderDropDown extends StatelessWidget {
 GenderDropDown({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
    required this.genderController,
  });

  final double screenWidth;
  final double screenHeight;
  final TextEditingController genderController;

  @override
  Widget build(BuildContext context) {
    List<DropdownMenuEntry<String>> genders = [
      DropdownMenuEntry(value: S.of(context).male, label: S.of(context).male),
      DropdownMenuEntry(value: S.of(context).female, label: S.of(context).female),
    ];
    return DropdownMenu<String>(
        width: screenWidth * 0.8,
        inputDecorationTheme:
        InputDecorationTheme(
          constraints: BoxConstraints(
              maxHeight:
              screenHeight * 0.075),
          contentPadding:
          const EdgeInsets.symmetric(
              horizontal: 10),
          focusedBorder: OutlineInputBorder(
              borderRadius:
              BorderRadius.circular(10),
              borderSide: const BorderSide(
                  color:
                  Color(0xff3DADA1))),
          enabledBorder: OutlineInputBorder(
              borderRadius:
              BorderRadius.circular(10),
              borderSide: const BorderSide(
                  color:
                  Color(0xff3DADA1))),
        ),
        controller: genderController,
        dropdownMenuEntries: genders,
        onSelected: (value) {
          genderController.text = value!;
          print(genderController.text);
        });
  }
}