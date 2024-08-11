import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tote_f/consumers/update_additional.dart';
import 'package:tote_f/models/tote/additional_item.dart';
import 'package:tote_f/models/tote/additional_item_section.dart';
import 'package:tote_f/shared/dry_layout_stop_gap.dart';

class EditableAdditionalChip extends ConsumerStatefulWidget {
  final AdditionalItem item;
  final AdditionalItemSection section;
  final void Function(bool) setParentEditing;
  const EditableAdditionalChip({
    super.key,
    required this.item,
    required this.section,
    required this.setParentEditing,
  });

  @override
  ConsumerState createState() => _EditableAdditionalChipState();
}

class _EditableAdditionalChipState
    extends ConsumerState<EditableAdditionalChip> {
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
    final additionalItemsController =
        ref.read(updateAdditionalProvider.notifier);
    if (_isEditing || widget.item.name == 'New Item') {
      _controller.text = widget.item.name;
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
                  additionalItemsController.renameAdditionalItem(
                    widget.item,
                    widget.section,
                    value,
                  );
                }
                setEditing(false);
              },
              onTapOutside: (ev) {
                if (_controller.text != "") {
                  additionalItemsController.renameAdditionalItem(
                    widget.item,
                    widget.section,
                    _controller.text,
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
        selected: widget.item.included,
        label: Text(widget.item.name),
        onSelected: (bool val) {
          additionalItemsController.selectAdditionalItem(
              widget.item, widget.section, !widget.item.included);
        },
      ),
      onLongPress: () => setEditing(true),
      onDoubleTap: () => setEditing(true),
    );
  }
}
