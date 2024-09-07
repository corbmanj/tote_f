import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:tote_f/models/tote/weather.dart';

Future<WeatherResponse> fetchWeather(String city, DateTimeRange dates) async {
  const weatherKey = String.fromEnvironment('WTHR_KEY');
  if (weatherKey.isEmpty) {
    throw AssertionError('WTHR_KEY is not set');
  }
  final startSeconds = dates.start.millisecondsSinceEpoch ~/ 1000;
  final endSeconds = dates.end.millisecondsSinceEpoch ~/ 1000;
  var url = Uri.https(
    'weather.visualcrossing.com',
    'VisualCrossingWebServices/rest/services/timeline/$city/$startSeconds/$endSeconds',
    {'key': weatherKey, 'include': 'days'},
  );
  var response = await http.get(url);
  if (response.statusCode == 200) {
    var jsonResponse =
        convert.jsonDecode(response.body) as Map<String, dynamic>;
    final weather = WeatherResponse.fromMap(jsonResponse);
    return weather;
  }
  return WeatherResponse(false);
}
