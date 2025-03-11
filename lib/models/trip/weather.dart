class WeatherResponse {
  bool success;
  List<Weather>? days;

  WeatherResponse(this.success, [this.days]);
  factory WeatherResponse.fromMap(Map<String, dynamic> map) {
    return WeatherResponse(
      true,
      map['days'].map<Weather>((day) => Weather.fromMap(day)).toList(),
    );
  }
}

class Weather {
  DateTime dateTime;
  double low;
  double high;
  double precip;
  int sunset;
  int sunrise;
  String icon;
  String summary;

  Weather(
    this.dateTime,
    this.low,
    this.high,
    this.precip,
    this.sunset,
    this.sunrise,
    this.icon,
    this.summary,
  );

  Map toJson() => {
        'low': low,
        'high': high,
        'precip': precip,
        'sunset': sunset,
        'sunrise': sunrise,
        'icon': icon,
        'summary': summary,
      };

  factory Weather.fromMap(Map<String, dynamic> map) {
    return Weather(
      DateTime.parse(map['datetime']),
      map['tempmin'] as double,
      map['tempmax'] as double,
      map['precipprob'] as double,
      map['sunsetEpoch'] as int,
      map['sunriseEpoch'] as int,
      map['icon'] as String,
      map['description'] as String,
    );
  }
}
