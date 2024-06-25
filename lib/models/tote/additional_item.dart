class AdditionalItem {
  String name;
  bool included;
  AdditionalItem(this.name, this.included);

  Map toJson() => {'name': name, 'included': included};

  factory AdditionalItem.fromMap(Map<String, dynamic> map) {
    return AdditionalItem(
      map['name'],
      map['included']
    );
  }
}
