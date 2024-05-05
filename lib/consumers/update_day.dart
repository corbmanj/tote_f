import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tote_f/models/tote/day.dart';
import 'package:tote_f/models/trip.dart';
import 'package:tote_f/models/user/outfit_template.dart';
import 'package:tote_f/providers/trip_provider.dart';

part 'update_day.g.dart';

@riverpod
class UpdateDay extends _$UpdateDay {
  @override
  void build() {}
  
  void addOutfitToDay(
    int dayIndex,
    OutfitTemplate newType,
  ) {
    final Trip tripRef = ref.watch(tripNotifierProvider);
    Day newDay = tripRef.days[dayIndex].addOutfit(newType);
    ref.read(tripNotifierProvider.notifier).replaceDayAndUpdateTrip(tripRef, newDay);
  }
}
