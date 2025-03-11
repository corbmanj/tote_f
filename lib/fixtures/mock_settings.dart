import 'package:tote_f/models/user/item_template.dart';
import 'package:tote_f/models/user/outfit_template.dart';
import 'package:tote_f/models/user/user_outfit_item.dart';

final ItemTemplate shoes = ItemTemplate(id: 1, name: "shoes", grouping: "shoes", generic: false);
final ItemTemplate shirt = ItemTemplate(id: 2, name: "shirt", grouping: "shirt", generic: false);
final ItemTemplate pants = ItemTemplate(id: 3, name: "pants", grouping: "pants", generic: false);
final ItemTemplate sweatshirt =
    ItemTemplate(id: 4, name: "sweatshirt", grouping: "sweatshirt", generic: false);
final ItemTemplate jacket = ItemTemplate(id: 5, name: "jacket", grouping: "jacket", generic: false);
final ItemTemplate socks = ItemTemplate(id: 6, name: "socks", grouping: "socks", generic: true);
final ItemTemplate underwear = ItemTemplate(id: 7, name: "underwear", grouping: "underwear", generic: true);
final ItemTemplate runningShorts =
    ItemTemplate(id: 8, name: "running shorts", grouping: "pants", generic: false);
final ItemTemplate runningShirt =
    ItemTemplate(id: 9, name: "running shirt", grouping: "shirt", generic: false);

final UserOutfitItem iShoes = UserOutfitItem(itemId: 1, defaultIncluded: true);
final UserOutfitItem iShirt = UserOutfitItem(itemId: 2, defaultIncluded: true);
final UserOutfitItem iPants = UserOutfitItem(itemId: 3, defaultIncluded: true);
final UserOutfitItem iSweatshirt =
    UserOutfitItem(itemId: 4, defaultIncluded: false);
final UserOutfitItem iJacket =
    UserOutfitItem(itemId: 5, defaultIncluded: false);
final UserOutfitItem iSocks = UserOutfitItem(itemId: 6, defaultIncluded: true);
final UserOutfitItem iUnderwear =
    UserOutfitItem(itemId: 7, defaultIncluded: true);
final UserOutfitItem iRunningShorts =
    UserOutfitItem(itemId: 8, defaultIncluded: true);
final UserOutfitItem iRunningShirt =
    UserOutfitItem(itemId: 9, defaultIncluded: true);

final List<ItemTemplate> items = [
  shoes,
  shirt,
  pants,
  sweatshirt,
  jacket,
  socks,
  underwear,
  runningShorts,
  runningShirt,
];

final OutfitTemplate outfit1 = OutfitTemplate(
  id: 1,
  type: 'Work Outfit',
  outfitItems: [
    iShoes,
    iShirt,
    iPants,
    iJacket,
    iSocks,
    iUnderwear,
  ],
);

final OutfitTemplate outfit2 = OutfitTemplate(
  id: 2,
  type: 'Running Outfit',
  outfitItems: [
    iShoes,
    iRunningShirt,
    iRunningShorts,
    iSocks,
    iUnderwear,
  ],
);

final outfits = [outfit1, outfit2];
