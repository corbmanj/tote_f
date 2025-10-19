import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tote_f/models/user/item_template.dart';
import 'package:tote_f/providers/user_items_provider.dart';
import 'package:tote_f/providers/user_outfits_provider.dart';

class DeleteItemsBox extends ConsumerWidget {
  const DeleteItemsBox({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final outfitsConsumer = ref.read(userOutfitsProvider.notifier);
    final itemsConsumer = ref.read(userItemsProvider.notifier);
    return Expanded(
        flex: 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12, width: 2.0)),
              child: Center(child: Text("Delete Items")),
            ),
            DragTarget(
              builder: (
                BuildContext context,
                List<dynamic> accepted,
                List<dynamic> rejected,
              ) {
                return Container(
                  height: 100.0,
                  padding: EdgeInsets.all(16.0),
                  color: Colors.black12,
                  child: Icon(Icons.delete),
                );
              },
              onAcceptWithDetails:
                  (DragTargetDetails<ItemTemplateWithExtension> details) {
                if (details.data.outfit != null) {
                  outfitsConsumer.deleteItemFromOutfit(details.data.outfit!, details.data);
                } else {
                  // delete item from all outfits
                  outfitsConsumer.deleteItemFromAllOutfits(details.data);
                  // delete item from items list
                  itemsConsumer.deleteItem(details.data);
                }
              },
            )
          ],
        ));
  }
}
