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
  Map<String, dynamic>? jsonTest;
  Future createTempFileFromMemoryImage(MemoryImage image) async {
    final tempDir = await Directory.systemTemp;
    final fileName = '${DateTime.now().microsecondsSinceEpoch}.jpg';
    final file = File('${tempDir.path}/$fileName');
    await file.writeAsBytes(image.bytes);
    fileImage = file;
  }

  Future<void> uploadImage(File imageFile) async {
    emit(TextractLoading());
    try {
      AWSFile awsFile = AWSFilePlatform.fromFile(imageFile);
      final key = DateTime.now().microsecondsSinceEpoch.toString();
      final uploadFileOption = StorageUploadFileOptions(
        accessLevel: StorageAccessLevel.guest,
        metadata: {'fileName': imageFile.path.split('/').last},
      );

      final result = await Amplify.Storage.uploadFile(
          key: key,
          localFile: awsFile,
          options: uploadFileOption,
          onProgress: (progress) {
            if (progress.fractionCompleted == 1) {
              emit(UploadImageSuccess());
            }
          });
      imageTextFile = key;
    } on StorageException catch (e) {
      emit(UploadImageError());
    }
  }

  Future<void> downloadToLocalFile() async {
    final documentsDir = await getApplicationDocumentsDirectory();
    filePath = documentsDir.path + '/example.txt';

    // Construct the nested key path
    final nestedKey = 'public/$imageTextFile.txt';
    try {
      final result = await Amplify.Storage.downloadFile(
        options:
            StorageDownloadFileOptions(accessLevel: StorageAccessLevel.guest),
        key: nestedKey,
        onProgress: (progress) {
        },
        localFile: AWSFile.fromPath(filePath!),
      ).result;
    } on StorageException catch (e) {
    }
  }

  Future<String> downloadAndGetText() async {
    String text;
    do {
      await downloadToLocalFile(); // Call the download function

      final file = File(filePath!); // Use the previously defined filepath
      try {
        text = await file.readAsString();
        // Break the loop if text is not null or empty
        break;
      } on FileSystemException catch (e) {
        text = '';
      }
      // Wait 10 seconds before retrying
      await Future.delayed(const Duration(seconds: 10));
    } while (text == null || text.isEmpty);

    return text;
  }

  Future<void> listAlbum() async {
    try {
      String? nextToken;
      bool hasNextPage;
      do {
        final result = await Amplify.Storage.list(
          path: "public/",
          options: StorageListOptions(
            accessLevel: StorageAccessLevel
                .guest, // Change access level as per your requirement (public/private/protected)
            pageSize: 1000,
            pluginOptions: S3ListPluginOptions(
              excludeSubPaths: false,
            ),
            nextToken: nextToken,
          ),
        ).result;

        // Process the list of items
        for (StorageItem item in result.items) {
        }

        // Fetch next page if available
        nextToken = result.nextToken;
        hasNextPage = result.hasNextPage;
      } while (hasNextPage);
    } on StorageException catch (e) {
    }
  }
}
