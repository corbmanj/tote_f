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
  OutfitItem copyWith({String? type, bool? hasDropdown, String? parentType, bool? selected, Named? namedItem}) {
    return OutfitItem(type ?? this.type, hasDropdown ?? this.hasDropdown, parentType ?? this.parentType, selected ?? this.selected, namedItem ?? this.namedItem);
  }

  OutfitItem nameItem({required Named newNamedItem}) {
    return copyWith(namedItem: newNamedItem);
  }

  OutfitItem selectItem({required bool newSelected}) {
    return copyWith(selected: newSelected);
  }
}

