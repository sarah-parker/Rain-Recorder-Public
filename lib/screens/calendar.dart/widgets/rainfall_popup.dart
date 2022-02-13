import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rain_recorder/models/user.dart';
import 'package:rain_recorder/services/database.dart';

class RainfallPopup extends StatelessWidget {
  final DateTime selectedDay;
  double? existingRainfall;
  final _controller = TextEditingController();
  RainfallPopup({Key? key, required this.selectedDay, this.existingRainfall})
      : super(key: key);

  void dispose() {
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    if (existingRainfall != null) {
      _controller.text = existingRainfall.toString();
    }

    return AlertDialog(
        title: SelectableText(
          'Add Rainfall for ${DateFormat('dd-MMM-yy').format(selectedDay)}',
          style: Theme.of(context).textTheme.bodyText1,
        ),
        content: TextFormField(
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.allow(RegExp(r'(^\d*\.?\d{0,2})')),
          ],
          controller: _controller,
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel')),
          if (_controller.text.isNotEmpty)
            TextButton(
                onPressed: () async {
                  await DatabaseService(user.uid).deleteRainDataForDay(DateTime(
                      selectedDay.year, selectedDay.month, selectedDay.day));
                  Navigator.pop(context);
                  return;
                },
                child: const Text('Delete Entry')),
          TextButton(
              onPressed: () async {
                if (_controller.text.isEmpty) {
                  Navigator.pop(context);
                  return;
                } else {
                  await DatabaseService(user.uid).updateRainData(
                      double.parse(_controller.text),
                      DateTime(selectedDay.year, selectedDay.month,
                          selectedDay.day));
                  Navigator.pop(context);
                  return;
                }
              },
              child: const Text('Ok')),
        ]);
  }
}
