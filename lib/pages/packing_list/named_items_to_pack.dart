import 'package:flutter/material.dart';
import 'package:tote_f/models/tote/named.dart';
import 'package:tote_f/pages/packing_list/checkbox_item.dart';

class NamedItemsToPack extends StatelessWidget {
  final Map<String, Set<Named>> namedItems;
  const NamedItemsToPack({super.key, required this.namedItems});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: namedItems.keys.map((String type) => NamedItemsOfType(type: type, items: namedItems[type]!)).toList(),
    );
  }
}

class NamedItemsOfType extends StatelessWidget {
  final String type;
  final Set<Named> items;
  const NamedItemsOfType({super.key, required this.type, required this.items});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('$type: ', style: const TextStyle(fontWeight: FontWeight.bold),),
        Wrap(children: items.map((e) => CheckboxItem(text: e.name)).toList())
      ],
    );
  }
}
