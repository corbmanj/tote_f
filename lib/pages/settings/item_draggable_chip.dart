import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tote_f/models/user/item_template.dart';
import 'package:tote_f/providers/user_items_provider.dart';

class ItemDraggableChip extends ConsumerStatefulWidget {
  final ItemTemplate item;
  const ItemDraggableChip({super.key, required this.item});

  @override
  ConsumerState createState() => _ItemChipState();
}

class _ItemChipState extends ConsumerState<ItemDraggableChip> {
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
    final itemTemplateController = ref.read(userItemsProvider.notifier);
    final GlobalKey dragKey = GlobalKey();
    if (_isEditing) {
      _controller.text = widget.item.name;
      _controller.selection =
          TextSelection(baseOffset: 0, extentOffset: _controller.text.length);
      return TextField(
        autofocus: true,
        controller: _controller,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Item name',
        ),
        onSubmitted: (String? value) {
          if (value != null) {
            itemTemplateController.renameItem(widget.item, value);
            setEditing(false);
          }
        },
        onTapOutside: (ev) {
          if (_controller.text != "") {
            itemTemplateController.renameItem(widget.item, _controller.text);
            setEditing(false);
          }
        },
      );
    }
    return GestureDetector(
      child: Draggable<ItemTemplateWithExtension>(
        data: ItemTemplateWithExtension.fromItemWithOutfit(item: widget.item),
        dragAnchorStrategy: pointerDragAnchorStrategy,
        feedback: Transform.translate(
          offset: Offset(-20.0, -50.0),
          child: DraggingChip(dragKey: dragKey, label: widget.item.name),
        ),
        childWhenDragging: Chip(
          backgroundColor: Colors.black12,
          label: Text(widget.item.name),
          elevation: 16.0,
        ),
        child: Chip(
          label: Text(widget.item.name),
        ),
      ),
      onLongPress: () => setEditing(true),
      onDoubleTap: () => setEditing(true),
    );
  }
}

class DraggingChip extends StatelessWidget {
  const DraggingChip({
    super.key,
    required this.dragKey,
    required this.label,
  });
  final GlobalKey dragKey;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Chip(label: Text(label)),
    );
  }
}
