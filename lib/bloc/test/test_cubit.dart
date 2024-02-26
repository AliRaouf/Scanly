import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'test_state.dart';

class TestCubit extends Cubit<TestState> {
  TestCubit() : super(TestInitial());
  static TestCubit get(context) => BlocProvider.of(context);
  List<String> tests = [
    "Cholestrol",
    "Blood Picture (CBP)",
    "Thyroid Test",
    "Urine Analysis",
    "AminoGram",
    "Anti MCV",
    "Genetic Test",
    "Serum Ferritin",
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
    'Rheumatoid Factor (RF)'
  ];
  List<String> bloodTests = [
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
  List<String> filteredTests = [];
  updateFilteredTests(String searchText) {
    filteredTests = searchText.isEmpty
        ? tests
        : tests.where((test) => test.toLowerCase().contains(searchText.toLowerCase())).toList();
  }
}
