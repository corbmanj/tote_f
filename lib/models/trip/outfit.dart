import 'dart:convert';
import 'package:tote_f/models/user/item_template.dart';
import 'package:tote_f/models/user/outfit_template.dart';

import 'outfit_item.dart';

class Outfit {
  String type;
  String name;
  List<OutfitItem> items;
  int ordering;

  Outfit(
      {required this.type,
      required this.name,
      required this.items,
      required this.ordering});

  Map toJson() => {
        'type': type,
        'name': name,
        'items': jsonEncode(items),
        'ordering': ordering,
      };

  factory Outfit.fromMap(Map<String, dynamic> map) {
    return Outfit(
      type: map['type'],
      name: map['name'],
      items: jsonDecode(map['items'] ?? '[]')
          .map<OutfitItem>((item) => OutfitItem.fromMap(item))
          .toList(),
      ordering: map['ordering'],
    );
  }

  factory Outfit.fromTemplate(
      OutfitTemplate template, int ordering, List<ItemTemplate> items) {
    return Outfit(
        type: template.type,
        name: template.type,
        items: template.outfitItems.map((i) {
          final templateItem = items.firstWhere((j) => j.id == i.itemId);
          return OutfitItem(templateItem.name, templateItem.grouping ?? "", templateItem.generic, i.defaultIncluded);
        }).toList(),
        ordering: ordering);
  }
}

extension MutableOutfit on Outfit {
  List<OutfitItem> replaceItemByType(
    String itemType,
    OutfitItem newItem,
  ) {
    return items
        .map((OutfitItem item) => item.type == itemType ? newItem : item)
        .toList();
  }

  List<OutfitItem> selectItemByType(
    String itemType,
    bool newSelected,
  ) {
    return items
        .map((OutfitItem item) => item.type == itemType
            ? item.selectItem(newSelected: newSelected)
            : item)
        .toList();
  }

  List<OutfitItem> nameItemByType(
    String itemType,
    int newNamedId,
  ) {
    return items
        .map((OutfitItem item) => item.type == itemType
            ? item.nameItem(newNamedItemId: newNamedId)
            : item)
        .toList();
  }

  Outfit selectItemForOutfit(
    String itemType,
    bool newSelected,
  ) {
    return copyWith(items: selectItemByType(itemType, newSelected));
  }

  Outfit nameItemForOutfit(
    String itemType,
    int newNamedId,
  ) {
    return copyWith(items: nameItemByType(itemType, newNamedId));
  }

  Outfit copyWith(
      {String? type, String? name, List<OutfitItem>? items, int? ordering}) {
    return Outfit(
      type: type ?? this.type,
      name: name ?? this.name,
      items: items ?? this.items,
      ordering: ordering ?? this.ordering,
    );
  }
}
