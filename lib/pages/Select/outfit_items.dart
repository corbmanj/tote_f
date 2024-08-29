import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tote_f/consumers/update_outfit.dart';
import 'package:tote_f/models/tote/outfit.dart';
import 'package:tote_f/models/user/outfit_item.dart';
import 'package:tote_f/providers/trip_provider.dart';

class OutfitItems extends ConsumerWidget {
  final Outfit? outfit;
  final int dayIndex;
  const OutfitItems({super.key, required this.outfit, required this.dayIndex});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (outfit == null) {
      return const Placeholder();
    }
    return Wrap(
      children: outfit!.items
          .map((item) => _buildItem(item, dayIndex, outfit!.ordering, ref))
          .toList(),
    );
  }

  Widget _buildItem(
      OutfitItem item, int dayIndex, int outfitOrdering, WidgetRef ref) {
    final itemRef = ref.watch(tripNotifierProvider.select((trip) {
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
              .read(updateOutfitProvider.notifier)
              .selectItem(dayIndex, outfitOrdering, item, value);
        },
      ),
    );
  }
}
