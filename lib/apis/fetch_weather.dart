import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:tote_f/models/trip/weather.dart';

Future<WeatherResponse> fetchWeather(String city, DateTimeRange dates) async {
  const weatherKey = String.fromEnvironment('WTHR_KEY');
  if (weatherKey.isEmpty) {
    throw AssertionError('WTHR_KEY is not set');
  }
  final String startDate = '${dates.start.year}-${dates.start.month}-${dates.start.day}';
  final String endDate = '${dates.end.year}-${dates.end.month}-${dates.end.day}';
  var url = Uri.https(
    'weather.visualcrossing.com',
    'VisualCrossingWebServices/rest/services/timeline/$city/$startDate/$endDate',
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
