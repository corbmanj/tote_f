// import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tote_f/models/tote/named.dart';

class OutfitItem {
  String type;
  bool hasDropdown;
  String? parentType;
  bool? selected;
  Named? namedItem;

  OutfitItem(
    this.type,
    this.hasDropdown, [
    this.parentType,
    this.selected = false,
    this.namedItem,
  ]);
}

extension MutableOutfitItem on OutfitItem {
  OutfitItem nameItem({required Named newNamedItem}) {
    return OutfitItem(type, hasDropdown, parentType, selected, newNamedItem);
  }

  OutfitItem selectItem({required bool newSelected}) {
    return OutfitItem(type, hasDropdown, parentType, newSelected, namedItem);
  }

  OutfitItem updateItem({
    required String newType,
    required bool newHasDropdown,
    required String newParentType,
    required bool newSelected,
    required Named newNamed,
  }) {
    return OutfitItem(
        newType, newHasDropdown, newParentType, newSelected, newNamed);
  }
}

// class OutfitItemNotifier extends StateNotifier<OutfitItem> {
//   OutfitItemNotifier(OutfitItem item)
//       : super(OutfitItem(
//           item.type,
//           item.hasDropdown,
//           item.parentType,
//           item.selected,
//           item.namedItem,
//         ));

//   void updateItem(
//       {required String newType,
//       required bool newHasDropdown,
//       required String newParentType,
//       required bool newSelected,
//       required Named newNamed}) {
//     state = OutfitItem(
//       newType,
//       newHasDropdown,
//       newParentType,
//       newSelected,
//       newNamed,
//     );
//   }
// }

// final outfitItemProvider =
//     StateNotifierProvider<OutfitItemNotifier, OutfitItem>((ref) {
//   final namedItem = ref.watch(namedItemProvider);
//   return OutfitItemNotifier(OutfitItem("", false, "", false, namedItem));
// });

// class OutfitItemsNotifier extends StateNotifier<List<OutfitItem>> {
//   OutfitItemsNotifier(List<OutfitItem> outfitItemList)
//       : super(outfitItemList
//             .map((OutfitItem item) => OutfitItem(
//                   item.type,
//                   item.hasDropdown,
//                   item.parentType,
//                   item.selected,
//                   item.namedItem,
//                 ))
//             .toList());

//   void addItem(OutfitItem newItem) {
//     final List<OutfitItem> newItems = state;
//     newItems.add(newItem);
//     state = newItems;
//   }
// }

// final outfitItemsProvider =
//     StateNotifierProvider<OutfitItemsNotifier, List<OutfitItem>>(
//         (ref) => OutfitItemsNotifier([]));
