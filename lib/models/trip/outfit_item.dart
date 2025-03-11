class OutfitItem {
  String type;
  String grouping;
  bool? generic;
  bool? selected;
  int? namedItemId;

  OutfitItem(
    this.type,
    this.grouping, [
    this.generic,
    this.selected = false,
    this.namedItemId,
  ]);

  Map toJson() => {
    'type': type,
    'grouping': grouping,
    'generic': generic == true ? 1 : 0,
    'selected': selected,
    'namedItemId': namedItemId,
  };

  factory OutfitItem.fromMap(Map<String, dynamic> map) {
    return OutfitItem(
      map['type'],
      map['grouping'],
      map['generic'] == 1,
      map['selected'] ?? false,
      map['namedItemId'],
    );
  }
}

extension MutableOutfitItem on OutfitItem {
  OutfitItem copyWith({String? type, String? grouping, bool? generic, bool? selected, int? namedItemId}) {
    return OutfitItem(type ?? this.type, grouping ?? this.grouping, generic ?? this.generic, selected ?? this.selected, namedItemId ?? this.namedItemId);
  }

  OutfitItem nameItem({required int newNamedItemId}) {
    return copyWith(namedItemId: newNamedItemId);
  }

  OutfitItem selectItem({required bool newSelected}) {
    return copyWith(selected: newSelected);
  }
}

