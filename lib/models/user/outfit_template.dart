import 'dart:convert';
import 'package:tote_f/models/user/user_outfit_item.dart';
import './item_template.dart';

class OutfitTemplate {
  int id;
  String type;
  List<UserOutfitItem> outfitItems;

  OutfitTemplate(
      {required this.id, required this.type, required this.outfitItems});

  void addItem(ItemTemplate item, bool defaultIncluded) {
    outfitItems
        .add(UserOutfitItem(itemId: item.id, defaultIncluded: defaultIncluded));
  }

  Map toJson() => {
        'id': id,
        'type': type,
        'outfitItems': jsonEncode(outfitItems),
      };

  factory OutfitTemplate.fromMap(
    Map<String, dynamic> map,
    List<Map<String, dynamic>> itemsMap,
  ) {
    return OutfitTemplate(
      id: map['id'],
      type: map['type'],
      outfitItems: itemsMap
          .map<UserOutfitItem>((item) => UserOutfitItem.fromMap(item))
          .toList(),
    );
  }
}

extension MutableOutfitItem on OutfitTemplate {
  OutfitTemplate copyWith(
      {String? newType, List<UserOutfitItem>? newOutfitItems}) {
    return OutfitTemplate(
        id: id,
        type: newType ?? type,
        outfitItems: newOutfitItems ?? outfitItems);
  }

  OutfitTemplate removeItem(ItemTemplate item) {
    List<UserOutfitItem> newOutfitItems = [...outfitItems];
    newOutfitItems.removeWhere((i) => i.itemId == item.id);
    return copyWith(newOutfitItems: newOutfitItems);
  }

  OutfitTemplate updateDefaultIncluded(int itemId, bool defaultIncluded) {
    List<UserOutfitItem> newOutfitItems = outfitItems.map((i) {
      if (i.itemId == itemId) {
        return i.copyWith(defaultIncluded: defaultIncluded);
      } else {
        return i;
      }
    }).toList();
    return copyWith(newOutfitItems: newOutfitItems);
  }
}
