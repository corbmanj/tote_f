import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tote_f/models/trip/trip.dart';
import 'package:tote_f/providers/additional_items_provider.dart';
import 'package:tote_f/providers/named_items_provider.dart';
import 'package:tote_f/providers/trip_list_provider.dart';
import 'package:tote_f/providers/trip_provider.dart';
import 'package:tote_f/providers/unnamed_items_provider.dart';
import 'package:tote_f/services/db_service.dart';

part 'load_trip.g.dart';

@riverpod
class LoadTrip extends _$LoadTrip {
  @override
  void build() {}
  
  void loadTrip (int tripId) async {
    final DatabaseService dbService = DatabaseService();
    final Trip trip = await dbService.getTripById(tripId);
    ref.read(tripProvider.notifier).loadTrip(trip);
    ref.read(namedItemsProvider.notifier).loadList(trip.tote != null ? trip.tote!.named : []);
    ref.read(additionalItemsProvider.notifier).loadList(trip.tote != null ? trip.tote!.additionalItems : []);
    ref.read(unnamedItemsProvider.notifier).initializeFromTote(trip.tote != null ? trip.tote!.unnamed : []);
  }

  void deleteTrip (int tripId) async {
    final DatabaseService dbService = DatabaseService();
    await dbService.deleteTripById(tripId);
    ref.invalidate(tripListProvider);
  }
}