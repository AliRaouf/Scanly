import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

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
          print("success");
        },
      );
    } else if (isChecked == false) {
      SharedPreferences.getInstance().then(
        (prefs) {
          prefs.setBool("remember_me", isChecked);
          prefs.setString('email', '');
          prefs.setString('password', '');
          print("success 0");
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
      print(e);
    }
  }

  Future<User?> googleSignin() async {
    try {
      final googleSignIn = GoogleSignIn(scopes: ['email']);

      // Sign out the user to ensure they can choose an account each time
      await googleSignIn.signOut();

      final googleAccount = await googleSignIn.signIn();

      if (googleAccount != null) {
        final googleAuth = await googleAccount.authentication;
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        final userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
        return userCredential.user;
      } else {
        return null;
      }
    } catch (e) {
      print("Error signing in with Google: $e");
      return null;
    }
  }

  Future<User?> signInWithFacebook() async {
    try {
      final LoginResult loginResult = await FacebookAuth.instance.login();
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);
      final userCredential = await FirebaseAuth.instance
          .signInWithCredential(facebookAuthCredential);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      print(e.message);
      return null;
    }
  }
  signInWithEmail(email,password)async{
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      emit(LoginSuccessState());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        error='No user found for that email.';
        emit(LoginErrorState(error));
      } else if (e.code == 'wrong-password') {
        error='Wrong password provided for that user.';
        emit(LoginErrorState(error));
      }else{
        error="Wrong Email or Password";
        emit(LoginErrorState(error));
      }
    }
  }
doesEmailExist(String email) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    QuerySnapshot querySnapshot = await users.where('email', isEqualTo: email).get();
    print(querySnapshot.docs.isNotEmpty);
    isExist=querySnapshot.docs.isNotEmpty;

  }
}
