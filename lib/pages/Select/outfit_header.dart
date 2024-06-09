import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tote_f/consumers/update_day.dart';
import 'package:tote_f/fixtures/mock_trip.dart';
import 'package:tote_f/models/user/outfit_template.dart';
import 'package:tote_f/pages/Select/outfit_name_edit.dart';
import 'package:tote_f/pages/Select/select_outfit_type.dart';
import 'package:tote_f/providers/outfit_list_expanded.dart';
import 'package:tote_f/view_models/expansion_outfit.dart';

final editingProvider = StateProvider<bool>((ref) => false);

class OutfitHeader extends ConsumerWidget {
  final bool isExpanded;
  final ExpansionOutfit outfit;
  final int dayIndex;
  const OutfitHeader(
      {super.key,
      required this.isExpanded,
      required this.outfit,
      required this.dayIndex});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<OutfitTemplate> optionsList =
        outfitTypeList; // will eventually be a list of the user's outfit types
    final editingRef = ref.watch(outfitListExpandedProvider);
    final setEditing = ref.read(updateDayProvider.notifier).editOutfitName;
    final setExpanded = ref.read(updateDayProvider.notifier).expandOutfit;
    final isEditing = editingRef.editing &&
        editingRef.expanded[0] == dayIndex &&
        editingRef.expanded[1] == outfit.ordering;
    if (isEditing == true) {
      return OutfitNameEditor(
        setEditing: setEditing,
        dayIndex: dayIndex,
        ordering: outfit.ordering,
        currentName: outfit.headerValue,
      );
    }

    return ListTile(
      title: Text(outfit.headerValue),
      onTap: () {
        if (isExpanded) {
          setEditing(true);
        } else {
          setExpanded(dayIndex, outfit.ordering);
        }
      },
      trailing: SelectOutfitType(
        options: optionsList,
        dayIndex: dayIndex,
        ordering: outfit.expandedValue.ordering,
      ),
    );
  }
}
