import 'dart:convert';

import './additional_item.dart';

class AdditionalItemSection {
  String name;
  List<AdditionalItem> items;

  AdditionalItemSection(this.name, this.items);

  Map toJson() => {
        'name': name,
        'items': jsonEncode(items),
      };

  factory AdditionalItemSection.fromMap(Map<String, dynamic> map) {
    return AdditionalItemSection(
      map['name'],
      jsonDecode(map['items'] ?? '[]')
          .map<AdditionalItem>((item) => AdditionalItem.fromMap(item))
          .toList(),
    );
  }

  void addItem(AdditionalItem item) {
    items.add(item);
  }

  void removeItem(AdditionalItem item) {
    items.remove(item);
  }

  void updateItem(AdditionalItem item, String oldName) {
    items = items
        .map((AdditionalItem oldItem) =>
            oldItem.name == oldName ? item : oldItem)
        .toList();
  }
}
