import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tote_f/consumers/update_named.dart';
import 'package:tote_f/models/tote/named.dart';
import 'package:tote_f/shared/dry_layout_stop_gap.dart';

class EditableChip extends ConsumerStatefulWidget {
  final Named namedItem;
  const EditableChip({super.key, required this.namedItem});

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
  }

  @override
  Widget build(BuildContext context) {
    if (_isEditing || widget.namedItem.ordering == -1) {
      _controller.text = widget.namedItem.name;
      _controller.selection = TextSelection(baseOffset: 0, extentOffset: _controller.text.length);
      final namedController = ref.read(updateNamedProvider.notifier);
      return Wrap(
        children: [DryIntrinsicWidth(
          child: TextField(
            autofocus: true,
            controller: _controller,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Item name',
            ),
            onSubmitted: (String? value) {
              if (value != null) {
                namedController.updateName(value, widget.namedItem.ordering);
              }
              setEditing(false);
            },
            onTapOutside: (ev) => setEditing(false),
          ),
        )],
      );
    }
    return GestureDetector(
      child: ChoiceChip(
        selected: true,
        label: Text(widget.namedItem.name),
        onSelected: (bool val) {
          print(widget.namedItem.name);
        },
      ),
      onLongPress: () => setEditing(true),
      onDoubleTap: () => setEditing(true),
    );
  }
}
