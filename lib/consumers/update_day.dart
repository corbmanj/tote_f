import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tote_f/models/tote/day.dart';
import 'package:tote_f/models/trip.dart';
import 'package:tote_f/models/user/outfit_template.dart';
import 'package:tote_f/providers/outfit_list_expanded.dart';
import 'package:tote_f/providers/trip_provider.dart';

part 'update_day.g.dart';

@riverpod
class UpdateDay extends _$UpdateDay {
  @override
  void build() {}

  Future<void> addOutfitToDay(
    int dayIndex,
    OutfitTemplate newType,
  ) async {
    final Trip tripRef = ref.watch(tripNotifierProvider);
    final newOutfitIndex = tripRef.days[dayIndex].outfits!.length;
    Day newDay = tripRef.days[dayIndex].addOutfit(newType);
    await ref.read(outfitListExpandedProvider.notifier).setEditingAndExpanded(dayIndex, newOutfitIndex, true);
    ref
        .read(tripNotifierProvider.notifier)
        .replaceDayAndUpdateTrip(tripRef, newDay);
  }

  void expandOutfit(
    int dayIndex,
    int outfitIndex,
  ) {
    ref.read(outfitListExpandedProvider.notifier).setExpanded(dayIndex, outfitIndex);
  }

  void editOutfitName(bool newEditing) {
    ref.read(outfitListExpandedProvider.notifier).setEditing(newEditing);
  }
}
