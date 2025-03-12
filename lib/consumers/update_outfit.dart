import 'package:collection/collection.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tote_f/models/trip/day.dart';
import 'package:tote_f/models/trip/outfit.dart';
import 'package:tote_f/models/trip/trip.dart';
import 'package:tote_f/models/trip/outfit_item.dart';
import 'package:tote_f/models/user/item_template.dart';
import 'package:tote_f/models/user/outfit_template.dart';
import 'package:tote_f/models/user/user_outfit_item.dart';
import 'package:tote_f/providers/trip_provider.dart';
import 'package:tote_f/providers/user_items_provider.dart';

part 'update_outfit.g.dart';

@riverpod
class UpdateOutfit extends _$UpdateOutfit {
  @override
  void build() {}

  List<OutfitItem> createItems(
    List<UserOutfitItem> userOutfitItems, List<ItemTemplate> templateItems) {
  final List<OutfitItem> result = [];
  for (final item in userOutfitItems) {
    final itemToAdd = templateItems
        .firstWhereOrNull((template) => item.itemId == template.id);
    if (itemToAdd != null) {
      result.add(OutfitItem(
        itemToAdd.name,
        itemToAdd.grouping ?? "",
        itemToAdd.generic,
        item.defaultIncluded,
      ));
    }
  }
  return result;
}

  Future<Outfit> createOutfitFromTemplate(
    OutfitTemplate template,
    int newOrdering, [
    String? newName,
  ]) async {
    final itemsRef = await ref.watch(userItemsProvider.future);
    return Outfit(
      templateId: template.id,
      type: template.type,
      name: newName ?? template.type,
      items: createItems(template.outfitItems, itemsRef.userItems),
      ordering: newOrdering,
    );
  }

  Future<void> updateOutfitType(
    int dayIndex,
    int outfitOrdering,
    OutfitTemplate newType,
  ) async {
    final Trip tripRef = ref.watch(tripNotifierProvider);
    final Outfit newOutfit = await createOutfitFromTemplate(newType, outfitOrdering);
    Day newDay =
        tripRef.days[dayIndex].changeOutfitType(outfitOrdering, newOutfit);
    ref
        .read(tripNotifierProvider.notifier)
        .replaceDayAndUpdateTrip(tripRef, newDay);
  }

  void updateOutfitName(
    int dayIndex,
    int outfitOrdering,
    String newName,
  ) {
    final Trip tripRef = ref.watch(tripNotifierProvider);
    Day newDay =
        tripRef.days[dayIndex].changeOutfitName(outfitOrdering, newName);
    ref
        .read(tripNotifierProvider.notifier)
        .replaceDayAndUpdateTrip(tripRef, newDay);
  }

  void selectItem(
      int dayIndex, int outfitOrdering, OutfitItem item, bool value) {
    final Trip tripRef = ref.watch(tripNotifierProvider);
    Day newDay = tripRef.days[dayIndex].selectOutfitItem(
        outfitOrdering: outfitOrdering,
        itemType: item.type,
        newSelected: value);
    ref
        .read(tripNotifierProvider.notifier)
        .replaceDayAndUpdateTrip(tripRef, newDay);
  }

  void copyOutfitToDays(List<int> daysToCopyTo, Outfit outfit) {
    final Trip tripRef = ref.watch(tripNotifierProvider);
    final updatedTrip = tripRef.copyOutfitToDays(daysToCopyTo, outfit);
    ref.read(tripNotifierProvider.notifier).saveTrip(updatedTrip);
  }
}
