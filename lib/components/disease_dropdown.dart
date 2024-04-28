import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

class DiseaseDropDown extends StatelessWidget {
  DiseaseDropDown({
    super.key,
    required this.diseaseController,
    required this.screenHeight,
  });

  final MultiSelectController diseaseController;
  final double screenHeight;
  List<ValueItem> chronicIllness = [
    const ValueItem(value: "none", label: "None"),
    const ValueItem(value: "Pressure", label: "HighBloodPressure"),
    const ValueItem(value: "Cholestrol", label: "High Cholestrol"),
    const ValueItem(value: "Arthritis", label: "Arthritis"),
    const ValueItem(
        value: "Heart Disease", label: "Ischemic/Coronary Heart Disease"),
    const ValueItem(value: "Diabetes", label: "Diabetes"),
    const ValueItem(
        value: "Chronic Kidney Disease", label: "Chronic Kidney Disease"),
    const ValueItem(value: "Heart Failure", label: "Heart Failure"),
    const ValueItem(value: "Breast cancer", label: "Breast cancer"),
    const ValueItem(value: "Alzheimer", label: "Alzheimer and Dementia"),
    const ValueItem(
        value: "COPD", label: "COPD (Chronic Obstructive Pulmonary Disease"),
    const ValueItem(value: "Stroke", label: "Stroke"),
    const ValueItem(value: "Lung cancer", label: "Lung cancer"),
    const ValueItem(value: "Colorectal cancer", label: "Colorectal cancer"),
    const ValueItem(value: "Cervical cancer", label: "Cervical cancer"),
    const ValueItem(value: "Hyperlipidaemia", label: "Hyperlipidaemia"),
    const ValueItem(value: "Prostate Cancer", label: "Prostate Cancer"),
    const ValueItem(value: "Liver Cancer", label: "Liver Cancer"),
  ];
  @override
  Widget build(BuildContext context) {
    return MultiSelectDropDown(
      alwaysShowOptionIcon: true,
      optionSeparator: Divider(),
      controller: diseaseController,
      selectedOptionTextColor: Color(0xff3DADA1),
      borderColor: Color(0xff3DADA1),
      focusedBorderColor: Color(0xff3DADA1),
      onOptionSelected: (options) {},
      options: chronicIllness,
      maxItems: 2,
      selectionType: SelectionType.multi,
      chipConfig: const ChipConfig(wrapType: WrapType.wrap),
      dropdownHeight: screenHeight * 0.4,
      optionTextStyle: GoogleFonts.nunito(fontSize: 16),
      selectedOptionIcon: const Icon(Icons.check_circle),
    );
  }
}
