import 'package:flutter/material.dart';
import 'package:rain_recorder/models/observation.dart';
import 'package:intl/intl.dart';

class ObservationCard extends StatelessWidget {
  Observations observation;
  DateTime focusedDay;
  String yearlyRainfall;

  ObservationCard(
      {Key? key,
      required this.observation,
      required this.focusedDay,
      required this.yearlyRainfall})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${observation.neighborhood!}',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
            ),
            Text(
                'Latest Update: ${DateFormat('d MMM HH:MM a').format(observation.obsTimeLocal!)}'),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
            ),
            Text('Current Temperature: ${observation.metric?.temp} °C'),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
            ),
            Text('Feels like: ${observation.metric?.heatIndex} °C'),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
            ),
            Text('Daily Rainfall: ${observation.metric?.precipTotal} mm'),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
            ),
            Text('Rain ${focusedDay.year} YTD: $yearlyRainfall'),
          ],
        ),
      ),
    );
  }
}
