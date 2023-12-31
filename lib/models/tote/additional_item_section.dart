import './additional_item.dart';

class AdditionalItemSection {
  String name;
  List<AdditionalItem> items;

  AdditionalItemSection(this.name, this.items);

  void addItem(AdditionalItem item) {
    items.add(item);
  }

  void removeItem(AdditionalItem item) {
    items.remove(item);
  }
}
