import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tote_f/models/tote/day.dart';
import 'package:tote_f/models/trip.dart';
import 'package:tote_f/services/db_service.dart';

part 'trip_provider.g.dart';

@riverpod
class TripNotifier extends _$TripNotifier {
  @override
  Trip build() {
    return Trip(
      city: "",
      days: [],
      dateRange: DateTimeRange(start: DateTime.now(), end: DateTime.now()),
    );
  }

  void loadTrip(Trip trip) {
    state = trip;
  }

  void replaceDayAndUpdateTrip(Trip trip, Day newDay) {
    final DatabaseService dbService = DatabaseService();
    Trip updatedTrip = trip.replaceDayInTrip(newDay.dayCode, newDay);
    dbService.saveTripById(updatedTrip, updatedTrip.id ?? -1);
    loadTrip(updatedTrip);
  }
}
