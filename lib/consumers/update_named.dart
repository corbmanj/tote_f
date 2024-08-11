import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tote_f/models/tote/day.dart';
import 'package:tote_f/models/tote/named.dart';
import 'package:tote_f/models/trip.dart';
import 'package:tote_f/providers/named_items_provider.dart';
import 'package:tote_f/providers/trip_provider.dart';

part 'update_named.g.dart';

@riverpod
class UpdateNamed extends _$UpdateNamed {
  @override
  void build() {}

  void addNamed(String parentType) {
    final newItem = Named('new name', parentType, -1);
    ref.read(namedItemsNotifierProvider.notifier).addNamed(newItem);
  }

  void updateNameAndSelect(String newName, int ordering, int dayIndex, int outfitOrdering, String itemType) async {
    Named newItem = ref.read(namedItemsNotifierProvider.notifier).updateName(newName, ordering);
    selectNamedItem(dayIndex, outfitOrdering, itemType, newItem.ordering);
  }

  void selectNamedItem(
    int dayIndex,
    int outfitOrdering,
    String itemType,
    int namedItemId,
  ) {
    final Trip tripRef = ref.watch(tripNotifierProvider);
    Day newDay = tripRef.days[dayIndex].nameOutfitItem(
        outfitOrdering: outfitOrdering,
        itemType: itemType,
        newNamedId: namedItemId);
    ref
        .read(tripNotifierProvider.notifier)
        .replaceDayAndUpdateTrip(tripRef, newDay);
  }

  void packNamedItem(Named namedItem, bool isPacked) {
    ref.read(namedItemsNotifierProvider.notifier).packNamed(namedItem, isPacked);
  }
}
