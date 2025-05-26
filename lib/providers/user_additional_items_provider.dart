import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tote_f/models/user/additional_item_section_template.dart';
import 'package:tote_f/models/user/additional_item_template.dart';
import 'package:tote_f/services/db_service.dart';

part 'user_additional_items_provider.g.dart';

class UserAdditionalItemsAndSections {
  final List<AdditionalItemTemplate> userAdditionalItems;
  final List<AdditionalItemSectionTemplate> userAdditionalItemSections;

  UserAdditionalItemsAndSections({
    required this.userAdditionalItems,
    required this.userAdditionalItemSections,
  });
}

@Riverpod(keepAlive: true)
class UserAdditionalItems extends _$UserAdditionalItems {
  @override
  Future<UserAdditionalItemsAndSections> build() async {
    final DatabaseService dbService = DatabaseService();
    List<AdditionalItemTemplate> userAdditionalItems =
        await dbService.userAdditionalItems();
    List<AdditionalItemSectionTemplate> userAdditionalItemSections =
        await dbService.userAdditionalItemSections();
    return UserAdditionalItemsAndSections(
      userAdditionalItems: userAdditionalItems,
      userAdditionalItemSections: userAdditionalItemSections,
    );
  }

  Future<void> addUserAdditionalItem(String itemName) async {
    final DatabaseService dbService = DatabaseService();
    final itemId = await dbService.addAdditionalItem(itemName);
    final newItem = AdditionalItemTemplate(
      id: itemId,
      name: itemName,
      defaultIncluded: false,
    );
    final previousState = await future;
    state = AsyncData(UserAdditionalItemsAndSections(
        userAdditionalItems: [...previousState.userAdditionalItems, newItem],
        userAdditionalItemSections: previousState.userAdditionalItemSections));
  }

  Future<void> renameAdditionalItem(
      AdditionalItemTemplate item, String newName) async {
    final DatabaseService dbService = DatabaseService();
    await dbService.renameAdditionalItem(item.id, newName);
    final newItem = item.copyWith(name: newName);
    final previousState = await future;
    state = AsyncData(UserAdditionalItemsAndSections(
      userAdditionalItems: previousState.userAdditionalItems
          .map((i) => i.id == item.id ? newItem : i)
          .toList(),
      userAdditionalItemSections: previousState.userAdditionalItemSections,
    ));
  }

  Future<void> updateAdditionalItemDefaultIncluded(
      AdditionalItemTemplate item, bool newValue) async {
    final DatabaseService dbService = DatabaseService();
    await dbService.updateAdditionalItemDefaultIncluded(item.id, newValue);
    final newItem = item.copyWith(defaultIncluded: newValue);
    final previousState = await future;
    state = AsyncData(UserAdditionalItemsAndSections(
      userAdditionalItems: previousState.userAdditionalItems
          .map((i) => i.id == item.id ? newItem : i)
          .toList(),
      userAdditionalItemSections: previousState.userAdditionalItemSections,
    ));
  }

  Future<void> deleteAdditionalItem(AdditionalItemTemplate item) async {
    final DatabaseService dbService = DatabaseService();
    await dbService.deleteAdditionalItem(item.id);
    final previousState = await future;
    final newAdditionalItems = previousState.userAdditionalItems
        .where((i) => i.id != item.id)
        .toList();
    state = AsyncData(UserAdditionalItemsAndSections(
      userAdditionalItems: newAdditionalItems,
      userAdditionalItemSections: previousState.userAdditionalItemSections,
    ));
  }

  Future<void> addItemToSection(AdditionalItemTemplate item,
      AdditionalItemSectionTemplate section) async {
    final DatabaseService dbService = DatabaseService();
    await dbService.addAdditionalItemToSection(item.id, section.id);
    final previousState = await future;
    final newItem = item.copyWith(sectionId: section.id);
    final newAdditionalItems = previousState.userAdditionalItems
        .map((i) => i.id == item.id ? newItem : i)
        .toList();
    state = AsyncData(UserAdditionalItemsAndSections(
      userAdditionalItems: newAdditionalItems,
      userAdditionalItemSections: previousState.userAdditionalItemSections,
    ));
  }

  Future<void> removeItemFromSection(AdditionalItemTemplate item) async {
    final DatabaseService dbService = DatabaseService();
    await dbService.removeAdditionalItemFromSection(item.id);
    final previousState = await future;
    final newAdditionalItems = previousState.userAdditionalItems
        .map((i) => i.id == item.id ? i.clearSection() : i)
        .toList();
    state = AsyncData(UserAdditionalItemsAndSections(
      userAdditionalItems: newAdditionalItems,
      userAdditionalItemSections: previousState.userAdditionalItemSections,
    ));
  }

  Future<void> renameAdditionalItemSection(
      AdditionalItemSectionTemplate section, String newName) async {
    final DatabaseService dbService = DatabaseService();
    await dbService.renameAdditionalItemSection(section.id, newName);
    final newSection = section.copyWith(name: newName);
    final previousState = await future;
    state = AsyncData(UserAdditionalItemsAndSections(
      userAdditionalItems: previousState.userAdditionalItems,
      userAdditionalItemSections: previousState.userAdditionalItemSections
          .map((s) => s.id == section.id ? newSection : s)
          .toList(),
    ));
  }

  Future<void> addAdditionalItemSection() async {
    final DatabaseService dbService = DatabaseService();
    final sectionId = await dbService.addAdditionalItemSection("New Section");
    final newSection =
        AdditionalItemSectionTemplate(id: sectionId, name: "New Section");
    final previousState = await future;
    state = AsyncData(UserAdditionalItemsAndSections(
        userAdditionalItems: previousState.userAdditionalItems,
        userAdditionalItemSections: [
          ...previousState.userAdditionalItemSections,
          newSection
        ]));
  }

  Future<void> deleteAdditionalItemSection(
      AdditionalItemSectionTemplate section, bool deleteItems) async {
    final DatabaseService dbService = DatabaseService();
    final previousState = await future;
    previousState.userAdditionalItems
        .where((i) => i.sectionId == section.id)
        .forEach((item) async {
      await dbService.removeAdditionalItemFromSection(item.id);
      if (deleteItems) {
        await dbService.deleteAdditionalItem(item.id);
      }
    });
    await dbService.deleteAdditionalItemSection(section.id);
    final newAdditionalItemSections = previousState.userAdditionalItemSections
        .where((s) => s.id != section.id)
        .toList();
    final newAdditionalItems = previousState.userAdditionalItems
        .map((i) {
          if (i.sectionId == section.id) {
            return deleteItems ? null : i.clearSection();
          }
          return i;
        })
        .whereType<AdditionalItemTemplate>()
        .toList();
    state = AsyncData(UserAdditionalItemsAndSections(
      userAdditionalItems: newAdditionalItems,
      userAdditionalItemSections: newAdditionalItemSections,
    ));
  }
}
