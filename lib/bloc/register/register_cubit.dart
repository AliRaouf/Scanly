
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  static RegisterCubit get(context) => BlocProvider.of(context);
  String? name;
  String? email;
  int? phoneNumber;
  String? password;
  DateTime? date;
  String? gender;
  int? height;
  int? weight;
  List? diseases;
  String? error;
  Uint8List? image;

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

  Future<Uint8List> getDefaultImageBytes() async {
    ByteData data = await rootBundle.load('assets/images/avatar.png');
    List<int> bytes = data.buffer.asUint8List();
    return Uint8List.fromList(bytes);
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
    Uint8List? img = await pickImage(ImageSource.gallery);
    image = img;
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

  registerUser(emailAddress, password) async {
    emit(RegisterUserLoading());
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      emit(RegisterUserSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        error = 'The password provided is too weak.';
        emit(RegisterUserError());
      } else if (e.code == 'email-already-in-use') {
        error = 'The account already exists for that email.';
        emit(RegisterUserError());
      }
    } catch (e) {
      print(e);
      emit(RegisterUserError());
    }
  }
  saveUser(email, password, name, phone, dob, gender, int height, int weight,
      List diseases,Uint8List? file) async {
    emit(SaveUserLoadingState());
    Uint8List defaultImage = await getDefaultImageBytes();
    String imageUrl = await uploadImage(file??defaultImage, email);
    try {
      FirebaseFirestore.instance
          .collection("users")
          .add({
        "username": name,
        "email": email,
        "password": password,
        "gender": gender,
        "image": imageUrl,
        "phoneNumber":phone,
        "dateOfBirth":dob,
        "height":height,
        "weight":weight,
        "diseases":diseases
      });
      print("user saved success");
      emit(SaveUserSuccessState());
    } on Exception catch (e) {
      emit(SaveUserErrorState());
      print("couldnt save user $e");
    }
  }
  Future<Uint8List> getDefaultImageBytesFromImage(String imageUrl) async {
    ByteData data = await NetworkAssetBundle(Uri.parse(imageUrl)).load(imageUrl);
    List<int> bytes = data.buffer.asUint8List();
    return Uint8List.fromList(bytes);
  }

}
