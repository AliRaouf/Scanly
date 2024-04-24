part of 'test_cubit.dart';

@immutable
abstract class TestState {}

class TestInitial extends TestState {}
class SaveTestLoading extends TestState {}
class SaveTestSuccess extends TestState {}
class SaveTestError extends TestState {}
class ReceiveTestLoading extends TestState {}
class ReceiveTestSuccess extends TestState {}
class ReceiveTestError extends TestState {}