import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:scanly/bloc/user/user_cubit.dart';

part 'test_state.dart';

class TestCubit extends Cubit<TestState> {
  TestCubit() : super(TestInitial());

  static TestCubit get(context) => BlocProvider.of(context);
  Stream? testStream;
  List<String> tests = [
    "CBC (Complete Blood Count)",
    "Lipid profile",
    "Uric acid",
    "Parathyroid hormone (pth)",
    "Vitamin D",
    "Fasting blood sugar",
    "Tsh",
    "T3 total and free",
    "T4 total and free",
    "Calcium total",
    "Calcium ionized",
    "Magnesium",
    "Favism (G6PD deficiency test)",
    "Glucose after 2 hours",
    "HbA1c",
    "Serum Iron",
    "Ferritin",
    "TIBC (Total Iron Binding Capacity)",
    "Transferrin saturation",
    "PT (Prothrombin Time)",
    "PTT (Partial Thromboplastin Time)",
    "Bleeding time",
    "Clotting time",
    "AST (SGOT)",
    "ALT (SGPT)",
    "Bilirubin",
    "Albumin",
    "Total protein",
    "Alkaline phosphatase",
    "Creatinine",
    "Blood urea",
    "Uric acid",
    "BUN",
    "Sodium",
    "Potassium",
    "CRP (C-Reactive Protein)",
    "ESR (Erythrocyte Sedimentation Rate)",
    'Urinalysis',
    "Thalassemia",
    "FMF (Familial Mediterranean Fever)",
    "Karyotyping"
  ];
  List<String> tests_ar = [
    "CBC (تعداد الدم الكامل)",
    "ملف الدهون",
    "حمض البوليك",
    "هرمون الغدة الدرقية (pth)",
    "فيتامين د",
    "سكر الدم الصائم",
    "Tsh",
    "T3 إجمالي وخالي",
    "T4 إجمالي وخالي",
    "إجمالي الكالسيوم",
    "الكالسيوم المتأين",
    "المغنيسيوم",
    "Favism (اختبار نقص G6PD)",
    "الجلوكوز بعد ساعتين",
    "HbA1c",
    "حديد المصل",
    "الفيريتين",
    "TIBC (إجمالي سعة ربط الحديد)",
    "تشبع الترانسفيرين",
    "PT (زمن البروثرومبين)",
    "PTT (وقت الثرومبوبلاستين الجزئي)",
    "وقت النزيف",
    "وقت التخثر",
    "AST (SGOT)",
    "ALT (SGPT)",
    "البيليروبين",
    "الألبومين",
    "البروتين الكلي",
    "الفوسفاتيز القلوي",
    "الكرياتينين",
    "يوريا الدم",
    "حمض اليوريك",
    "BUN",
    "الصوديوم",
    "البوتاسيوم",
    "CRP (بروتين سي التفاعلي)",
    "ESR (معدل ترسيب كرات الدم الحمراء)",
    "تحليل البول",
    "الثلاسيميا",
    "FMF (حمى البحر الأبيض المتوسط)",
    "التنميط النووي"
  ];
  List<String> bloodTests = [
    "Parathyroid hormone (pth)",
    "Tsh",
    "T3 total and free",
    "T4 total and free",
    "Vitamin D",
    "Calcium total",
    "Calcium ionized",
    "Magnesium",
    "Favism (G6PD deficiency test)",
    "Fasting blood sugar",
    "Glucose after 2 hours",
    "HbA1c",
    "Lipid profile",
    "Serum Iron",
    "Ferritin",
    "TIBC (Total Iron Binding Capacity)",
    "Transferrin saturation",
    "CBC (Complete Blood Count)",
    "PT (Prothrombin Time)",
    "PTT (Partial Thromboplastin Time)",
    "Bleeding time",
    "Clotting time",
    "AST (SGOT)",
    "ALT (SGPT)",
    "Bilirubin",
    "Albumin",
    "Total protein",
    "Alkaline phosphatase",
    "Creatinine",
    "Blood urea",
    "Uric acid",
    "BUN",
    "Sodium",
    "Potassium",
    "CRP (C-Reactive Protein)",
    "ESR (Erythrocyte Sedimentation Rate)"
  ];
  List<String> bloodTests_ar = [
    "هرمون الغدة الدرقية (pth)",
    "Tsh",
    "T3 إجمالي وخالي",
    "T4 إجمالي وخالي",
    "فيتامين د",
    "إجمالي الكالسيوم",
    "الكالسيوم المتأين",
    "المغنيسيوم",
    "Favism (اختبار نقص G6PD)",
    "سكر الدم الصائم",
    "الجلوكوز بعد ساعتين",
    "HbA1c",
    "ملف الدهون",
    "حديد المصل",
    "الفيريتين",
    "TIBC (إجمالي سعة ربط الحديد)",
    "تشبع الترانسفيرين",
    "CBC (تعداد الدم الكامل)",
    "PT (زمن البروثرومبين)",
    "PTT (وقت الثرومبوبلاستين الجزئي)",
    "وقت النزيف",
    "وقت التخثر",
    "AST (SGOT)",
    "ALT (SGPT)",
    "البيليروبين",
    "الألبومين",
    "البروتين الكلي",
    "الفوسفاتيز القلوي",
    "الكرياتينين",
    "يوريا الدم",
    "حمض اليوريك",
    "BUN",
    "الصوديوم",
    "البوتاسيوم",
    "CRP (بروتين سي التفاعلي)",
    "ESR (معدل ترسيب كرات الدم الحمراء)"
  ];

