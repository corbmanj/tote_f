import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:tote_f/consumers/update_day.dart';
import 'package:tote_f/fixtures/mock_trip.dart';
import 'package:tote_f/models/tote/day.dart';
import 'package:tote_f/models/tote/outfit.dart';
import 'package:tote_f/models/trip.dart';
import 'package:tote_f/models/user/outfit_template.dart';
import 'package:tote_f/pages/Select/outfit_name_edit.dart';
import 'package:tote_f/pages/Select/select_outfit_type.dart';
import 'package:tote_f/providers/outfit_list_expanded.dart';
import 'package:tote_f/providers/trip_provider.dart';
import 'package:tote_f/view_models/expansion_outfit.dart';

final editingProvider = StateProvider<bool>((ref) => false);

class OutfitHeader extends ConsumerStatefulWidget {
  final bool isExpanded;
  final ExpansionOutfit outfit;
  final int dayIndex;
  const OutfitHeader(
      {super.key,
      required this.isExpanded,
      required this.outfit,
      required this.dayIndex});

  @override
  ConsumerState createState() => _OutfitHeaderState();
}

class _OutfitHeaderState extends ConsumerState<OutfitHeader> {
  Outfit? _selectedOutfit;

  void setSelectedOutfit(Outfit newSelected) {
    _selectedOutfit = newSelected;
  }

  @override
  Widget build(BuildContext context) {
    void openMenu(Outfit newSelected) {
      setSelectedOutfit(newSelected);
      if (_selectedOutfit != null) {
        showModalBottomSheet(
          context: context,
          builder: (context) => OutfitActions(outfit: _selectedOutfit!, dayIndex: widget.dayIndex),
        );
      }
    }

    final List<OutfitTemplate> optionsList =
        outfitTypeList; // will eventually be a list of the user's outfit types
    final editingRef = ref.watch(outfitListExpandedProvider);
    final setEditing = ref.read(updateDayProvider.notifier).editOutfitName;
    final setExpanded = ref.read(updateDayProvider.notifier).expandOutfit;
    final isEditing = editingRef.editing &&
        editingRef.expanded[0] == widget.dayIndex &&
        editingRef.expanded[1] == widget.outfit.ordering;

    return ListTile(
      leading: GestureDetector(
        onTap: () => openMenu(widget.outfit.expandedValue),
        child: const Icon(Icons.menu),
      ),
      title: isEditing
          ? OutfitNameEditor(
              setEditing: setEditing,
              dayIndex: widget.dayIndex,
              ordering: widget.outfit.ordering,
              currentName: widget.outfit.headerValue,
            )
          : Text(widget.outfit.headerValue),
      trailing: SelectOutfitType(
        options: optionsList,
        dayIndex: widget.dayIndex,
        ordering: widget.outfit.expandedValue.ordering,
      ),
      onTap: () {
        if (widget.isExpanded) {
          setEditing(true);
        } else {
          setExpanded(widget.dayIndex, widget.outfit.ordering);
        }
      },
    );
  }
}

class OutfitActions extends ConsumerWidget {
  final Outfit outfit;
  final int dayIndex;
  const OutfitActions({super.key, required this.outfit, required this.dayIndex});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Day> daysRef = ref.watch(tripNotifierProvider.select((Trip trip) => trip.days));

    final Day day = daysRef[dayIndex];
    final dateString = DateFormat('E, MMM d').format(day.day);

    return Row(
      children: [
        Column(
          children: [
            Text('${outfit.name} on $dateString'),
            ElevatedButton(
              onPressed: () => {},
              child: const Text('Copy Outfit'),
            ),
            ElevatedButton(
              onPressed: () => {},
              child: const Text('Delete Outfit'),
            ),
            // const Expanded(
            //   child: ListTile(
            //     leading: Icon(Icons.copy_all),
            //     title: Text('Copy Outfit'),
            //   ),
            // )
          ],
        )
      ],
    );
  }
}
