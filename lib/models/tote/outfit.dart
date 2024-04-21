// import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tote_f/models/user/outfit_template.dart';
import '../user/item_template.dart';
import '../user/outfit_item.dart';

class Outfit {
  late String type;
  late String name;
  late List<OutfitItem> items;
  late int ordering;

  Outfit(this.type, this.name, this.items, this.ordering);
  Outfit.fromTemplate(OutfitTemplate template, newOrdering) {
    type = template.type;
    name = 'new name';
    items = createItems(template.outfitItems);
    ordering = newOrdering ?? 0;
  }

  List<OutfitItem> createItems(List<ItemTemplate> items) {
    final List<OutfitItem> result = [];
    for (final item in items) {
      result.add(OutfitItem(item.type, item.hasDropdown, item.parentType));
    }
    return result;
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

  Outfit selectItemForOutfit(
    String itemType,
    bool newSelected,
  ) {
    return copyWith(items: selectItemByType(itemType, newSelected));
  }

  Outfit changeType(OutfitTemplate newType) {
    return Outfit.fromTemplate(newType, ordering);
  }

  Outfit copyWith(
      {String? type, String? name, List<OutfitItem>? items, int? ordering}) {
    return Outfit(type ?? this.type, name ?? this.name, items ?? this.items,
        ordering ?? this.ordering);
  }
}