  List<String> urineTests = [
    'Urinalysis',
    "Uric acid",
  ];
  List<String> geneticTests = [
    "Thalassemia",
    "FMF (Familial Mediterranean Fever)",
    "Karyotyping"
  ];
  List<String> filteredTests = [];

  updateFilteredTests(String searchText, List<String> tests) {
    filteredTests = searchText.isEmpty
        ? tests
        : tests
            .where(
                (test) => test.toLowerCase().contains(searchText.toLowerCase()))
            .toList();
  }

  saveTest(BuildContext context, Map<String, dynamic> test) {
    emit(SaveTestLoading());
    try {
      FirebaseFirestore.instance
          .collection("tests")
          .doc(UserCubit.get(context).user!.email)
          .collection("userTest")
          .add(test);
      emit(SaveTestSuccess());
    } catch (e) {
      emit(SaveTestError());
    }
  }

  // receiveTestList(BuildContext context) {
  //   emit(ReceiveTestLoading());
  //   try {
  //     testStream = FirebaseFirestore.instance
  //         .collection('nutrition')
  //         .doc(UserCubit.get(context).user!.email)
  //         .collection('TestLog')
  //         .snapshots();
  //     emit(ReceiveTestSuccess());
  //     print("Test Received Successfully");
  //     print(testStream!.length);
  //   } on Exception catch (e) {
  //     print('Error receiving Test entry: $e');
  //     emit(ReceiveTestError());
  //   }
  // }

  Future<String> uploadImage(Uint8List file, BuildContext context) async {
    String imgName =
        "${DateTime.now().microsecondsSinceEpoch.toString()},${UserCubit.get(context).user!.email}.Image";
    Reference ref = FirebaseStorage.instance.ref('userTests').child(imgName);
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<String> uploadPdf(File file, BuildContext context) async {
    String imgName =
        "${DateTime.now().microsecondsSinceEpoch.toString()},${UserCubit.get(context).userEmail}.Document";
    Reference ref = FirebaseStorage.instance.ref('userTests').child(imgName);
    UploadTask uploadTask = ref.putFile(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  String extractTestName(Map<String, dynamic> tests) {
    String? testName;
    var keys = tests.keys.toList();
    for (int i = 0; i < keys.length; i++) {
      if (keys[i] != "Comment" &&
          keys[i] != "Date" &&
          keys[i] != "Explanation" &&
          keys[i] != "Recommendation" &&
          keys[i] != "healthScore" &&
          keys[i] != "image" &&
          keys[i] != "uploadDate") {
        testName = keys[i];
      }
    }
    return testName ?? "Not Visible";
  }

  Future<Uint8List?> captureImage(screenshotController) async {
    final image = await screenshotController.capture();
    return image;
  }
  List<String> geneticTests_ar = [
    "الثلاسيميا",
    "FMF (حمى البحر الأبيض المتوسط)",
    "التنميط النووي"
  ];
  List<String> urineTests_ar = [
    "تحليل البول",
    "حمض البوليك",
  ];
}
