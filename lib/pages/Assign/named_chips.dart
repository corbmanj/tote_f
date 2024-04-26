import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tote_f/consumers/update_named.dart';
import 'package:tote_f/models/tote/named.dart';
import 'package:tote_f/models/user/outfit_item.dart';
import 'package:tote_f/pages/Assign/editable_chip.dart';
import 'package:tote_f/providers/named_items_provider.dart';

class NamedChips extends ConsumerWidget {
  final OutfitItem selectedItem;
  final int dayIndex;
  final int outfitOrdering;
  const NamedChips({
    super.key,
    required this.selectedItem,
    required this.dayIndex,
    required this.outfitOrdering,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Named> namedItemsRef = ref.watch(namedItemsNotifierProvider);
    final updateNamedNotifier = ref.read(updateNamedProvider.notifier);
    final namedItemsList = namedItemsRef
        .where((Named named) => named.parentType == selectedItem.parentType)
        .map((Named named) => EditableChip(
              namedItem: named,
              // todo, don't pass isSelected, past the outfitItem
              outfitItem: selectedItem,
              dayIndex: dayIndex,
              outfitOrdering: outfitOrdering,
            ))
        .toList();
    return Expanded(
      child: Wrap(
        spacing: 4.0,
        runSpacing: 8.0,
        children: [
          ...namedItemsList,
          ElevatedButton(
              onPressed: () {
                if (selectedItem.parentType != null) {
                  updateNamedNotifier.addNamed(selectedItem.parentType!);
                }
              },
              child: const Text('add item'))
        ],
      ),
    );
  }
}
