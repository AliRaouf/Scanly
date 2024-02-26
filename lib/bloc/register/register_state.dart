part of 'register_cubit.dart';

@immutable
abstract class RegisterState {}

class RegisterInitial extends RegisterState {}
class RegisterUserLoading extends RegisterState {}
class RegisterUserSuccess extends RegisterState {}
class RegisterUserError extends RegisterState {}
class SaveUserLoadingState extends RegisterState {}
class SaveUserSuccessState extends RegisterState {}
class SaveUserErrorState extends RegisterState {}
