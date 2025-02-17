import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tote_f/models/user/item_template.dart';
import 'package:tote_f/services/db_service.dart';

part 'user_items_provider.g.dart';

@riverpod
class UserItems extends _$UserItems {
  @override
  Future<List<ItemTemplate>> build() async {
    final DatabaseService dbService = DatabaseService();
    List<ItemTemplate> userItems = await dbService.userItems();
    return userItems;
  }

  Future<void> addUserItem(String itemName) async {
    final DatabaseService dbService = DatabaseService();
    final newItem = await dbService.addUserItem(itemName);
    final previousState = await future;
    state = AsyncData([...previousState, newItem]);
  }

  Future<void> renameItem(ItemTemplate oldItem, String newName) async {
    final DatabaseService dbService = DatabaseService();
    await dbService.renameItem(oldItem.id, newName);
    final previousState = await future;
    state = AsyncData(previousState
        .map((item) => item.id == oldItem.id ? item.renameItem(newName) : item)
        .toList());
  }

  Future<void> deleteItem(ItemTemplate item) async {
    final DatabaseService dbService = DatabaseService();
    await dbService.deleteItem(item.id);
    final previousState = await future;
    final newState = previousState.where((i) => i.id != item.id).toList();
    state = AsyncData(newState);
  }
}
