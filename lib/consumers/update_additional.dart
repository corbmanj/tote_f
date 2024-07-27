import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tote_f/models/tote/additional_item.dart';
import 'package:tote_f/models/tote/additional_item_section.dart';
import 'package:tote_f/models/tote/day.dart';
import 'package:tote_f/models/trip.dart';
import 'package:tote_f/providers/additional_items_provider.dart';
import 'package:tote_f/providers/trip_provider.dart';

part 'update_additional.g.dart';

@riverpod
class UpdateAdditional extends _$UpdateAdditional {
  @override
  void build() {}

  void addAdditionalToSection(AdditionalItemSection section) {
    final newItem = AdditionalItem('New Item', true);
    section.addItem(newItem);
    ref.read(additionalItemsNotifierProvider.notifier).updateSectionInList(section);
  }

  void selectAdditionalItem(AdditionalItem item, AdditionalItemSection section, bool isSelected) {
    item.updateSelected(isSelected);
    section.updateItem(item, item.name);
    ref.read(additionalItemsNotifierProvider.notifier).updateSectionInList(section);
  }

  void renameAdditionalItem(AdditionalItem item, AdditionalItemSection section, String newName) {
    final oldName = item.name;
    item.updateName(newName);
    section.updateItem(item, oldName);
    ref.read(additionalItemsNotifierProvider.notifier).updateSectionInList(section);
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
}
