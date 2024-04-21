import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tote_f/models/trip.dart';
import 'package:tote_f/providers/trip_provider.dart';

part 'load_trip.g.dart';

@riverpod
class LoadTrip extends _$LoadTrip {
  @override
  void build() {}
  
  void loadTrip(Trip trip) {
    ref.read(tripNotifierProvider.notifier).loadTrip(trip);
  }
}