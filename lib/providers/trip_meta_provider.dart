import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tote_f/models/trip_meta.dart';

part 'trip_meta_provider.g.dart';

@riverpod
class TripMetaNotifier extends _$TripMetaNotifier {
  @override
  TripMeta build() {
    return defaultTripMeta;
  }

  void loadTripMeta(TripMeta tripMeta) {
    state = tripMeta;
  }

  void updateName(String name) {
    state = state.copyWith(name: name);
  }

  void updateCity(String city) {
    state = state.copyWith(city: city);
  }

  void updateDates(DateTimeRange dates) {
    state = state.copyWith(dateRange: dates);
  }

  void reset() {
    state = defaultTripMeta;
  }
}