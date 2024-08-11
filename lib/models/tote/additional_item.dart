class AdditionalItem {
  String name;
  bool included;
  bool? isPacked;
  AdditionalItem(this.name, this.included, [this.isPacked]) {
    isPacked = isPacked ?? false;
  }

  Map toJson() => {'name': name, 'included': included, 'isPacked': isPacked};

  factory AdditionalItem.fromMap(Map<String, dynamic> map) {
    return AdditionalItem(
      map['name'],
      map['included'],
      map['isPacked'] ?? false,
    );
  }

  void updateSelected(bool isSelected) {
    included = isSelected;
  }

  void updateName(String newName) {
    name = newName;
  }

  void updatePacked(bool newIsPacked) {
    isPacked = newIsPacked;
  }
}
