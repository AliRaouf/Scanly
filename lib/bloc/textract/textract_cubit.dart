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
  bool validateTest({required String testName, required String test}) {
    if (testName == 'CBC (Complete Blood Count)') {
      if (test.toLowerCase().contains(testName.toLowerCase()) ||
          test.toLowerCase().contains('complete blood')) {
        return true;
      }
      return false;
    } else if (testName == "Lipid profile") {
      if (test.toLowerCase().contains(testName.toLowerCase()) ||
          test.toLowerCase().contains('lipids profile')) {
        return true;
      }
      return false;
    } else if (testName == "Uric acid") {
      if (test.toLowerCase().contains(testName.toLowerCase()) ||
          test.toLowerCase().contains('lipids profile')) {
        return true;
      }
      return false;
    } else if (testName == "Parathyroid hormone (pth)") {
      if (test.toLowerCase().contains(testName.toLowerCase()) ||
          test.toLowerCase().contains('parathyroid hormone') ||
          test.toLowerCase().contains('pth')) {
        return true;
      }
      return false;
    } else if (testName == "Vitamin D") {
      if (test.toLowerCase().contains(testName.toLowerCase())) {
        return true;
      }
      return false;
    } else if (testName == "Fasting blood sugar") {
      if (test.toLowerCase().contains(testName.toLowerCase()) ||
          test.toLowerCase().contains('fasting blood')) {
        return true;
      }
      return false;
    } else if (testName == "Tsh") {
      if (test.toLowerCase().contains(testName.toLowerCase())) {
        return true;
      }
      return false;
    } else if (testName == "T3 total and free") {
      if (test.toLowerCase().contains('t3')) {
        return true;
      }
      return false;
    } else if (testName == "T4 total and free") {
      if (test.toLowerCase().contains('t4')) {
        return true;
      }
      return false;
    }else if (testName == "Calcium") {
      if (test.toLowerCase().contains(testName.toLowerCase())) {
        return true;
      }
      return false;
    }
    else if (testName == "Magnesium") {
      if (test.toLowerCase().contains(testName.toLowerCase())) {
        return true;
      }
      return false;
    }
    else if (testName == "Favism (G6PD deficiency test)") {
      if (test.toLowerCase().contains(testName.toLowerCase()) ||
          test.toLowerCase().contains('favism')) {
        return true;
      }
      return false;
    }
    else if (testName == "Glucose after 2 hours") {
      if (test.toLowerCase().contains(testName.toLowerCase()) ||
          test.toLowerCase().contains('glucose')) {
        return true;
      }
      return false;
    }
    else if (testName == "HbA1c") {
      if (test.toLowerCase().contains(testName.toLowerCase()) ||
          test.toLowerCase().contains('hb a1c')||
          test.toLowerCase().contains('glycated haemoglobin')) {
        return true;
      }
      return false;
    }
    else if (testName == "Serum Iron") {
      if (test.toLowerCase().contains(testName.toLowerCase()) ||
          test.toLowerCase().contains('serum')||
          test.toLowerCase().contains('iron')) {
        return true;
      }
      return false;
    }
    else if (testName == "TIBC (Total Iron Binding Capacity)") {
      if (test.toLowerCase().contains(testName.toLowerCase()) ||
          test.toLowerCase().contains('tibc')) {
        return true;
      }
      return false;
    }
    else if (testName == "Transferrin saturation") {
      if (test.toLowerCase().contains(testName.toLowerCase()) ||
          test.toLowerCase().contains('transferrin')) {
        return true;
      }
      return false;
    }
    else if (testName == "PT (Prothrombin Time)") {
      if (test.toLowerCase().contains(testName.toLowerCase()) ||
          test.toLowerCase().contains('pt')||
          test.toLowerCase().contains('prothrombin')) {
        return true;
      }
      return false;
    }
    else if (testName == 'PTT (Partial Thromboplastin Time)') {
      if (test.toLowerCase().contains(testName.toLowerCase()) ||
          test.toLowerCase().contains('ptt')||
          test.toLowerCase().contains('thromboplastin')) {
        return true;
      }
      return false;
    }
    else if (testName == "Bleeding time") {
      if (test.toLowerCase().contains(testName.toLowerCase()) ||
          test.toLowerCase().contains('bleeding')) {
        return true;
      }
      return false;
    }
    else if (testName == "Clotting time") {
      if (test.toLowerCase().contains(testName.toLowerCase()) ||
          test.toLowerCase().contains('clotting')) {
        return true;
      }
      return false;
    }
    else if (testName == "AST (SGOT)") {
      if (test.toLowerCase().contains(testName.toLowerCase()) ||
          test.toLowerCase().contains('ast')) {
        return true;
      }
      return false;
    }
    else if (testName == "ALT (SGPT)") {
      if (test.toLowerCase().contains(testName.toLowerCase()) ||
          test.toLowerCase().contains('alt')) {
        return true;
      }
      return false;
    }
    else if (testName == "Bilirubin") {
      if (test.toLowerCase().contains(testName.toLowerCase())) {
        return true;
      }
      return false;
    }
    else if (testName == "Albumin") {
      if (test.toLowerCase().contains(testName.toLowerCase())) {
        return true;
      }
      return false;
    }
    else if (testName == "Total protein") {
      if (test.toLowerCase().contains(testName.toLowerCase())||
          test.toLowerCase().contains('protein')) {
        return true;
      }
      return false;
    }
    else if (testName == "Total protein") {
      if (test.toLowerCase().contains(testName.toLowerCase())||
          test.toLowerCase().contains('phosphatase')) {
        return true;
      }
      return false;
    }
    else if (testName == "Creatinine") {
      if (test.toLowerCase().contains(testName.toLowerCase())) {
        return true;
      }
      return false;
    }else if (testName == "Blood urea") {
      if (test.toLowerCase().contains(testName.toLowerCase())||
          test.toLowerCase().contains('blood')) {
        return true;
      }
      return false;
    }else if (testName == "Uric acid") {
      if (test.toLowerCase().contains(testName.toLowerCase())||
          test.toLowerCase().contains('uric')) {
        return true;
      }
      return false;
    }
    else if (testName == "BUN") {
      if (test.toLowerCase().contains(testName.toLowerCase())) {
        return true;
      }
      return false;
    }else if (testName == "Sodium") {
      if (test.toLowerCase().contains(testName.toLowerCase())) {
        return true;
      }
      return false;
    }
    else if (testName == "Potassium") {
      if (test.toLowerCase().contains(testName.toLowerCase())) {
        return true;
      }
      return false;
    }
    else if (testName == "CRP (C-Reactive Protein)") {
      if (test.toLowerCase().contains(testName.toLowerCase()) ||
          test.toLowerCase().contains('crp')||
          test.toLowerCase().contains('reactive')) {
        return true;
      }
      return false;
    }
    else if (testName == "ESR (Erythrocyte Sedimentation Rate)") {
      if (test.toLowerCase().contains(testName.toLowerCase()) ||
          test.toLowerCase().contains('esr')||
          test.toLowerCase().contains('Sedimentation')) {
        return true;
      }
      return false;
    } else if (testName == "Urinalysis") {
      if (test.toLowerCase().contains(testName.toLowerCase()) ||
          test.toLowerCase().contains('urine analysis')) {
        return true;
      }
      return false;
    }
    else if (testName == "Thalassemia") {
      if (test.toLowerCase().contains(testName.toLowerCase())) {
        return true;
      }
      return false;
    }else if (testName == "FMF (Familial Mediterranean Fever)") {
      if (test.toLowerCase().contains(testName.toLowerCase()) ||
          test.toLowerCase().contains('mediterranean')) {
        return true;
      }
      return false;
    }
    else if (testName == "Karyotyping") {
      if (test.toLowerCase().contains(testName.toLowerCase())) {
        return true;
      }
      return false;
    }
    return false;
  }
}
