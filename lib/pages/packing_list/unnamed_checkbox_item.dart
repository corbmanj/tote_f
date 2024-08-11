import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tote_f/consumers/update_unnamed.dart';
import 'package:tote_f/models/tote/unnamed.dart';
import 'package:tote_f/providers/unnamed_items_provider.dart';

class UnnamedCheckboxItem extends ConsumerWidget {
  final String itemName;
  final int itemCount;
  const UnnamedCheckboxItem({
    super.key,
    required this.itemName,
    required this.itemCount,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Unnamed? unnamedItem = ref.watch(unnamedItemsNotifierProvider.select(
        (unnamedList) =>
            unnamedList.firstWhereOrNull((item) => item.name == itemName)));

    final unnamedItemsNotifier = ref.read(updateUnnamedProvider.notifier);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Checkbox(
            value: unnamedItem?.isPacked ?? false,
            onChanged: (bool? val) => {
                  if (unnamedItem == null)
                    {unnamedItemsNotifier.addAndPackItem(itemName, itemCount)}
                  else
                    {
                      unnamedItemsNotifier.packUnnamedItem(
                          unnamedItem, !unnamedItem.isPacked!),
                    }
                }),
        GestureDetector(
          child: Text('$itemName $itemCount'),
          onTap: () => {
            if (unnamedItem == null)
              {unnamedItemsNotifier.addAndPackItem(itemName, itemCount)}
            else
              {
                unnamedItemsNotifier.packUnnamedItem(
                    unnamedItem, !unnamedItem.isPacked!),
              }
          },
        ),
      ],
    );
  }
}
