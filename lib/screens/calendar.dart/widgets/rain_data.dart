import 'package:flutter/material.dart';
import 'package:rain_recorder/models/observation.dart';
import 'package:rain_recorder/models/rain.dart';
import 'package:rain_recorder/models/user.dart';
import 'package:rain_recorder/services/database.dart';
import 'package:rain_recorder/services/weather_station.dart';
import 'package:collection/collection.dart';

double? existingRainfall(DateTime date, List<Rain>? rain) {
  return rain
      ?.firstWhereOrNull((element) =>
          element.date.day == date.day &&
          element.date.month == date.month &&
          element.date.year == date.year)
      ?.amount;
}

String rainfallForMonth(DateTime date, List<Rain>? rain) {
  var rainfall = rain?.where((element) =>
      element.date.month == date.month && element.date.year == date.year);
  double totalRain = 0;

  if (rainfall != null) {
    for (var day in rainfall) {
      totalRain += day.amount;
    }
  }
  return totalRain > 0 ? "${totalRain.toStringAsFixed(2)} mm" : "";
}

String rainfallForYear(DateTime date, List<Rain>? rain) {
  var rainfall = rain?.where((element) => element.date.year == date.year);
  double totalRain = 0;

  if (rainfall != null) {
    for (var day in rainfall) {
      totalRain += day.amount;
    }
  }
  return totalRain > 0 ? "${totalRain.toStringAsFixed(2)} mm" : "0 mm";
}

Widget allRainfall(List<Rain>? rain, DateTime day) {
  final rainfall = rain?.where((element) =>
      element.date.day == day.day &&
      element.date.month == day.month &&
      element.date.year == day.year);

  if (rainfall != null) {
    for (var day in rainfall) {
      RegExp regex = RegExp(r'.00');
      return Positioned(
        child: Text(
          day.amount > 0
              ? '${day.amount.toString().replaceAll(regex, "")} mm'
              : "",
        ),
      );
    }
  }
  return const Text('');
}

void updateHistoricalObservations(
    WeatherStation weatherStation, User user) async {
  Observation obs = await weatherStation.get7DayHistoricalObservations();
  for (var observation in obs.observations!) {
    if (observation.metric?.precipTotal != null &&
        observation.metric!.precipTotal! > 0.0) {
      DatabaseService(user.uid).updateRainData(
          double.parse(observation.metric!.precipTotal!.toStringAsFixed(2)),
          DateTime(observation.obsTimeLocal!.year,
              observation.obsTimeLocal!.month, observation.obsTimeLocal!.day));
    }
  }
}
