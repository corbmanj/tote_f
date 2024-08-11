import 'package:flutter/material.dart';
import 'package:tote_f/pages/packing_list/unnamed_checkbox_item.dart';

class UnnamedItemsToPack extends StatelessWidget {
  final Map<String, int> unnamedItems;
  const UnnamedItemsToPack({super.key, required this.unnamedItems});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: unnamedItems.keys
          .map((key) => Row(
                children: [
                  Text('$key: ', style: const TextStyle(fontWeight: FontWeight.bold),),
                  UnnamedCheckboxItem(itemName: key, itemCount: unnamedItems[key] ?? 0),
                ],
              ))
          .toList(),
    );
  }
}
