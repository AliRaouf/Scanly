import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'api_state.dart';

class ApiCubit extends Cubit<ApiState> {
  ApiCubit() : super(ApiInitial());
  static ApiCubit get(context) => BlocProvider.of(context);
  final openAi = OpenAI.instance.build(
      token: "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",
      baseOption: HttpSetup(receiveTimeout: const Duration(seconds: 10)),enableLog: true);
  Future<Map<String, dynamic>> getJSONFromPrompt(String userTest) async {
    final request = CompleteText(maxTokens: 2500,
      prompt: '''
      turn it into a json formatted like this while removing any extra nests or classifications i DON'T want any nests or Classifications:
{
  "Complete Blood Picture": {
    "Red Cell Count": {
      "value": 4.86,
      "type": "X10^12/L",
      "range": [4.5 , 5.5]
    },
    "Hemoglobin": {
      "value": 14,
      "type": "mU/L",
      "range": [13.0 , 17.0]
    },
    "Hematocrit": {
      "value": 41.6,
      "type": "%",
      "range": [40 , 50]
    },
    "MCV": {
      "value": 85.5,
      "type": "fL",
      "range": [80 , 100]
    },
    "MCH": {
      "value": 28.7,
      "type": "pg",
      "range": [27,32]
    },
    "MCHC": {
      "value": 33.6,
      "type": "g/dL",
      "range": [31.5 , 34.5]
    },
    "RDW": {
      "value": 16.1,
      "type": "%",
      "range": [11.5 , 14.5]
    },
    "Total Leucocyte Count": {
      "value": 6.39,
      "type": "X10^9/L",
      "range": [4.0 , 10.0]
    },
    "Neutrophils": {
      "value": 3.27,
      "type": "X10^9/L",
      "range": [2.0 , 7.0]
    },
    "Lymphocytes": {
      "value": 2.29,
      "type": "X10^9/L",
      "range": [1.0 , 3.5]
    },
    "Monocytes": {
      "value": 0.75,
      "type": "X10^9/L",
      "range": [0.2 , 1.0]
    },
    "Eosinophils": {
      "value": 0.07,
      "type": "X10^9/L",
      "range": [0.02 , 0.5]
    },
    "Basophils": {
      "value": 0,
      "type": "X10^9/L",
      "range": [0 , 0.1]
    },
    "Platelet Count": {
      "value": 275,
      "type": "X10^9/L",
      "range": [150 , 450]
    }
  },
}
Comment:
Recommendation:
}
 only showing the results of the test it self like the test name and the results inside showing the value , type and refrence range only while removing any Classifications like Differential Count or BloodTypes or Nests but add the items inside it just put the tests all below each other and stopping after the comment but at the end add a recommendation for health improvements as a recommend
      $userTest
      ''',
      model: Gpt3TurboInstruct(),
    );

    final response = await openAi.onCompletion(request: request);
    print(response);
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
