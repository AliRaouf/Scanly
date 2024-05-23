import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  static LoginCubit get(context) => BlocProvider.of(context);
  String? emailText;
  String? passwordText;
  bool isChecked = false;
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  String? error;
  bool? isExist;

  String? validateEmail(String? value) {
    const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
    final regex = RegExp(pattern);

    return value!.isEmpty || !regex.hasMatch(value)
        ? 'Enter a valid email address'
        : null;
  }
  handleRemeberme(String email, String password) {
    if (isChecked == true) {
      SharedPreferences.getInstance().then(
        (prefs) {
          prefs.setBool("remember_me", isChecked);
          prefs.setString('email', email);
          prefs.setString('password', password);
        },
      );
    } else if (isChecked == false) {
      SharedPreferences.getInstance().then(
        (prefs) {
          prefs.setBool("remember_me", isChecked);
          prefs.setString('email', '');
          prefs.setString('password', '');
        },
      );
    }
  }

  loadUserEmailPassword() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var email = prefs.getString("email") ?? "";
      var password = prefs.getString("password") ?? "";
      var rememberMe = prefs.getBool("remember_me") ?? false;
      if (rememberMe) {
        emailText = email;
        passwordText = password;
        isChecked = rememberMe;
      }
    } catch (e) {
    }
  }



doesEmailExist(String email) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    QuerySnapshot querySnapshot = await users.where('email', isEqualTo: email).get();
    isExist=querySnapshot.docs.isNotEmpty;

  }
  Future resetUserPassword(String email)async{
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    emit(resetUserPasswordState());
  }
}
