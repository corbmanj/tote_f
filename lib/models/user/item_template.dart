class ItemTemplate {
  String type;
  bool hasDropdown;
  String? parentType;
  int? namedItemId;

  ItemTemplate(
    this.type,
    this.hasDropdown, [
    this.parentType,
    this.namedItemId,
  ]);
}
