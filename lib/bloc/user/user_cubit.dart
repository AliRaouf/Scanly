import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
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
  getUserData() {
    user = FirebaseAuth.instance.currentUser;
    print(user?.email ?? "de7ka");
    emit(GetUserDataState());
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
  pickFile() async {
    emit(PickFileLoading());
    try{
      result= await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['png','pdf','jpeg','jpg']
      );
      if(result!=null){
        fileName=result!.files.first.name;
        extension=result!.files.first.extension;
        pickedFile = result!.files.first;
        fileToDisplay=File(pickedFile!.path.toString());
        print("$fileName \n$extension");
        emit(PickFileSuccess());
      }emit(PickFileSuccess());
    }
    catch (e){
      print(e);
      emit(PickFileError());
    }
  }
}
