class AdditionalItem {
  String name;
  AdditionalItem(this.name);

  Map toJson() => {
    'name': name
  };
}
