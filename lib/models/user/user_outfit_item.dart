class UserOutfitItem {
  int itemId;
  bool defaultIncluded;

  UserOutfitItem({required this.itemId, this.defaultIncluded = false});

  factory UserOutfitItem.fromMap(Map<String, dynamic> map) {
    return UserOutfitItem(
      itemId: map['itemId'],
      defaultIncluded: map['defaultIncluded'] == 1 ? true : false,
    );
  }
}

extension MutableUserOutfitItem on UserOutfitItem {
  UserOutfitItem copyWith({
    int? itemId,
    bool? defaultIncluded,
  }) {
    return UserOutfitItem(itemId: itemId ?? this.itemId, defaultIncluded: defaultIncluded ?? this.defaultIncluded);
  }
}
