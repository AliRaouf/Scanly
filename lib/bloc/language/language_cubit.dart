import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:scanly/model/language_enums.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../generated/l10n.dart';

part 'language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  LanguageCubit() : super(LanguageInitial());
  static LanguageCubit get(context) => BlocProvider.of(context);
  languageFunction(LanguageEnums eventType)async{
    final prefs = await SharedPreferences.getInstance();
    switch (eventType){
      case LanguageEnums.InitialLanguage:
        if(prefs.getString("lang") != null){
          if(prefs.getString("lang") =='ar'){
            emit(LanguageChange(languageCode: 'ar'));
          }else{
            emit(LanguageChange(languageCode: 'en'));
          }
        }
        break;
      case LanguageEnums.ArabicLanguage:
        prefs.setString('lang', 'ar');
        emit(LanguageChange(languageCode: 'ar'));
        break;
      case LanguageEnums.EnglishLanguage:
        prefs.setString('lang', 'en');
        emit(LanguageChange(languageCode: 'en'));
        break;
    }
  }
  Map<String, String> LocaleNames = {
    'en': 'English',
    'ar': 'العربية',
  };
  Future<void> showLanguageDialog(BuildContext context) async {
    String? selectedLanguageCode = await showDialog<String>(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: Text(S.of(context).change_language),
          children: [
            SimpleDialogOption(
              child: Text(LocaleNames['en'] ?? 'Unknown'),
              onPressed: () => Navigator.pop(context, 'en'),
            ),
            SimpleDialogOption(
              child: Text(LocaleNames['ar'] ?? 'Unknown'),
              onPressed: () => Navigator.pop(context, 'ar'),
            ),
          ],
        );
      },
    );

    if (selectedLanguageCode != null) {
      if(selectedLanguageCode=="ar"){
        LanguageCubit.get(context).languageFunction(LanguageEnums.ArabicLanguage);
      }else{
        LanguageCubit.get(context).languageFunction(LanguageEnums.EnglishLanguage);
      }
    }
  }
}
