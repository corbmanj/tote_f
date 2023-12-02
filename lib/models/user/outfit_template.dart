import './item_template.dart';

class OutfitTemplate {
  String type;
  List<ItemTemplate> outfitItems;

  OutfitTemplate(this.type, this.outfitItems);

  void addItem(ItemTemplate item) {
    outfitItems.add(item);
  }
}
