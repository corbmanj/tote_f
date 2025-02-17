import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tote_f/models/trip/trip.dart';
import 'package:tote_f/providers/additional_items_provider.dart';
import 'package:tote_f/providers/named_items_provider.dart';
import 'package:tote_f/providers/trip_list_provider.dart';
import 'package:tote_f/providers/trip_provider.dart';
import 'package:tote_f/services/db_service.dart';

part 'load_trip.g.dart';

@riverpod
class LoadTrip extends _$LoadTrip {
  @override
  void build() {}
  
  void loadTrip (int tripId) async {
    final DatabaseService dbService = DatabaseService();
    final Trip trip = await dbService.getTripById(tripId);
    ref.read(tripNotifierProvider.notifier).loadTrip(trip);
    ref.read(namedItemsNotifierProvider.notifier).loadList(trip.tote != null ? trip.tote!.named : []);
    ref.read(additionalItemsNotifierProvider.notifier).loadList(trip.tote != null ? trip.tote!.additionalItems : []);
  }

  void deleteTrip (int tripId) async {
    final DatabaseService dbService = DatabaseService();
    await dbService.deleteTripById(tripId);
    ref.invalidate(tripListProvider);
  }
}