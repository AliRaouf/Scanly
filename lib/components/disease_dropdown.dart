import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

import '../generated/l10n.dart';

class DiseaseDropDown extends StatelessWidget {
  DiseaseDropDown({
    super.key,
    required this.diseaseController,
    required this.screenHeight,
  });

  final MultiSelectController diseaseController;
  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    List<ValueItem> chronicIllness = [
      ValueItem(value: "none", label: S.of(context).non_MH),
      ValueItem(value: "HighBloodPressure", label: S.of(context).pressure),
      ValueItem(value: "Cholestrol", label:S.of(context).Cholestrol),
      ValueItem(value: "Arthritis", label: S.of(context).Arthritis),
      ValueItem(
          value: "Heart Disease", label: S.of(context).Heart_Disease),
      ValueItem(value: "Diabetes", label: S.of(context).Diabetes),
      ValueItem(
          value: "Chronic Kidney Disease", label: S.of(context).Chronic_Kidney_Disease),
      ValueItem(value: "Heart Failure", label: S.of(context).Heart_Failure),
      ValueItem(value: "Breast cancer", label: S.of(context).Breast_cancer),
      ValueItem(value: "Alzheimer", label: S.of(context).Alzheimer),
      ValueItem(
          value: "COPD", label: S.of(context).COPD),
      ValueItem(value: "Stroke", label: S.of(context).Stroke),
      ValueItem(value: "Lung cancer", label: S.of(context).Lung_cancer),
      ValueItem(value: "Colorectal cancer", label: S.of(context).Colorectal_cancer),
      ValueItem(value: "Cervical cancer", label: S.of(context).Cervical_cancer),
      ValueItem(value: "Hyperlipidaemia", label: S.of(context).Hyperlipidaemia),
      ValueItem(value: "Prostate Cancer", label: S.of(context).Prostate_Cancer),
      ValueItem(value: "Liver Cancer", label: S.of(context).Liver_Cancer),
    ];
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
      optionTextStyle: GoogleFonts.nunito(fontSize: 14.sp),
      selectedOptionIcon: const Icon(Icons.check_circle),
    );
  }
}
