import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tote_f/models/user/item_template.dart';
import 'package:tote_f/pages/settings/grouping_selector.dart';
import 'package:tote_f/providers/user_items_provider.dart';
import 'package:tote_f/providers/user_outfits_provider.dart';

class ItemChip extends ConsumerStatefulWidget {
  final ItemTemplate item;
  const ItemChip({super.key, required this.item});

  @override
  ConsumerState createState() => _ItemChipState();
}

class _ItemChipState extends ConsumerState<ItemChip> {
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
    final outfitTemplateController = ref.read(userOutfitsProvider.notifier);
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
        GroupingSelector(item: widget.item),
        Checkbox(
            value: widget.item.generic,
            onChanged: (bool? checked) {
              if (checked != null) {
                itemTemplateController.setItemIsGeneric(widget.item, checked);
              }
            }),
        ElevatedButton(
          onPressed: () {
            itemTemplateController.deleteItem(widget.item);
            outfitTemplateController.deleteItemFromAllOutfits(widget.item);
          },
          style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(Colors.redAccent),
              foregroundColor: WidgetStatePropertyAll(Colors.black)),
          child: Text('Delete'),
        )
      ],
    );
  }
}
