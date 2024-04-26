import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tote_f/providers/assign_items_state.dart';
import 'package:tote_f/view_models/expansion_outfit.dart';
import 'assign_outfit_items.dart';

class AssignOutfitList extends ConsumerWidget {
  final List<ExpansionOutfit> outfits;
  final int dayIndex;
  const AssignOutfitList({
    super.key,
    required this.outfits,
    required this.dayIndex,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      child: _buildPanel(ref),
    );
  }

  Widget _buildPanel(WidgetRef ref) {
    final assignItemNotifier = ref.read(assignItemsStateProvider.notifier);
    final isExpandedRef = ref.watch(assignItemsStateProvider).expanded;
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        assignItemNotifier.setExpanded(dayIndex, index);
      },
      children: outfits.asMap().entries.map<ExpansionPanel>((entry) {
        final int idx = entry.key;
        final ExpansionOutfit outfit = entry.value;
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) =>
              Text(outfit.headerValue),
          body: AssignOutfitItems(
            outfit: outfit.expandedValue,
            dayIndex: dayIndex,
          ),
          isExpanded: isExpandedRef[0] == dayIndex && isExpandedRef[1] == idx,
        );
      }).toList(),
    );
  }
}
