import 'dart:io';

import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:aws_common/vm.dart';
part 'textract_state.dart';

class TextractCubit extends Cubit<TextractState> {
  TextractCubit() : super(TextractInitial());
  static TextractCubit get(context) => BlocProvider.of(context);
  Future<void> uploadImage(File imageFile) async {
    try {

     AWSFile awsFile =  AWSFilePlatform.fromFile(imageFile);
      final key = DateTime.now().microsecondsSinceEpoch.toString(); // Generate unique key
      final uploadFileOption = StorageUploadFileOptions(
        accessLevel: StorageAccessLevel.guest, // Adjust access level as needed
        metadata: {'fileName': imageFile.path.split('/').last}, // Add metadata
      );

      final result = await Amplify.Storage.uploadFile(
        key: key,
        localFile: awsFile,
        options: uploadFileOption,
        onProgress: (progress) => safePrint('Progress: ${progress.fractionCompleted}'),
      );

      safePrint('Uploaded file: $result');
    } on StorageException catch (e) {
      safePrint('Error uploading image: ${e.message}');
    }
  }
}
