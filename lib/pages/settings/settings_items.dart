import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tote_f/pages/settings/additional_item_chip.dart';
import 'package:tote_f/pages/settings/item_chip.dart';
import 'package:tote_f/providers/user_additional_items_provider.dart';
import 'package:tote_f/providers/user_items_provider.dart';

// TODO: split up the future provider and have the two parts of the page render separeately
class CombinedResult {
  UserItemsAndGroups userItemsAndGroups;
  UserAdditionalItemsAndSections userAdditionalItemsAndSections;

  CombinedResult({
    required this.userItemsAndGroups,
    required this.userAdditionalItemsAndSections,
  });
}

final combinedProvider = FutureProvider((ref) async {
  final userItemsAndGroups = await ref.watch(userItemsProvider.future);
  final userAdditionalItemsAndSections =
      await ref.watch(userAdditionalItemsProvider.future);

  return CombinedResult(
    userItemsAndGroups: userItemsAndGroups,
    userAdditionalItemsAndSections: userAdditionalItemsAndSections,
  );
});

class SettingsItemsTabView extends StatelessWidget {
  const SettingsItemsTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(length: 2, child: Scaffold(
      appBar: AppBar(
        bottom: const TabBar(tabs: [
          Tab(text: 'Outfit Items'),
          Tab(text: 'Additional Items'),
        ]),
        title: const Text('Items Settings'),
      ),
      body: const TabBarView(children: [
        SettingsOutfitItemList(),
        SettingsAdditionalItemList(),
      ]),
    ));
  }
}

class SettingsAdditionalItemList extends ConsumerWidget {
  const SettingsAdditionalItemList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemsList = ref.watch(combinedProvider);

    return Scaffold(
      body: switch (itemsList) {
        AsyncData(value: final items) => Column(
          children: [
            // Header row
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
              child: const Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Text(
                        'Item',
                        style: TextStyle(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      'Actions',
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(12.0),
                child: ListView.separated(
                  scrollDirection: Axis.vertical,
                  itemBuilder: (BuildContext context, int itemIndex) =>
                      AdditionalItemChip(
                          item: items.userAdditionalItemsAndSections
                              .userAdditionalItems[itemIndex]),
                  separatorBuilder: (BuildContext context, int outfitIndex) =>
                      const SizedBox(height: 8.0),
                  itemCount: items.userAdditionalItemsAndSections
                      .userAdditionalItems.length,
                ),
              ),
            ),
          ],
      ),
      _ => const Center(child: CircularProgressIndicator()),
    });
  }
}

class SettingsOutfitItemList extends ConsumerWidget {
  const SettingsOutfitItemList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemsList = ref.watch(combinedProvider);

    return Scaffold(
      body: switch (itemsList) {
        AsyncData(value: final items) => Column(
          children: [
            // Header row
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
              child: const Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Text(
                        'Item',
                        style: TextStyle(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      'Grouping',
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      'Is Generic',
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      'Actions',
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(12.0),
                child: ListView.separated(
                  scrollDirection: Axis.vertical,
                  itemBuilder: (BuildContext context, int itemIndex) =>
                      ItemChip(
                          item: items.userItemsAndGroups.userItems[itemIndex]),
                  separatorBuilder: (BuildContext context, int outfitIndex) =>
                      const SizedBox(height: 8.0),
                  itemCount: items.userItemsAndGroups.userItems.length,
                ),
              ),
            ),
          ],
      ),
      _ => const Center(child: CircularProgressIndicator()),
    });
  }
}