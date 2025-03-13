import 'package:tote_f/models/user/additional_item_section_template.dart';
import 'package:tote_f/models/user/additional_item_template.dart';
import 'package:tote_f/models/user/item_template.dart';
import 'package:tote_f/models/user/outfit_template.dart';
import 'package:tote_f/models/user/user_outfit_item.dart';

final ItemTemplate shoes =
    ItemTemplate(id: 1, name: "shoes", grouping: "shoes", generic: false);
final ItemTemplate shirt =
    ItemTemplate(id: 2, name: "shirt", grouping: "shirt", generic: false);
final ItemTemplate pants =
    ItemTemplate(id: 3, name: "pants", grouping: "pants", generic: false);
final ItemTemplate sweatshirt = ItemTemplate(
    id: 4, name: "sweatshirt", grouping: "sweatshirt", generic: false);
final ItemTemplate jacket =
    ItemTemplate(id: 5, name: "jacket", grouping: "jacket", generic: false);
final ItemTemplate socks =
    ItemTemplate(id: 6, name: "socks", grouping: "socks", generic: true);
final ItemTemplate underwear = ItemTemplate(
    id: 7, name: "underwear", grouping: "underwear", generic: true);
final ItemTemplate runningShorts = ItemTemplate(
    id: 8, name: "running shorts", grouping: "pants", generic: false);
final ItemTemplate runningShirt = ItemTemplate(
    id: 9, name: "running shirt", grouping: "shirt", generic: false);

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

AdditionalItemTemplate runningLight = AdditionalItemTemplate(
    id: 1, name: "runningLight", sectionId: 1, defaultIncluded: false);
AdditionalItemTemplate computer = AdditionalItemTemplate(
    id: 2, name: "computer", sectionId: 1, defaultIncluded: true);
AdditionalItemTemplate computerCharger = AdditionalItemTemplate(
    id: 3, name: "computer charger", sectionId: 1, defaultIncluded: true);
AdditionalItemTemplate phone = AdditionalItemTemplate(
    id: 4, name: "phone", sectionId: 1, defaultIncluded: true);
AdditionalItemTemplate phoneCharger = AdditionalItemTemplate(
    id: 5, name: "phone charger", sectionId: 1, defaultIncluded: true);
AdditionalItemTemplate gpsWatch = AdditionalItemTemplate(
    id: 6, name: "gps watch", sectionId: 1, defaultIncluded: true);
AdditionalItemTemplate watchCharger = AdditionalItemTemplate(
    id: 7, name: "watch charger", sectionId: 1, defaultIncluded: true);
AdditionalItemTemplate ipad = AdditionalItemTemplate(
    id: 8, name: "ipad", sectionId: 1, defaultIncluded: true);
AdditionalItemTemplate ipadCharger = AdditionalItemTemplate(
    id: 9, name: "ipad charger", sectionId: 1, defaultIncluded: true);
AdditionalItemTemplate headphones = AdditionalItemTemplate(
    id: 10, name: "headphones", sectionId: 1, defaultIncluded: true);
AdditionalItemTemplate battery = AdditionalItemTemplate(
    id: 11, name: "battery", sectionId: 1, defaultIncluded: true);
AdditionalItemSectionTemplate electronics =
    AdditionalItemSectionTemplate(id: 1, name: "electronics");

AdditionalItemTemplate toiletKit = AdditionalItemTemplate(
    id: 12, name: "toilet kit", sectionId: 2, defaultIncluded: true);
AdditionalItemTemplate toothbrush = AdditionalItemTemplate(
    id: 13, name: "toothbrush", sectionId: 2, defaultIncluded: true);
AdditionalItemTemplate sunscreen = AdditionalItemTemplate(
    id: 14, name: "sunscreen", sectionId: 2, defaultIncluded: false);
AdditionalItemTemplate laundrySheets = AdditionalItemTemplate(
    id: 15, name: "laundry sheets", sectionId: 2, defaultIncluded: false);
AdditionalItemSectionTemplate toiletries =
    AdditionalItemSectionTemplate(id: 2, name: "toiletries");

AdditionalItemTemplate umbrella = AdditionalItemTemplate(
    id: 16, name: "umbrella", sectionId: 3, defaultIncluded: false);
AdditionalItemTemplate sunglasses = AdditionalItemTemplate(
    id: 17, name: "sunglasses", sectionId: 3, defaultIncluded: true);
AdditionalItemTemplate swimsuit = AdditionalItemTemplate(
    id: 18, name: "swim suit", sectionId: 3, defaultIncluded: false);
AdditionalItemSectionTemplate misc =
    AdditionalItemSectionTemplate(id: 3, name: "misc");

final List<AdditionalItemTemplate> additionalItems = [
  runningLight,
  computer,
  computerCharger,
  phone,
  phoneCharger,
  gpsWatch,
  watchCharger,
  ipad,
  ipadCharger,
  headphones,
  battery,
  toiletKit,
  toothbrush,
  sunscreen,
  laundrySheets,
  umbrella,
  sunglasses,
  swimsuit
];
final List<AdditionalItemSectionTemplate> additionalItemSections = [
  electronics,
  toiletries,
  misc
];
