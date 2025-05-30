import 'package:flutter/material.dart';
import 'package:tote_f/models/tote/named.dart';
import 'package:tote_f/pages/packing_list/named_checkbox_item.dart';

class NamedItemsToPack extends StatelessWidget {
  final Map<String, Set<Named>> namedItems;
  const NamedItemsToPack({super.key, required this.namedItems});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: namedItems.keys
                .map((String type) =>
                    NamedItemsOfType(type: type, items: namedItems[type]!))
                .toList(),
          ),
        ),
      ],
    );
  }
}

class NamedItemsOfType extends StatelessWidget {
  final String type;
  final Set<Named> items;
  const NamedItemsOfType({super.key, required this.type, required this.items});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      alignment: WrapAlignment.start,
      children: [
        Text(
          '$type: ',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        ...items.map((e) => NamedCheckboxItem(item: e)),
      ],
    );
  }
}
