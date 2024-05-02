import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tote_f/models/tote/day.dart';
import 'package:tote_f/models/trip.dart';

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
    Trip updatedTrip = trip.replaceDayInTrip(newDay.dayCode, newDay);
    loadTrip(updatedTrip);
  }
}
