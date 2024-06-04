class AdditionalItem {
  String name;
  AdditionalItem(this.name);

  Map toJson() => {'name': name};

  factory AdditionalItem.fromMap(Map<String, dynamic> map) {
    return AdditionalItem(
      map['name'],
    );
  }
}
