import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  getUserData() {
    user = FirebaseAuth.instance.currentUser;
    print(user?.email ?? "de7ka");
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
          .where("email", isEqualTo: user!.email!)
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
        print("de7k");
      } else {
        emit(ReceiveUserNameErrorState());
        print("error");
      }
    } catch (e) {
      emit(ReceiveUserNameErrorState());
      print(e);
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
        print("$fileName \n $extension");
        emit(PickFileSuccess());
      } else {
        print("No file selected");
        emit(PickFileError());
      }
    } catch (e) {
      print(e);
      emit(PickFileError());
    }
  }
  pickImage(ImageSource source) async {
    final ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: source);
    if (file != null) {
      return await file.readAsBytes();
    } else {
      print("No Image Selected");
    }
  }
  selectImage() async {
    Uint8List? img = await pickImage(ImageSource.camera);
    if (img != null) {
      image = await FlutterImageCompress.compressWithList(img,quality: 70,);
      print("before: ${img.length}");
      print("after: ${image!.length}");
    }
  }
  Future<void> logout() async {
    emit(UserLogoutLoading());
    try {
      await FirebaseAuth.instance.signOut();
      emit(UserLogoutSuccess());
    } catch (e) {
      print('Error signing out: $e');
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
        print('Password updated successfully');
        updateUserPassword(newPassword);
        emit(ChangeUserPasswordSuccessState());
      }).catchError((error) {
        print('Error updating password: $error');
        emit(ChangeUserPasswordErrorState());
      });
    }).catchError((error) {
      print('Error re-authenticating user: $error');
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
          .catchError((error)=>print("Failed To Update Password"));
    });
  }
  updateUserImage(String imageUrl) {
    FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: user!.email)
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
  void toggleOldPasswordVisibility() {
    isOldPasswordObscured = !isOldPasswordObscured;
  }

  void toggleNewPasswordVisibility() {
    isNewPasswordObscured = !isNewPasswordObscured;
  }

  void toggleConfirmNewPasswordVisibility() {
    isConfirmNewPasswordObscured = !isConfirmNewPasswordObscured;
  }
}
