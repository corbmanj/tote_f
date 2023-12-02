class ItemTemplate {
  String type;
  bool hasDropdown;
  String? parentType;

  ItemTemplate(
    this.type,
    this.hasDropdown, [
    this.parentType,
  ]);
}
