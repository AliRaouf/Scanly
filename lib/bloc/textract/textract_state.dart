part of 'textract_cubit.dart';

@immutable
abstract class TextractState {}

class TextractInitial extends TextractState {}
class UploadImageLoading extends TextractState {}
class UploadImageSuccess extends TextractState {}
class UploadImageError extends TextractState {}
class TextReceivedSuccessfullyState extends TextractState {}
