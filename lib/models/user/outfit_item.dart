class OutfitItem {
  String type;
  bool hasDropdown;
  String? parentType;
  bool? selected;
  int? namedItemId;

  OutfitItem(
    this.type,
    this.hasDropdown, [
    this.parentType,
    this.selected = false,
    this.namedItemId,
  ]);

  Map toJson() => {
    'type': type,
    'hasDropdown': hasDropdown,
    'parentType': parentType,
    'selected': selected,
    'namedItemId': namedItemId,
  };

  factory OutfitItem.fromMap(Map<String, dynamic> map) {
    return OutfitItem(
      map['type'],
      map['hasDropdown'] ?? false,
      map['parentType'],
      map['selected'] ?? false,
      map['namedItemId'],
    );
  }
}

extension MutableOutfitItem on OutfitItem {
  OutfitItem copyWith({String? type, bool? hasDropdown, String? parentType, bool? selected, int? namedItemId}) {
    return OutfitItem(type ?? this.type, hasDropdown ?? this.hasDropdown, parentType ?? this.parentType, selected ?? this.selected, namedItemId ?? this.namedItemId);
  }

  OutfitItem nameItem({required int newNamedItemId}) {
    return copyWith(namedItemId: newNamedItemId);
  }

  OutfitItem selectItem({required bool newSelected}) {
    return copyWith(selected: newSelected);
  }
}

