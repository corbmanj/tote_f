import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tote_f/models/user/additional_item_template.dart';
import 'package:tote_f/providers/user_additional_items_provider.dart';

class AdditionalItemChip extends ConsumerStatefulWidget {
  final AdditionalItemTemplate item;
  const AdditionalItemChip({super.key, required this.item});

  @override
  ConsumerState createState() => _ItemChipState();
}

class _ItemChipState extends ConsumerState<AdditionalItemChip> {
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
    final additionalItemController = ref.read(userAdditionalItemsProvider.notifier);
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
            additionalItemController.renameAdditionalItem(widget.item, value);
            setEditing(false);
          }
        },
        onTapOutside: (ev) {
          if (_controller.text != "") {
            additionalItemController.renameAdditionalItem(widget.item, _controller.text);
            setEditing(false);
          }
        },
      );
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          child: Chip(
            label: Text(widget.item.name),
            deleteIcon: Icon(Icons.edit),
            onDeleted: () => setEditing(true),
          ),
          onLongPress: () => setEditing(true),
          onDoubleTap: () => setEditing(true),
        ),
        ElevatedButton(
          onPressed: () {
            additionalItemController.deleteAdditionalItem(widget.item);
          },
          style: ElevatedButton.styleFrom(
            minimumSize: Size(50.0, 30.0),
            padding: EdgeInsets.symmetric(
                horizontal: 8, vertical: 4),
                backgroundColor: Colors.redAccent,
              foregroundColor: Colors.black,
          ),
          child: Icon(Icons.delete),
        )
      ],
    );
  }
}
