import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tote_f/models/user/item_template.dart';
import 'package:tote_f/models/user/outfit_template.dart';
import 'package:tote_f/services/db_service.dart';

part 'user_outfits_provider.g.dart';

@riverpod
class UserOutfits extends _$UserOutfits {
  @override
  Future<List<OutfitTemplate>> build() async {
    final DatabaseService dbService = DatabaseService();
    List<OutfitTemplate> userOutfits = await dbService.userOutfits();
    return userOutfits;
  }

  Future<void> updateOutfitList(OutfitTemplate outfit) async {
    final previousState = await future;
    final newState =
        previousState.map((i) => i.id == outfit.id ? outfit : i).toList();
    state = AsyncData(newState);
  }

  Future<void> addItemToOutfit(OutfitTemplate outfit, ItemTemplate item,
      [bool? defaultIncluded]) async {
    if (outfit.outfitItems.where((i) => i.itemId == item.id).isNotEmpty) {
      return;
    }
    final DatabaseService dbService = DatabaseService();
    await dbService.addItemToOutfit(outfit, item);
    outfit.addItem(item, defaultIncluded ?? false);
    updateOutfitList(outfit);
  }

  Future<void> addOutfit([String outfitType = "New Name"]) async {
    final DatabaseService dbService = DatabaseService();
    final outfitId = await dbService.addOutfit(outfitType);
    final previousState = await future;
    state = AsyncData([
      ...previousState,
      OutfitTemplate(id: outfitId, type: outfitType, outfitItems: [])
    ]);
  }

  Future<void> updateOutfitName(OutfitTemplate outfit, String newName) async {
    final DatabaseService dbService = DatabaseService();
    final newOutfit = outfit.copyWith(newType: newName);
    await dbService.updateOutfit(newOutfit);
    updateOutfitList(newOutfit);
  }

  Future<void> updateItemDefaultIncluded(OutfitTemplate outfit, int itemId, bool defaultIncluded) async {
    final DatabaseService dbService = DatabaseService();
    await dbService.updateOutfitItem(outfit.id, itemId, defaultIncluded);
    final newOutfit = outfit.updateDefaultIncluded(itemId, defaultIncluded);
    updateOutfitList(newOutfit);
  }

  Future<void> deleteItemFromOutfit(OutfitTemplate outfit, ItemTemplate item) async {
    final DatabaseService dbService = DatabaseService();
    await dbService.deleteItemFromOutfit(outfit.id, item.id);
    final newOutfit = outfit.removeItem(item);
    updateOutfitList(newOutfit);
  }

  Future<void> deleteItemFromAllOutfits(ItemTemplate item) async {
    final DatabaseService dbService = DatabaseService();
    await dbService.deleteItemFromAllOutfits(item.id);
    List<OutfitTemplate> previousState = await future;
    for (var o in previousState) {
      o.removeItem(item);
    }
    state = AsyncData(previousState);
  }
}
