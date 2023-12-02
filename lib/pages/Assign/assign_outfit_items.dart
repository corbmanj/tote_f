import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tote_f/models/tote/outfit.dart';
import 'package:tote_f/models/user/outfit_item.dart';

class AssignOutfitItems extends HookConsumerWidget {
  final Outfit outfit;
  final int dayIndex;
  const AssignOutfitItems({
    super.key,
    required this.outfit,
    required this.dayIndex,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = outfit.items
        .where((item) =>
            !!item.hasDropdown && item.selected != null && !!item.selected!)
        // .map((item) => Text(item.type))
        .toList();
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 4),
          child: IntrinsicHeight(
            child: Row(
              children: [
                Column(
                    children: items
                        .map((OutfitItem item) => Text(item.type))
                        .toList()),
                const VerticalDivider(
                  thickness: 2,
                  color: Colors.grey,
                ),
                Expanded(
                    child: Column(
                        children: items
                            .map((OutfitItem item) => Text(item.type))
                            .toList())),
              ],
            ),
          ),
        ),
        const Text("here goes the list of assigned items as chips")
      ],
    );
  }
}
