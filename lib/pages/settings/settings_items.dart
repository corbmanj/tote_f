import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tote_f/pages/settings/item_chip.dart';
import 'package:tote_f/providers/user_items_provider.dart';

class SettingsItems extends ConsumerWidget {
  const SettingsItems({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemsList = ref.watch(userItemsProvider);

    return switch (itemsList) {
      AsyncData(value: final items) => Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('Item'),
                Text('Grouping'),
                Text('Is Generic'),
                Text('Actions'),
              ],
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.all(12.0),
                child: ListView.separated(
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int itemIndex) =>
                        ItemChip(item: items.userItems[itemIndex]),
                    separatorBuilder: (BuildContext context, int outfitIndex) =>
                        SizedBox(width: 30.0),
                    itemCount: items.userItems.length),
              ),
            )
          ],
        ),
      _ => CircularProgressIndicator(),
    };
  }
}
