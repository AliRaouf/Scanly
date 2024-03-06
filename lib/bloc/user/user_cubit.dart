import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:meta/meta.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';
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
    image = img;
  }
  Future processImage() async {
    final inputImage = InputImage.fromFilePath(pickedFile!.path.toString());
    final textRecognizer = TextRecognizer();
    final RecognizedText recognizedText = await textRecognizer.processImage(inputImage);

    print(recognizedText.text);
  }
}
