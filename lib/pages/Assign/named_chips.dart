import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tote_f/models/tote/named.dart';
import 'package:tote_f/models/user/outfit_item.dart';
import 'package:tote_f/providers/named_items_provider.dart';

class NamedChips extends ConsumerWidget {
  final OutfitItem selectedItem;
  const NamedChips({super.key, required this.selectedItem});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Named> namedItemsRef = ref.watch(namedItemsNotifierProvider);
    return Expanded(
      child: Wrap(
        spacing: 4.0,
        runSpacing: 8.0,
        children: namedItemsRef
            .where((Named named) => named.parentType == selectedItem.parentType)
            .map((Named named) => ChoiceChip(
                  selected: true,
                  label: Text(named.name),
                  onSelected: (bool val) { print(named.name);},
                ))
            .toList(),
      ),
    );
  }
}
