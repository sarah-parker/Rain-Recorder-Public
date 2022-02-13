import 'dart:io';
import 'package:csv/csv.dart';
import 'package:external_path/external_path.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rain_recorder/models/rain.dart';

class ExportFile {
  List<Rain> rain;
  ExportFile(this.rain);

  void generateCsvFile() async {
    if (await Permission.storage.request().isGranted) {
      List<List<dynamic>> rows = [];

      List<dynamic> row = [];
      row.add("Date");
      row.add("Amount");

      for (int i = 0; i < rain.length; i++) {
        List<dynamic> row = [];
        row.add(rain[i].date);
        row.add(rain[i].amount);
        rows.add(row);
      }

      String csv = const ListToCsvConverter().convert(rows);

      String dir = await ExternalPath.getExternalStoragePublicDirectory(
          ExternalPath.DIRECTORY_DOWNLOADS);
      String file = dir;

      File f = File(file + "/rain_recorder_export.csv");

      f.writeAsString(csv);
    } else {
      print('denied');
    }
  }
}
