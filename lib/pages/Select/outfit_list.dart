import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tote_f/pages/Select/outfit_header.dart';
import 'package:tote_f/pages/Select/outfit_items.dart';
import '../../view_models/expansion_outfit.dart';

final expansionProvider = StateProvider<List<int>>((ref) => [-1, -1]);

class OutfitList extends ConsumerWidget {
  final int dayIndex;
  final List<ExpansionOutfit> outfits;
  const OutfitList({super.key, required this.outfits, required this.dayIndex});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      child: _buildPanel(dayIndex, ref),
    );
  }

  Widget _buildPanel(int dayIndex, WidgetRef ref) {
    final expansionRef = ref.watch(expansionProvider);
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        ref.read(expansionProvider.notifier).state =
            isExpanded ? [dayIndex, index] : [-1, -1];
      },
      children: outfits.map<ExpansionPanel>((ExpansionOutfit outfit) {
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return OutfitHeader(isExpanded: isExpanded, outfit: outfit, dayIndex: dayIndex);
          },
          body: OutfitItems(outfit: outfit.expandedValue, dayIndex: dayIndex),
          isExpanded: expansionRef == [-1, -1]
              ? false
              : expansionRef[0] == dayIndex &&
                  outfit.expandedValue.ordering ==
                      outfits[expansionRef[1]].expandedValue.ordering,
        );
      }).toList(),
    );
  }
}
