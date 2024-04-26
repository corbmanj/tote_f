import 'package:tote_f/models/tote/named.dart';

class ItemTemplate {
  String type;
  bool hasDropdown;
  String? parentType;
  Named? named;

  ItemTemplate(
    this.type,
    this.hasDropdown, [
    this.parentType,
    this.named,
  ]);
}
