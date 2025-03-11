import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tote_f/models/user/item_template.dart';
import 'package:tote_f/providers/user_items_provider.dart';

class GroupingSelector extends ConsumerWidget {
  final ItemTemplate item;
  const GroupingSelector({super.key, required this.item});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userItemsRef = ref.watch(userItemsProvider);
    final userItemsNotifier = ref.read(userItemsProvider.notifier);
    return switch (userItemsRef) {
      AsyncData(:final value) => DropdownButton<String>(
          value: item.grouping,
          items: value.groupings
              .map((item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(item),
                  ))
              .toList(),
          onChanged: (String? newValue) {
            if (newValue != null) {
              userItemsNotifier.updateItemGrouping(item, newValue);
            }
          }),
      _ => Container()
    };
  }
}
