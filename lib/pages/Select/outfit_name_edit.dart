import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tote_f/consumers/update_outfit.dart';

class OutfitNameEditor extends ConsumerStatefulWidget {
  final Function setEditing;
  final int dayIndex;
  final int ordering;
  final String currentName;
  const OutfitNameEditor(
      {super.key,
      required this.setEditing,
      required this.dayIndex,
      required this.ordering,
      required this.currentName});

  @override
  ConsumerState<OutfitNameEditor> createState() => _OutfitNameEditorState();
}

class _OutfitNameEditorState extends ConsumerState<OutfitNameEditor> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _controller.text = widget.currentName;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final updateOutfitConsumer = ref.read(updateOutfitProvider.notifier);
    return TextField(
      controller: _controller,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Outfit Name',
      ),
      onSubmitted: (String? value) {
        if (value != null) {
          updateOutfitConsumer.updateOutfitName(widget.dayIndex, widget.ordering, value);
        }
        widget.setEditing(false);
      },
      onTapOutside: (PointerDownEvent ev) {
        widget.setEditing(false);
      },
    );
  }
}
