import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());
  static UserCubit get(context) => BlocProvider.of(context);
  String? userEmail;
  String? userName;
  String? gender;
  String? password;
  User? user;
  String imageUrl="";
  List? diseases;
  int? height;
  int? weight;
  int? phoneNumber;
  File? fileToDisplay;
  FilePickerResult? result;
  String? fileName;
  PlatformFile? pickedFile;
  String? extension;
  Uint8List? image;
  bool isOldPasswordObscured = true;
  bool isNewPasswordObscured = true;
  bool isConfirmNewPasswordObscured = true;
  Stream? testStream;
  String error = '';
  getUserData() {
    user = FirebaseAuth.instance.currentUser;
    emit(GetUserDataState());
  }
  Future<String> uploadImage(Uint8List file, email) async {
    String imgName = email;
    Reference ref = FirebaseStorage.instance.ref('profile_image').child(
        imgName);
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }
  Future receiverUserData() async {
    emit(ReceiveUserNameLoadingState());
    try {
      QuerySnapshot<
          Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance
          .collection("users")
          .where("email", isEqualTo: FirebaseAuth.instance.currentUser!.email!)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        userName = querySnapshot.docs.first.get("username");
        imageUrl =querySnapshot.docs.first.get("image");
        gender=querySnapshot.docs.first.get("gender");
        password=querySnapshot.docs.first.get("password");
        diseases=querySnapshot.docs.first.get("diseases");
        height=querySnapshot.docs.first.get("height");
        weight=querySnapshot.docs.first.get("weight");
        phoneNumber=querySnapshot.docs.first.get("phoneNumber");
        emit(ReceiveUserNameSuccessState());
      } else {
        emit(ReceiveUserNameErrorState());
      }
    } catch (e) {
      emit(ReceiveUserNameErrorState());
    }
  }
  Future<User?> googleSignin() async {
    emit(LoginLoadingState());
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
        emit(LoginSuccessState());
        return userCredential.user;
      } else {
        emit(LoginErrorState(error));
        return null;
      }
    } catch (e) {
      emit(LoginErrorState(error));
      return null;
    }
  }
  signInWithEmail(email,password)async{
    emit(LoginLoadingState());
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
  Future<void> pickFile() async {
    emit(PickFileLoading());
    try {
      result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['png', 'pdf', 'jpeg', 'jpg'],
      );
      if (result != null) {
        fileName = result!.files.first.name;
        extension = result!.files.first.extension;
        pickedFile = result!.files.first;
        fileToDisplay = File(pickedFile!.path!);
        image = await FlutterImageCompress.compressWithFile(pickedFile?.path??"",quality: 70,);
        emit(PickFileSuccess());
      } else {
        emit(PickFileError());
      }
    } catch (e) {
      emit(PickFileError());
    }
  }
  pickImage(ImageSource source) async {
    final ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: source);
    if (file != null) {
      return await file.readAsBytes();
    } else {
    }
  }
  selectImage() async {
    Uint8List? img = await pickImage(ImageSource.camera);
    if (img != null) {
      image = await FlutterImageCompress.compressWithList(img,quality: 70,);

    }
  }
  changeUserImage()async{
    Uint8List? img = await pickImage(ImageSource.gallery);
    if (img != null) {
      image = await FlutterImageCompress.compressWithList(img,quality: 70,);

    }
  }
  Future<void> logout() async {
    emit(UserLogoutLoading());
    try {
      await FirebaseAuth.instance.signOut();
      emit(UserLogoutSuccess());
    } catch (e) {
      emit(UserLogoutError());
    }
  }
  changeUserPassword(oldPassword, newPassword) {
    emit(ChangeUserPasswordLoadingState());
    AuthCredential credential = EmailAuthProvider.credential(
        email: user!.email!, password: oldPassword);
    user!.reauthenticateWithCredential(credential)
        .then((_) {
      user!.updatePassword(newPassword).then((_) {
        updateUserPassword(newPassword);
        emit(ChangeUserPasswordSuccessState());
      }).catchError((error) {
        emit(ChangeUserPasswordErrorState());
      });
    }).catchError((error) {
      emit(ChangeUserPasswordErrorState());
    });
  }

  updateUserPassword(newPassword) {
    FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: user!.email)
        .get().then((QuerySnapshot querySnapshot) {
      var doc = querySnapshot.docs.first;
      doc.reference.update({'password': newPassword}).then((value) => print("Password Updated Successfully"))
          .catchError((error)=>debugPrint("Failed To Update Password"));
    });
  }
  updateUserImage(String imageUrl) {
    FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: FirebaseAuth.instance.currentUser!.email)
        .get().then((QuerySnapshot querySnapshot) {
      var doc = querySnapshot.docs.first;
      doc.reference.update({'image': imageUrl}).then((value) => emit(UpdateUserImageSuccess()))
          .catchError((error)=>emit(UpdateUserImageFailure()));
    });
  }
  updateUserData(String userName,int height,int weight) {
    FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: user!.email)
        .get().then((QuerySnapshot querySnapshot) {
      var doc = querySnapshot.docs.first;
      doc.reference.update({'username': userName,'height':height,"weight":weight}).then((value) => emit(UpdateUserDataSuccess()))
          .catchError((error)=>emit(UpdateUserDataFailure()));
    });
  }
  deleteUserTest(BuildContext context,Timestamp timestamp) {
    FirebaseFirestore.instance
        .collection("tests")
        .doc(UserCubit.get(context).user!.email)
        .collection("userTest")
        .where('uploadDate',isEqualTo: timestamp)
        .get().then((QuerySnapshot querySnapshot) {
      var doc = querySnapshot.docs.first;
      doc.reference.delete()
          .catchError((error)=>emit(UpdateUserDataFailure()));
    });
  }
  void toggleOldPasswordVisibility() {
    isOldPasswordObscured = !isOldPasswordObscured;
  }

  void toggleNewPasswordVisibility() {
    isNewPasswordObscured = !isNewPasswordObscured;
  }

  void toggleConfirmNewPasswordVisibility() {
    isConfirmNewPasswordObscured = !isConfirmNewPasswordObscured;
  }
  Stream<List<dynamic>> getUserTestStream(String userEmail) {
    return FirebaseFirestore.instance
        .collection('tests')
        .doc(userEmail)
        .collection('userTest')
        .snapshots()
        .map((querySnapshot) => querySnapshot.docs.map((doc) => doc.data()).toList());
  }
}
