import 'dart:io';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:path_provider/path_provider.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:aws_common/vm.dart';

part 'textract_state.dart';

class TextractCubit extends Cubit<TextractState> {
  TextractCubit() : super(TextractInitial());

  static TextractCubit get(context) => BlocProvider.of(context);
  String? imageTextFile;
  File? fileImage;
  String? filePath;

  createTempFileFromMemoryImage(MemoryImage image) async {
    final tempDir = await Directory.systemTemp;
    final fileName = '${DateTime
        .now()
        .microsecondsSinceEpoch}.jpg';
    final file = File('${tempDir.path}/$fileName');
    await file.writeAsBytes(image.bytes);
    fileImage = file;
  }

  Future<void> uploadImage(File imageFile) async {
    emit(UploadImageLoading());
    try {
      AWSFile awsFile = AWSFilePlatform.fromFile(imageFile);
      final key = DateTime
          .now()
          .microsecondsSinceEpoch
          .toString();
      final uploadFileOption = StorageUploadFileOptions(
        accessLevel: StorageAccessLevel.guest,
        metadata: {'fileName': imageFile.path
            .split('/')
            .last},
      );

      final result = await Amplify.Storage.uploadFile(
        key: key,
        localFile: awsFile,
        options: uploadFileOption,
        onProgress: (progress) {
          safePrint('Progress: ${progress.fractionCompleted}');
          if(progress.fractionCompleted==1){
            emit(UploadImageSuccess());
          }
        }
      );
      imageTextFile = key;
      safePrint('Uploaded file: $result');
    } on StorageException catch (e) {
      safePrint('Error uploading image: ${e.message}');
      emit(UploadImageError());
    }
  }

  Future<void> downloadToLocalFile() async {
    final documentsDir = await getApplicationDocumentsDirectory();
    filePath = documentsDir.path + '/example.txt';

    // Construct the nested key path
    final nestedKey = 'public/$imageTextFile.txt';
print(nestedKey);
print(filePath!);
    try {
      final result = await Amplify.Storage
          .downloadFile(options: StorageDownloadFileOptions(accessLevel:StorageAccessLevel.guest ),
        key: nestedKey,
        onProgress: (progress) {
          safePrint('Fraction completed: ${progress.fractionCompleted}');
        }, localFile: AWSFile.fromPath(filePath!),
      )
          .result;
      safePrint('Downloaded file is located at: ${result.downloadedItem.size}');
    } on StorageException catch (e) {
      safePrint(e.message);
    }
  }

  Future<String> downloadAndGetText() async {
    await downloadToLocalFile(); // Call the download function

    final file = File(filePath!); // Use the previously defined filepath
    try {
      final text = await file.readAsString();
      return text;
    } on FileSystemException catch (e) {
      safePrint('Error accessing downloaded file: $e');
      return '';
    }
  }
  Future<void> listAlbum() async {
    try {
      String? nextToken;
      bool hasNextPage;
      do {
        final result = await Amplify.Storage.list(path: "public/",
          options: StorageListOptions(
            accessLevel: StorageAccessLevel.guest, // Change access level as per your requirement (public/private/protected)
            pageSize: 1000,
            pluginOptions: S3ListPluginOptions(
              excludeSubPaths: false,
            ),
            nextToken: nextToken,
          ),
        ).result;

        // Process the list of items
        for (StorageItem item in result.items) {
          print('File Key: ${item.key}');
        }

        // Fetch next page if available
        nextToken = result.nextToken;
        hasNextPage = result.hasNextPage;

      } while (hasNextPage);

    } on StorageException catch (e) {
      print('Error listing files: ${e.message}');
    }
  }
}
