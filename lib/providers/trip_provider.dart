import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tote_f/models/tote/additional_item_section.dart';
import 'package:tote_f/models/tote/day.dart';
import 'package:tote_f/models/tote/named.dart';
import 'package:tote_f/models/tote/unnamed.dart';
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

  Future<void> saveTrip(Trip updatedTrip) async {
    final DatabaseService dbService = DatabaseService();
    dbService.saveTripById(updatedTrip, updatedTrip.id ?? -1);
    loadTrip(updatedTrip);
  }

  Future<void> replaceDayAndUpdateTrip(Trip trip, Day newDay) async {
    Trip updatedTrip = trip.replaceDayInTrip(newDay.dayCode, newDay);
    saveTrip(updatedTrip);
  }

  void replaceNamedAndUpdateTrip(List<Named> namedList) {
    Trip updatedTrip = state;
    updatedTrip = updatedTrip.updateNamedList(namedList);
    saveTrip(updatedTrip);
  }

  void replaceUnnamedAndUpdateTrip(List<Unnamed> newList) {
    Trip updatedTrip = state;
    updatedTrip = updatedTrip.updateUnnamedList(newList);
    saveTrip(updatedTrip);
  }

  void replaceAdditionalItemsAndUpdateTrip(List<AdditionalItemSection> newAdditionalItems) {
    Trip updatedTrip = state;
    updatedTrip = updatedTrip.updateAdditionalItems(newAdditionalItems);
    saveTrip(updatedTrip);
  }
}
