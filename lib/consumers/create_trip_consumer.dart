import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tote_f/apis/fetch_weather.dart';
import 'package:tote_f/consumers/load_trip.dart';
import 'package:tote_f/models/trip/day.dart';
import 'package:tote_f/models/tote/tote.dart';
import 'package:tote_f/models/trip/weather.dart';
import 'package:tote_f/models/trip/trip.dart';
import 'package:tote_f/providers/trip_provider.dart';
import 'package:tote_f/providers/user_additional_items_provider.dart';
import 'package:tote_f/services/db_service.dart';

part 'create_trip_consumer.g.dart';

@riverpod
class CreateTripConsumer extends _$CreateTripConsumer {
  @override
  void build() {}

  void loadTrip(Trip trip) {
    ref.read(tripNotifierProvider.notifier).loadTrip(trip);
  }

  void updateDates(DateTimeRange newDates) {
    final currentTrip = ref.watch(tripNotifierProvider);
    final newTrip = currentTrip.copyWith(
        dateRange: DateTimeRange(start: newDates.start, end: newDates.end));
    loadTrip(newTrip);
  }

  void updateCity(String city) {
    final currentTrip = ref.watch(tripNotifierProvider);
    final newTrip = currentTrip.copyWith(city: city);
    loadTrip(newTrip);
  }

  Future<void> initializeNewTrip() async {
    final DatabaseService dbService = DatabaseService();
    final newId = await dbService.createTrip(defaultTrip);
    ref.read(loadTripProvider.notifier).loadTrip(newId);
  }

  List<Day> createDayListFromWeather(
      WeatherResponse weather, DateTimeRange dateRange) {
    if (weather.success == true &&
        weather.days != null &&
        weather.days!.isNotEmpty) {
      return weather.days!
          .map((Weather day) => Day(
                dayCode: day.dateTime.millisecondsSinceEpoch,
                day: day.dateTime,
                low: day.low,
                high: day.high,
                icon: day.icon,
                precip: day.precip,
                sunset: day.sunset,
                sunrise: day.sunrise,
                summary: day.summary,
              ))
          .toList();
    }
    List<Day> dayList = [];
    for (var day = dateRange.start;
        day.compareTo(dateRange.end) <= 0;
        day = day.add(const Duration(days: 1))) {
      dayList.add(Day.defaultDay(day));
    }
    return dayList;
  }

  Future<void> createTripFromSchedule({bool? reset = false}) async {
    final DatabaseService dbService = DatabaseService();
    final currentTrip = ref.watch(tripNotifierProvider);
    final weatherResponse =
        await fetchWeather(currentTrip.city, currentTrip.dateRange);
    final List<Day> dayList = createDayListFromWeather(weatherResponse, currentTrip.dateRange);
    final userAdditionalItemsAsync = await ref.watch(userAdditionalItemsProvider.future);
    final userData = userAdditionalItemsAsync;
    final newTrip = currentTrip.copyWith(
        days: dayList,
        tote: Tote.fromUserAdditionalItemsAndSections(
          named: [],
          unnamed: [],
          userData: userData,
        ));
    int? newId = newTrip.id;
    if (reset == true) {
      await dbService.saveTripById(newTrip, newTrip.id!);
    } else {
      newId = await dbService.createTrip(newTrip);
    }
    if (newId != null) {
      ref.read(loadTripProvider.notifier).loadTrip(newId);
    }
  }
}
