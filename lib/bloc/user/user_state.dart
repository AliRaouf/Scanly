part of 'user_cubit.dart';

@immutable
abstract class UserState {}

class UserInitial extends UserState {}
class GetUserDataState extends UserState {}
class ReceiveUserNameSuccessState extends UserState {}
class ReceiveUserNameLoadingState extends UserState {}
class ReceiveUserNameErrorState extends UserState {}
class PickFileLoading extends UserState {}
class PickFileSuccess extends UserState {}
class PickFileError extends UserState {}
class UserLogoutLoading extends UserState {}
class UserLogoutSuccess extends UserState {}
class UserLogoutError extends UserState {}
class ChangeUserPasswordSuccessState extends UserState {}
class ChangeUserPasswordLoadingState extends UserState {}
class ChangeUserPasswordErrorState extends UserState {}
class UpdateUserImageSuccess extends UserState {}
class UpdateUserImageFailure extends UserState {}
class UpdateUserDataSuccess extends UserState {}
class UpdateUserDataFailure extends UserState {}
class ReceiveTestLoading extends UserState {}
class ReceiveTestSuccess extends UserState {}
class ReceiveTestFailure extends UserState {}
class LoginLoadingState extends UserState {}
class LoginSuccessState extends UserState {}
class LoginErrorState extends UserState {
  final error;

  LoginErrorState(this.error);
}