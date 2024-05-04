// import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'dart:convert';

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

  Map toJson() => {
    'type': type,
    'hasDropdown': hasDropdown,
    'parentType': parentType,
    'selected': selected,
    'namedItem': jsonEncode(namedItem),
  };

  factory OutfitItem.fromMap(Map<String, dynamic> map) {
    return OutfitItem(
      map['type'],
      map['hasDropdown'] ?? false,
      map['parentType'],
      map['selected'] ?? false,
      map['named'] != null ? Named.fromMap(jsonDecode(map['namedItem'])) : null,
    );
  }
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

