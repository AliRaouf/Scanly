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
    final request = CompleteText(maxTokens: 2500,

        prompt:'''
User:
-Test: $userTest
-Gender: ${UserCubit.get(context).gender}
-Height: ${UserCubit.get(context).height} cm
-Weight: ${UserCubit.get(context).weight} kg
-Medical History: ${UserCubit.get(context).diseases!.join(', ')}
Instructions:
1. Firstly validate that the Test provided as an actual lab test (Blood, Genetic or Urine) if it is a lab test then proceed with the response if not return an empty response.
2. after validating the test i want you to make all the responses coming next firstly to take the User data into consideration then to be easily understandable and familiar with everyone.
3. interpret this test and diagnose it thoroughly explaining all the results of the user and add it to the diagnosis part then translate it and add it into diagnosis_ar in the json and recommend which doctor specialization should the user go to if needed based on the test above
4. After diagnosing the patient,Translate the diagnosis into Arabic and include it in the JSON at diagnosis_ar.
5. Recommend the appropriate doctor specialization based on the test results and add to Recommendation in the json.
6. Provide the date of the test in the format dd/MM/YYYY if you cant find a date return dd/MM/YYYY.
7. Only return the JSON at the end.
JSON Structure:
{
"diagnosis_en": Diagnose the patient concisely with clear understandable language (while explaining how you found out if anything is wrong) If the test values are within the reference range, explain what this means for the patient's health.
If the test values are outside the reference range, explain the possible implications for the patient's health.
"diagnosis_ar": same as diagnosis but translated to arabic
"healthScore": "from 1 to 10 the output should be only the number"
"Recommendation_en": recommend the user which doctor specialization they should go to.
"Recommendation_ar": same as Recommendation but in arabic
"Date":                  //dd/MM/YYYY Format         "Date of the test if there are multiple dates choose the earliest one"
}
Only return the json at the End.
''',
        model: Gpt3TurboInstruct(),
    );

    final response = await openAi.onCompletion(request: request);
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

