import 'dart:convert';
import 'package:http/http.dart';
import 'package:rain_recorder/models/observation.dart';

class WeatherStation {
  final String url = "https://api.weather.com/v2/";
  final String currentObservations = "pws/observations/current";
  final String historicalObservations = "pws/dailysummary/7day";

  Future<Observations> getCurrentObservations() async {
    Response response = await get(Uri.parse(url + currentObservations));
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);

      Observation obs = Observation.fromJson(jsonData);

      Observations data = Observations();
      for (var observation in obs.observations!) {
        data = observation;
      }

      return data;
    } else {
      throw "Unable to retrieve current observation.";
    }
  }

  Future<Observation> get7DayHistoricalObservations() async {
    Response response = await get(Uri.parse(url + historicalObservations));

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);

      Observation obs = Observation.fromJson(jsonData);
      return obs;
    } else {
      throw "Unable to retrieve historical observations.";
    }
  }
}
