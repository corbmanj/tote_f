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
    return Outfit(
        type, name, selectItemByType(itemType, newSelected), ordering);
  }

  Outfit changeType(OutfitTemplate newType) {
    return Outfit.fromTemplate(newType, ordering);
  }
}

// class OutfitNotifier extends StateNotifier<Outfit> {
//   OutfitNotifier(Outfit outfit)
//       : super(Outfit(
//           outfit.type,
//           outfit.name,
//           outfit.items,
//           outfit.ordering,
//         ));
// }

// final outfitProvider = StateNotifierProvider<OutfitNotifier, Outfit>((ref) {
//   final outfitItems = ref.watch(outfitItemsProvider);
//   return OutfitNotifier(Outfit("", "", outfitItems, 0));
// });

// class OutfitListNotifier extends StateNotifier<List<Outfit>> {
//   OutfitListNotifier(List<Outfit> outfitList)
//       : super(outfitList
//             .map((Outfit outfit) =>
//                 Outfit(outfit.type, outfit.name, outfit.items, outfit.ordering))
//             .toList());

//   void addOutfit(Outfit newOutfit) {
//     final List<Outfit> newOutfits = state;
//     newOutfits.add(newOutfit);
//     state = newOutfits;
//   }
// }

// final outfitListProvider =
//     StateNotifierProvider<OutfitListNotifier, List<Outfit>>(
//         (ref) => OutfitListNotifier([]));
