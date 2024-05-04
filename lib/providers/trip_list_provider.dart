
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tote_f/models/trip_meta.dart';
import 'package:tote_f/services/db_service.dart';

part 'trip_list_provider.g.dart';

@riverpod
class TripList extends _$TripList {
  @override
  Future<List<TripMeta>> build() async {
    final DatabaseService dbService = DatabaseService();
    Future<List<TripMeta>> tripList = dbService.tripList();
    return tripList;
  }
}