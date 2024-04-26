import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tote_f/models/tote/day.dart';
import 'package:tote_f/models/trip.dart';
import 'package:tote_f/models/user/outfit_item.dart';
import 'package:tote_f/models/user/outfit_template.dart';
import 'package:tote_f/providers/trip_provider.dart';

part 'update_outfit.g.dart';

@riverpod
class UpdateOutfit extends _$UpdateOutfit {
  @override
  void build() {}
  
  void updateOutfitType(
    int dayIndex,
    int outfitOrdering,
    OutfitTemplate newType,
  ) {
    final Trip tripRef = ref.watch(tripNotifierProvider);
    Day newDay = tripRef.days[dayIndex].changeOutfitType(outfitOrdering, newType);
    ref.read(tripNotifierProvider.notifier).replaceDayAndUpdateTrip(tripRef, newDay);
  }

  void updateOutfitName(
    int dayIndex,
    int outfitOrdering,
    String newName,
  ) {
    final Trip tripRef = ref.watch(tripNotifierProvider);
    Day newDay = tripRef.days[dayIndex].changeOutfitName(outfitOrdering, newName);
    ref.read(tripNotifierProvider.notifier).replaceDayAndUpdateTrip(tripRef, newDay);
  }

  void selectItem(int dayIndex, int outfitOrdering, OutfitItem item, bool value) {
    final Trip tripRef = ref.watch(tripNotifierProvider);
    Day newDay = tripRef.days[dayIndex].selectOutfitItem(outfitOrdering: outfitOrdering, itemType: item.type, newSelected: value);
    ref.read(tripNotifierProvider.notifier).replaceDayAndUpdateTrip(tripRef, newDay);
  }
}
