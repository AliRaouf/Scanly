import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../user/user_cubit.dart';

part 'api_state.dart';

class ApiCubit extends Cubit<ApiState> {
  ApiCubit() : super(ApiInitial());
  String? modelPath;
  static ApiCubit get(context) => BlocProvider.of(context);
  final openAi = OpenAI.instance.build(
      token: "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",
      baseOption: HttpSetup(receiveTimeout: const Duration(seconds: 60)),enableLog: true);
  Future<Map<String, dynamic>> getJSONFromPrompt(String userTest,String testName,BuildContext context,String userTest_ar) async {
    final prefs = await SharedPreferences.getInstance();
    print(prefs.getString('lang'));
    final request = CompleteText(maxTokens: 2500,

      prompt:'''
      if the test provided below isn't a ($testName) lab test document Return Empty Values in all the JSON KEYS
      if you cant give a proper diagnosis or understanding return Null values in the JSON.
      if you cant find a date format in the text return dd/MM/YYYY
 Test: $userTest
 gender : ${UserCubit.get(context).gender}
 height : ${UserCubit.get(context).height}Cm
 weight : ${UserCubit.get(context).weight}Kg
 medical history : ${UserCubit.get(context).diseases!.join(', ')}
  interpret this test and diagnose it thoroughly and add it to the explanation and translate it and add it into explanation_ar in the json and recommend which doctor specialization should the user go to if needed based on the test above
extract the testName and add it to the JSON
DON'T RETURN AN EXPLANATION OF THE TEST IT SELF RETURN EXPLANATION OF THE RESULTS OF THE TEST ABOVE THOROUGHLY and CONCISELY!
{
"testName": $testName
"testName_ar":$userTest_ar
"diagnosis_en": Diagnose the patient concisely with clear understandable language (while explaining how you found out if anything is wrong) If the test values are within the reference range, explain what this means for the patient's health.
If the test values are outside the reference range, explain the possible implications for the patient's health.
"diagnosis_ar": same as diagnosis but translated to arabic
"healthScore": "from 1 to 10 the output should be only the number"
"Recommendation_en":
"Recommendation_ar": same as Recommendation but in arabic
"Date":                  //dd/MM/YYYY Format         "Date of the test if there are multiple dates choose the earliest one"
}
only return the json at the end.
      ''',
      model: Gpt3TurboInstruct(),
    );

    final response = await openAi.onCompletion(request: request);
    print("$response");
    return jsonDecode(response!.choices[0].text);
  }
  List<MapEntry<String, Map<String, dynamic>>> getNestedKeyValuePairs(
      Map<String, dynamic> data) {
    List<MapEntry<String, Map<String, dynamic>>> nestedKeyValuePairs = [];

    data.forEach((key, value) {
      if (value is Map<String, dynamic>) {
        value.forEach((nestedKey, nestedValue) {
          if (nestedValue is Map<String, dynamic>) {
            nestedKeyValuePairs.add(MapEntry(nestedKey, nestedValue));
          }
        });
      }
    });

    return nestedKeyValuePairs;
  }
    }

