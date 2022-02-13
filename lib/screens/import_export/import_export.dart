import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rain_recorder/models/rain.dart';
import 'package:rain_recorder/models/user.dart';
import 'package:rain_recorder/screens/import_export/widgets/export_file.dart';
import 'package:rain_recorder/screens/import_export/widgets/import_file.dart';

class ImportExport extends StatefulWidget {
  const ImportExport({Key? key}) : super(key: key);

  @override
  _ImportExportState createState() => _ImportExportState();
}

class _ImportExportState extends State<ImportExport> {
  String _message = '';

  @override
  Widget build(BuildContext context) {
    final rain = Provider.of<List<Rain>?>(context);

    return Column(
      children: [
        const Padding(padding: EdgeInsets.all(10.0)),
        Card(
          color: Colors.grey[300],
          child: const Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              'Please select a .csv or .txt file to import. \nFormat of file should be\nDate | Amount\n in first column and second column (numbers only)',
              textAlign: TextAlign.center,
            ),
          ),
        ),
        const Padding(padding: EdgeInsets.all(8.0)),
        MaterialButton(
          onPressed: () async {
            var importFile =
                ImportFile(Provider.of<User>(context, listen: false));
            await importFile.pickFile().then((value) {
              setState(() {
                _message = 'File uploaded successfully';
              });
            });
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(Icons.cloud_upload_outlined),
              Padding(padding: EdgeInsets.symmetric(horizontal: 3.0)),
              Text('Import file'),
            ],
          ),
          color: Theme.of(context).colorScheme.primary,
        ),
        Text(_message, style: const TextStyle(color: Colors.red)),
        const Divider(
          color: Colors.black,
          thickness: 1.0,
          indent: 20,
          endIndent: 20,
        ),
        const Padding(padding: EdgeInsets.all(8.0)),
        Card(
          color: Colors.grey[300],
          child: const Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              'Please press the below button to export rain data into a .csv file. \nIt will be placed in the Downloads folder',
              textAlign: TextAlign.center,
            ),
          ),
        ),
        const Padding(padding: EdgeInsets.all(10.0)),
        MaterialButton(
          onPressed: () {
            var exportFile = ExportFile(rain!);
            exportFile.generateCsvFile();
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(Icons.cloud_download_outlined),
              Padding(padding: EdgeInsets.symmetric(horizontal: 3.0)),
              Text('Export data to CSV'),
            ],
          ),
          color: Theme.of(context).colorScheme.primary,
        ),
      ],
    );
  }
}
