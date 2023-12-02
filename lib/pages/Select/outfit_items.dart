import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tote_f/models/tote/outfit.dart';
import 'package:tote_f/models/trip.dart';
import 'package:tote_f/models/user/outfit_item.dart';

class OutfitItems extends HookConsumerWidget {
  final Outfit outfit;
  final int dayIndex;
  const OutfitItems({super.key, required this.outfit, required this.dayIndex});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final outfitRef = ref.watch(tripProvider.select((trip) => trip
        .days[dayIndex].outfits
        ?.firstWhere((element) => element.ordering == outfit.ordering)));
    if (outfitRef == null) {
      return const Placeholder();
    }
    return Wrap(
      children: outfitRef.items
          .map((item) => _buildItem(item, dayIndex, outfit.ordering, ref))
          .toList(),
    );
  }

  Widget _buildItem(
      OutfitItem item, int dayIndex, int outfitOrdering, WidgetRef ref) {
    final itemRef = ref.watch(tripProvider.select((trip) {
      try {
        return trip.days[dayIndex].outfits
            ?.firstWhere((element) => element.ordering == outfitOrdering)
            .items
            .firstWhere((element) => element.type == item.type);
      } catch (e) {
        return null;
      }
    }));
    if (itemRef == null) {
      return const Placeholder();
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FilterChip(
        label: Text(item.type),
        selected: itemRef.selected ?? false,
        showCheckmark: false,
        selectedColor: Colors.lightBlueAccent,
        onSelected: (bool value) {
          ref
              .read(tripProvider.notifier)
              .selectItem(dayIndex, outfitOrdering, item, value);
        },
      ),
    );
  }
}
