import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tote_f/models/trip/outfit.dart';
import 'package:tote_f/models/trip/outfit_item.dart';
import 'package:tote_f/pages/Assign/named_chips.dart';
import 'package:tote_f/pages/Assign/named_items_for_outfit.dart';
import 'package:tote_f/providers/assign_items_state.dart';
import 'package:tote_f/providers/trip_provider.dart';

class AssignOutfitItems extends ConsumerWidget {
  final Outfit outfit;
  final int dayIndex;
  final bool isExpanded;
  const AssignOutfitItems({
    super.key,
    required this.outfit,
    required this.dayIndex,
    required this.isExpanded,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (!isExpanded) {
      return Container();
    }
    final selectedItemRef = ref.watch(assignItemsStateProvider).selected;
    final assignItemStateNotifier = ref.read(assignItemsStateProvider.notifier);
    final outfitItems = outfit.items
        .where((item) => item.generic == false && !!item.selected!)
        .toList();
    if (outfitItems.isEmpty) {
      return const Center(child: Text('No items to assign.'));
    }
    OutfitItem selectedOutfitItem = selectedItemRef ??
        outfitItems.firstWhere(
            (item) =>
                selectedItemRef != null && item.type == selectedItemRef.type,
            orElse: () => outfitItems[0]);
    final outfitItemRef = ref.watch(tripNotifierProvider.select((trip) => trip
        .days[dayIndex].outfits![outfit.ordering].items
        .firstWhere((item) => selectedOutfitItem.type == item.type)));
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 4),
          child: IntrinsicHeight(
            child: Row(
              children: [
                Column(
                    children: outfitItems
                        .map((OutfitItem item) => GestureDetector(
                              child: Text(
                                item.type,
                                style: item.type == selectedOutfitItem.type
                                    ? const TextStyle(color: Colors.blue)
                                    : null,
                              ),
                              onTap: () =>
                                  assignItemStateNotifier.setSelectedItem(item),
                            ))
                        .toList()),
                const VerticalDivider(
                  thickness: 2,
                  color: Colors.grey,
                ),
                NamedChips(
                    selectedItem: outfitItemRef,
                    dayIndex: dayIndex,
                    outfitOrdering: outfit.ordering)
              ],
            ),
          ),
        ),
        NamedItemsForOutfit(outfit: outfit),
      ],
    );
  }
}
