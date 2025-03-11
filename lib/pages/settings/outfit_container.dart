import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:collection/collection.dart';
import 'package:tote_f/models/user/item_template.dart';
import 'package:tote_f/models/user/outfit_template.dart';
import 'package:tote_f/pages/settings/item_draggable_chip.dart';
import 'package:tote_f/pages/settings/outfit_header.dart';
import 'package:tote_f/providers/user_items_provider.dart';
import 'package:tote_f/providers/user_outfits_provider.dart';

class OutfitContainer extends ConsumerWidget {
  final OutfitTemplate outfit;
  const OutfitContainer({super.key, required this.outfit});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userItemsRef = ref.watch(userItemsProvider);
    List<ItemTemplate> userItems = [];
    List<ItemTemplateWithExtension?> itemsWithNames = [];
    switch (userItemsRef) {
      case AsyncData(:final value):
        userItems = value.userItems;
        itemsWithNames = outfit.outfitItems
            .map((i) {
              final foundItem =
                  userItems.firstWhereOrNull((item) => item.id == i.itemId);
              final returnItem = foundItem != null
                  ? ItemTemplateWithExtension.fromItemWithDefaultIncluded(
                      item: foundItem, defaultIncluded: i.defaultIncluded)
                  : null;
              return returnItem;
            })
            .where((i) => i != null)
            .toList();
    }

    return SizedBox(
      width: 300,
      child: Column(
        children: [
          OutfitHeader(outfit: outfit),
          OutfitItemsList(itemList: itemsWithNames, outfit: outfit),
        ],
      ),
    );
  }
}

class OutfitItemsList extends ConsumerWidget {
  final List<ItemTemplateWithExtension?> itemList;
  final OutfitTemplate outfit;
  const OutfitItemsList(
      {super.key, required this.itemList, required this.outfit});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userOutfitConsumer = ref.read(userOutfitsProvider.notifier);
    return DragTarget(builder: (
      BuildContext context,
      List<dynamic> accepted,
      List<dynamic> rejected,
    ) {
      return Container(
        width: 300,
        padding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 40.0),
        color: Colors.black12,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: itemList
                .map((item) => OutfitItemRow(item: item!, outfit: outfit))
                .toList()),
      );
    }, onAcceptWithDetails:
        (DragTargetDetails<ItemTemplateWithExtension> details) {
      if (details.data.outfit == null) {
        userOutfitConsumer.addItemToOutfit(outfit, details.data);
      }
    });
  }
}

class OutfitItemRow extends ConsumerWidget {
  final ItemTemplateWithExtension item;
  final OutfitTemplate outfit;
  const OutfitItemRow({super.key, required this.item, required this.outfit});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final outfitNotifier = ref.read(userOutfitsProvider.notifier);
    return Row(
      children: [
        DraggableOutfitItem(item: item, outfit: outfit),
        Checkbox(value: item.defaultIncluded, onChanged: (bool? value) {
          outfitNotifier.updateItemDefaultIncluded(outfit, item.id, value ?? false);
        })
      ],
    );
  }
}

class DraggableOutfitItem extends StatelessWidget {
  final ItemTemplate item;
  final OutfitTemplate outfit;
  const DraggableOutfitItem(
      {super.key, required this.item, required this.outfit});

  @override
  Widget build(BuildContext context) {
    final GlobalKey dragKey = GlobalKey();
    return Draggable<ItemTemplateWithExtension>(
      data: ItemTemplateWithExtension.fromItemWithOutfit(
          item: item, outfit: outfit),
      dragAnchorStrategy: pointerDragAnchorStrategy,
      feedback: DraggingChip(dragKey: dragKey, label: item.name),
      childWhenDragging: Chip(
        backgroundColor: Colors.black12,
        label: Text(item.name),
        elevation: 16.0,
      ),
      child: Chip(
        label: Text(item.name),
      ),
    );
  }
}
