import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tote_f/consumers/load_trip.dart';
import 'package:tote_f/fixtures/mock_trip.dart';
import 'package:tote_f/models/tote/day.dart';
import 'package:tote_f/models/tote/tote.dart';
import 'package:tote_f/models/trip.dart';
import 'package:tote_f/providers/trip_provider.dart';
import 'package:tote_f/services/db_service.dart';

part 'create_trip.g.dart';

@riverpod
class CreateTrip extends _$CreateTrip {
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

  void createTripFromSchedule({bool? reset = false}) async {
    final DatabaseService dbService = DatabaseService();
    final currentTrip = ref.watch(tripNotifierProvider);
    List<Day> dayList = [];
    for (var day = currentTrip.dateRange.start;
        day.compareTo(currentTrip.dateRange.end) <= 0;
        day = day.add(const Duration(days: 1))) {
      dayList
          .add(Day(day.millisecondsSinceEpoch, day, 0, 0, "", 0.0, 0, 0, ""));
    }
    final newTrip = currentTrip.copyWith(
        days: dayList,
        tote: Tote(
            named: [], unnamed: [], additionalItems: defaultAdditionalItems));
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
