import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:collection/collection.dart';
import 'package:tote_f/models/user/item_template.dart';
import 'package:tote_f/services/db_service.dart';

part 'user_items_provider.g.dart';

class UserItemsAndGroups {
  List<ItemTemplate> userItems;
  Set<String> groupings;

  UserItemsAndGroups({
    required this.userItems,
    required this.groupings,
  });
}

@riverpod
class UserItems extends _$UserItems {
  @override
  Future<UserItemsAndGroups> build() async {
    final DatabaseService dbService = DatabaseService();
    List<ItemTemplate> userItems = await dbService.userItems();
    return UserItemsAndGroups(
      userItems: userItems,
      groupings: userItems.map((item) => item.grouping).whereNotNull().toSet(),
    );
  }

  Future<void> addUserItem(String itemName) async {
    final DatabaseService dbService = DatabaseService();
    final newItem = await dbService.addUserItem(itemName);
    final previousState = await future;
    state = AsyncData(UserItemsAndGroups(
        userItems: [...previousState.userItems, newItem],
        groupings: previousState.groupings));
  }

  Future<void> renameItem(ItemTemplate oldItem, String newName) async {
    final DatabaseService dbService = DatabaseService();
    if (oldItem.grouping == null) {
      await dbService.updateItemGrouping(oldItem.id, newName);
    }
    await dbService.renameItem(oldItem.id, newName);
    final previousState = await future;
    state = AsyncData(UserItemsAndGroups(userItems: previousState.userItems
        .map((item) => item.id == oldItem.id ? item.renameItem(newName) : item)
        .toList(), groupings: previousState.groupings));
  }

  Future<void> setItemIsGeneric(ItemTemplate oldItem, bool newValue) async {
    final DatabaseService dbService = DatabaseService();
    await dbService.setItemIsGeneric(oldItem.id, newValue);
    final previousState = await future;
    final newUserItems = previousState.userItems
        .map((item) =>
            item.id == oldItem.id ? item.setIsGeneric(newValue) : item)
        .toList();
    state = AsyncData(UserItemsAndGroups(userItems: newUserItems, groupings: previousState.groupings));
  }

  Future<void> deleteItem(ItemTemplate item) async {
    final DatabaseService dbService = DatabaseService();
    await dbService.deleteItem(item.id);
    final previousState = await future;
    final newUserItems = previousState.userItems.where((i) => i.id != item.id).toList();
    state = AsyncData(UserItemsAndGroups(userItems: newUserItems, groupings: previousState.groupings));
  }

  Future<void> updateItemGrouping(ItemTemplate oldItem, String newGrouping) async {
    final DatabaseService dbService = DatabaseService();
    await dbService.updateItemGrouping(oldItem.id, newGrouping);
    final previousState = await future;
    final newUserItems = previousState.userItems
        .map((item) => item.id == oldItem.id ? item.setGrouping(newGrouping) : item)
        .toList();
    state = AsyncData(UserItemsAndGroups(userItems: newUserItems, groupings: previousState.groupings));
  }
}
