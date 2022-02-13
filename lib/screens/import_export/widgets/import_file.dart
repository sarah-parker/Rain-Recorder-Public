import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:rain_recorder/models/user.dart';
import 'package:rain_recorder/services/database.dart';

class ImportFile {
  User user;

  ImportFile(this.user);

  Future<String> pickFile() async {
    final result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: ['txt', 'csv'],
        withReadStream: true);

    if (result == null) return 'Please select a file';

    File file = File(result.files.first.path!);

    return await readFile(file);
  }

  Future<String> readFile(File file) async {
    String result = '';
    try {
      final importedRainfall = file.readAsLinesSync().map((line) async {
        final parts = line.split(',');
        await DatabaseService(user.uid)
            .updateRainData(
                double.tryParse(parts[1])!, DateTime.tryParse(parts[0])!)
            .then((value) {
          result = 'Success uploading file';
        }).catchError((error) {
          // print("Error!");
          result = 'Upload Failed';
        });
        // return Rain(
        //     amount: double.tryParse(parts[1])!,
        //     date: DateTime.tryParse(parts[0])!);
      }).toList();
    } catch (e) {
      result = 'Upload Failed';
      rethrow;
    } finally {
      return result;
    }
  }
}
