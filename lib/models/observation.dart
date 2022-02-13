class Observation {
  List<Observations>? observations;

  Observation({this.observations});

  Observation.fromJson(Map<String, dynamic> json) {
    if (json['observations'] != null) {
      observations = <Observations>[];
      json['observations'].forEach((v) {
        observations!.add(new Observations.fromJson(v));
      });
    } else if (json['summaries'] != null) {
      observations = <Observations>[];
      json['summaries'].forEach((v) {
        observations!.add(new Observations.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.observations != null) {
      data['observations'] = this.observations!.map((v) => v.toJson()).toList();
    } else if (this.observations != null) {
      data['summaries'] = this.observations!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Observations {
  String? stationID;
  DateTime? obsTimeLocal;
  String? neighborhood;
  String? softwareType;
  String? country;
  double? solarRadiation;
  double? lon;
  double? lat;
  double? uv;
  int? winddir;
  int? humidity;
  Metric? metric;

  Observations(
      {this.stationID,
      this.obsTimeLocal,
      this.neighborhood,
      this.softwareType,
      this.country,
      this.solarRadiation,
      this.lon,
      this.lat,
      this.uv,
      this.winddir,
      this.humidity,
      this.metric});

  Observations.fromJson(Map<String, dynamic> json) {
    stationID = json['stationID'];
    obsTimeLocal = DateTime.parse(json['obsTimeLocal']);
    neighborhood = json['neighborhood'];
    softwareType = json['softwareType'];
    country = json['country'];
    solarRadiation = json['solarRadiation'];
    lon = json['lon'];
    lat = json['lat'];
    uv = json['uv'];
    winddir = json['winddir'];
    humidity = json['humidity'];
    metric =
        json['metric'] != null ? new Metric.fromJson(json['metric']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['stationID'] = this.stationID;
    data['obsTimeLocal'] = this.obsTimeLocal;
    data['neighborhood'] = this.neighborhood;
    data['softwareType'] = this.softwareType;
    data['country'] = this.country;
    data['solarRadiation'] = this.solarRadiation;
    data['lon'] = this.lon;
    data['lat'] = this.lat;
    data['uv'] = this.uv;
    data['winddir'] = this.winddir;
    data['humidity'] = this.humidity;
    if (this.metric != null) {
      data['metric'] = this.metric!.toJson();
    }
    return data;
  }
}

class Metric {
  int? temp;
  int? heatIndex;
  int? dewpt;
  int? windChill;
  int? windSpeed;
  int? windGust;
  double? pressure;
  double? precipRate;
  double? precipTotal;
  int? elev;

  Metric(
      {this.temp,
      this.heatIndex,
      this.dewpt,
      this.windChill,
      this.windSpeed,
      this.windGust,
      this.pressure,
      this.precipRate,
      this.precipTotal,
      this.elev});

  Metric.fromJson(Map<String, dynamic> json) {
    temp = json['temp'];
    heatIndex = json['heatIndex'];
    dewpt = json['dewpt'];
    windChill = json['windChill'];
    windSpeed = json['windSpeed'];
    windGust = json['windGust'];
    pressure = json['pressure'];
    precipRate = json['precipRate'];
    precipTotal = json['precipTotal'];
    elev = json['elev'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['temp'] = this.temp;
    data['heatIndex'] = this.heatIndex;
    data['dewpt'] = this.dewpt;
    data['windChill'] = this.windChill;
    data['windSpeed'] = this.windSpeed;
    data['windGust'] = this.windGust;
    data['pressure'] = this.pressure;
    data['precipRate'] = this.precipRate;
    data['precipTotal'] = this.precipTotal;
    data['elev'] = this.elev;
    return data;
  }
}
