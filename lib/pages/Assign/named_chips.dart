import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tote_f/consumers/update_named.dart';
import 'package:tote_f/models/tote/named.dart';
import 'package:tote_f/models/user/outfit_item.dart';
import 'package:tote_f/pages/Assign/editable_chip.dart';
import 'package:tote_f/providers/named_items_provider.dart';

class NamedChips extends ConsumerStatefulWidget {
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
  ConsumerState createState() => _NamedChipState();
}

class _NamedChipState extends ConsumerState<NamedChips> {
  dynamic _isEditing = false;

  void setEditing(bool newValue) {
    setState(() {
      _isEditing = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Named> namedItemsRef = ref.watch(namedItemsNotifierProvider);
    final namedController = ref.read(updateNamedProvider.notifier);
    final namedItemsList = namedItemsRef
        .where(
            (Named named) => named.parentType == widget.selectedItem.parentType)
        .map((Named named) => EditableChip(
              namedItem: named,
              outfitItem: widget.selectedItem,
              dayIndex: widget.dayIndex,
              outfitOrdering: widget.outfitOrdering,
              setParentEditing: setEditing,
            ))
        .toList();
    return Expanded(
      child: Wrap(
        spacing: 4.0,
        runSpacing: 8.0,
        children: [
          ...namedItemsList,
          _isEditing ? Container() : ElevatedButton(
              onPressed: () {
                if (widget.selectedItem.parentType != null) {
                  namedController.addNamed(widget.selectedItem.parentType!);
                  setEditing(true);
                }
              },
              child: const Text('add item'))
        ],
      ),
    );
  }
}
