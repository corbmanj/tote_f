import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tote_f/models/tote/named.dart';
import 'package:tote_f/models/tote/outfit.dart';
import 'package:tote_f/models/user/outfit_item.dart';
import 'package:tote_f/providers/named_items_provider.dart';

class AssignOutfitItems extends ConsumerStatefulWidget {
  final Outfit outfit;
  final int dayIndex;
  const AssignOutfitItems({
    super.key,
    required this.outfit,
    required this.dayIndex,
  });

  @override
  ConsumerState<AssignOutfitItems> createState() => _AssignOutfitItemsState();
}

class _AssignOutfitItemsState extends ConsumerState<AssignOutfitItems> {
  OutfitItem? _selectedItem;

  void selectItem(OutfitItem newSelected) {
    setState(() {
      _selectedItem = newSelected;
    });
  }

  @override
  Widget build(BuildContext context) {
    final namedItems = ref.watch(namedItemsNotifierProvider);
    final outfitItems = widget.outfit.items
        .where((item) => !!item.hasDropdown && !!item.selected!)
        .toList();
    if (outfitItems.isEmpty) {
      return const Center(child: Text('No items to assign.'));
    }
    if (_selectedItem == null) {
      selectItem(outfitItems[0]);
    }
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 4),
          child: IntrinsicHeight(
            child: Row(
              children: [
                Column(
                    children: outfitItems
                        .map((OutfitItem item) => GestureDetector(
                              child: Text(
                                item.type,
                                style: item == _selectedItem
                                    ? const TextStyle(color: Colors.blue)
                                    : null,
                              ),
                              onTap: () => selectItem(item),
                            ))
                        .toList()),
                const VerticalDivider(
                  thickness: 2,
                  color: Colors.grey,
                ),
                Expanded(
                  child: Column(
                    children: namedItems
                        .where((Named named) => named.parentType == _selectedItem!.parentType)
                        .map((Named named) => Text(named.name))
                        .toList(),
                  ),
                )
              ],
            ),
          ),
        ),
        const Text("here goes the list of assigned items as chips")
      ],
    );
  }
}
