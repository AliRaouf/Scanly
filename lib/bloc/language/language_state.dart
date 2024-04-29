part of 'language_cubit.dart';

@immutable
abstract class LanguageState {}

class LanguageInitial extends LanguageState {}
class LanguageChange extends LanguageState {
  final String? languageCode;
  LanguageChange({this.languageCode});
}
