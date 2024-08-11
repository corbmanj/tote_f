import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tote_f/consumers/update_named.dart';
import 'package:tote_f/models/tote/named.dart';
import 'package:tote_f/models/user/outfit_item.dart';
import 'package:tote_f/shared/dry_layout_stop_gap.dart';

class EditableChip extends ConsumerStatefulWidget {
  final Named namedItem;
  final OutfitItem outfitItem;
  final int dayIndex;
  final int outfitOrdering;
  final void Function(bool) setParentEditing;
  const EditableChip({
    super.key,
    required this.namedItem,
    required this.outfitItem,
    required this.dayIndex,
    required this.outfitOrdering,
    required this.setParentEditing,
  });

  @override
  ConsumerState createState() => _EditableChipState();
}

class _EditableChipState extends ConsumerState<EditableChip> {
  late TextEditingController _controller;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void setEditing(bool newValue) {
    setState(() {
      _isEditing = newValue;
    });
    widget.setParentEditing(newValue);
  }

  @override
  Widget build(BuildContext context) {
    final bool isSelected =
        widget.outfitItem.namedItemId == widget.namedItem.ordering;
    final namedController = ref.read(updateNamedProvider.notifier);
    if (_isEditing || widget.namedItem.ordering == -1) {
      _controller.text = widget.namedItem.name;
      _controller.selection =
          TextSelection(baseOffset: 0, extentOffset: _controller.text.length);
      return Wrap(
        children: [
          DryIntrinsicWidth(
            child: TextField(
              autofocus: true,
              controller: _controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Item name',
              ),
              onSubmitted: (String? value) async {
                if (value != null) {
                  namedController.updateNameAndSelect(
                    value,
                    widget.namedItem.ordering,
                    widget.dayIndex,
                    widget.outfitOrdering,
                    widget.outfitItem.type,
                  );
                }
                setEditing(false);
              },
              onTapOutside: (ev) {
                if (_controller.text != "") {
                  namedController.updateNameAndSelect(
                    _controller.text,
                    widget.namedItem.ordering,
                    widget.dayIndex,
                    widget.outfitOrdering,
                    widget.outfitItem.type,
                  );
                }
                setEditing(false);
              },
            ),
          )
        ],
      );
    }
    return GestureDetector(
      child: ChoiceChip(
        selected: isSelected,
        label: Text(widget.namedItem.name),
        onSelected: (bool val) {
          namedController.selectNamedItem(
            widget.dayIndex,
            widget.outfitOrdering,
            widget.outfitItem.type,
            widget.namedItem.ordering,
          );
        },
      ),
      onLongPress: () => setEditing(true),
      onDoubleTap: () => setEditing(true),
    );
  }
}
