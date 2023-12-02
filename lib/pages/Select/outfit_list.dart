import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tote_f/pages/Select/outfit_items.dart';
import 'package:tote_f/shared/Select.dart';
import '../../models/user/outfit_template.dart';
import '../../view_models/expansion_outfit.dart';
import '../../fixtures/mock_trip.dart';

final expansionProvider = StateProvider<List<int>>((ref) => [-1, -1]);

class OutfitList extends HookConsumerWidget {
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
            isExpanded ? [-1, -1] : [dayIndex, index];
      },
      children: outfits.map<ExpansionPanel>((ExpansionOutfit outfit) {
        final List<OutfitTemplate> optionsList =
            outfitTypeList; // will eventually be a list of the user's outfit types
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text(outfit.headerValue),
              trailing: Select(
                options: optionsList,
                typeFinal: optionsList.firstWhere((element) =>
                    outfit.expandedValue.type.toLowerCase() ==
                    element.type.toLowerCase()),
                dayIndex: dayIndex,
                ordering: outfit.expandedValue.ordering,
              ),
              onLongPress: () {
                print('long pressed');
              },
            );
          },
          body: OutfitItems(outfit: outfit.expandedValue, dayIndex: dayIndex),
          isExpanded: expansionRef == [dayIndex, -1]
              ? false
              : expansionRef[0] == dayIndex &&
                  outfit.expandedValue.ordering ==
                      outfits[expansionRef[1]].expandedValue.ordering,
        );
      }).toList(),
    );
  }
}
