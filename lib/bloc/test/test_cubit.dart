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
    "Cholestrol",
    'Complete Blood Count (CBC)',
    "Thyroid Test",
    "Urine Analysis",
    "AminoGram",
    "Anti MCV",
    "Genetic Test",
    "Serum Ferritin",
    'Basic Metabolic Panel (BMP)',
    'Comprehensive Metabolic Panel (CMP)',
    'Lipid Panel',
    'Thyroid-Stimulating Hormone (TSH)',
    'HbA1c test',
    'C-Reactive Protein (CRP)',
    'Prothrombin Time (PT)',
    'Liver Function Tests (LFTs)',
    'Electrolytes Panel',
    'Blood Glucose',
    'Vitamin B12 and Folate Levels',
    'Prostate-Specific Antigen (PSA)',
    'Blood Culture',
    'Human Immunodeficiency Virus (HIV)',
    'Hepatitis B and C',
    'Iron Studies',
    'Rheumatoid Factor (RF)',
    'Urinalysis',
    'Dipstick test',
    'Urine culture and sensitivity',
    'Microscopy',
    '24-hour urine collection', 'Carrier screening',
    'Prenatal genetic testing',
    'Chorionic villus sampling (CVS)',
    'Amniocentesis',
    'Newborn screening',
    'Non-invasive prenatal testing (NIPT)',
    'Cystic fibrosis (CF)',
    'Fragile X',
    'BRCA1 and BRCA2',
    'Alpha-fetoprotein (AFP)',
    'Karyotyping',
    'Whole genome sequencing (WGS)',
  ];
  List<String> bloodTests = [
    "Cholestrol",
    'Complete Blood Count (CBC)',
    'Basic Metabolic Panel (BMP)',
    'Comprehensive Metabolic Panel (CMP)',
    'Lipid Panel',
    'Thyroid-Stimulating Hormone (TSH) test',
    'HbA1c test',
    'C-Reactive Protein (CRP)',
    'Prothrombin Time (PT)',
    'Liver Function Tests (LFTs)',
    'Electrolytes Panel',
    'Blood Glucose',
    'Vitamin B12 and Folate Levels',
    'Prostate-Specific Antigen (PSA)'
        'Blood Culture',
    'Human Immunodeficiency Virus (HIV)',
    'Hepatitis B and C',
    'Iron Studies',
    'Rheumatoid Factor (RF)',
  ];

  List<String> urineTests = [
    'Urinalysis',
    'Dipstick test',
    'Urine culture and sensitivity',
    'Microscopy',
    '24-hour urine collection',
  ];
  List<String> geneticTests = [
    'Carrier screening',
    'Prenatal genetic testing',
    'Chorionic villus sampling (CVS)',
    'Amniocentesis',
    'Newborn screening',
    'Non-invasive prenatal testing (NIPT)',
    'Cystic fibrosis (CF)',
    'Fragile X',
    'BRCA1 and BRCA2',
    'Alpha-fetoprotein (AFP)',
    'Karyotyping',
    'Whole genome sequencing (WGS)',
  ];
  List<String> filteredTests = [];

  updateFilteredTests(String searchText) {
    filteredTests = searchText.isEmpty
        ? tests
        : tests.where((test) =>
        test.toLowerCase().contains(searchText.toLowerCase())).toList();
  }

   saveTest(BuildContext context,Map<String, dynamic> test) {
    emit(SaveTestLoading());
    try {
      FirebaseFirestore.instance
          .collection("tests")
          .doc(UserCubit
          .get(context)
          .user!
          .email)
          .collection("userTest")
          .add(
          test
      );
      print('Test entry added for ${UserCubit
          .get(context)
          .user!
          .email}');
      emit(SaveTestSuccess());
    } catch (e) {
      print('Error adding Test entry: $e');
      emit(SaveTestError());
    }
  }

  receiveTestList(BuildContext context) {
    emit(ReceiveTestLoading());
    try {
      testStream = FirebaseFirestore.instance
          .collection('nutrition')
          .doc(UserCubit
          .get(context)
          .user!
          .email)
          .collection('TestLog')
          .snapshots();
      emit(ReceiveTestSuccess());
      print("Test Received Successfully");
      print(testStream!.length);
    } on Exception catch (e) {
      print('Error receiving Test entry: $e');
      emit(ReceiveTestError());
    }
  }

  Future<String> uploadImage(Uint8List file, BuildContext context) async {
    String imgName = "${DateTime
        .now()
        .microsecondsSinceEpoch
        .toString()
    },${UserCubit
        .get(context)
        .user!.email}";
    Reference ref = FirebaseStorage.instance.ref('userTests').child(
        imgName);
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }
  Future<String> uploadPdf(File file, BuildContext context) async {
    String imgName = "${DateTime
        .now()
        .microsecondsSinceEpoch
        .toString()
    },${UserCubit
        .get(context)
        .userEmail}";
    Reference ref = FirebaseStorage.instance.ref('userTests').child(
        imgName);
    UploadTask uploadTask = ref.putData(file.readAsBytesSync());
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }
}
