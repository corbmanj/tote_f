import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tote_f/fixtures/mock_trip.dart';
import 'package:tote_f/models/user/outfit_template.dart';
import 'package:tote_f/pages/Select/outfit_name_edit.dart';
import 'package:tote_f/pages/Select/select_outfit_type.dart';
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
  ConsumerState<OutfitHeader> createState() => _OutfitHeaderState();
}

class _OutfitHeaderState extends ConsumerState<OutfitHeader> {
  bool _editing = false;

  void setEditing(bool? newEditing) {
    setState(() {
      _editing = newEditing ?? !_editing;
    });
  }

  final List<OutfitTemplate> optionsList =
      outfitTypeList; // will eventually be a list of the user's outfit types

  @override
  Widget build(BuildContext context) {
    if (_editing == true) {
      return OutfitNameEditor(
        setEditing: setEditing,
        dayIndex: widget.dayIndex,
        ordering: widget.outfit.ordering,
        currentName: widget.outfit.headerValue,
      );
    }

    return ListTile(
      title: Text(widget.outfit.headerValue),
      onTap: () {
        setEditing(true);
      },
      trailing: SelectOutfitType(
        options: optionsList,
        dayIndex: widget.dayIndex,
        ordering: widget.outfit.expandedValue.ordering,
      ),
    );
  }
}
