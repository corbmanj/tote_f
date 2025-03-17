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

class SettingsItems extends ConsumerWidget {
  const SettingsItems({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemsList = ref.watch(combinedProvider);
    // final additionalItemsList = ref.watch(userAdditionalItemsProvider);

    return switch (itemsList) {
      AsyncData(value: final items) => Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                  style: TextStyle(fontWeight: FontWeight.bold), "Outfit Items")
            ]),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('Item'),
                Text('Grouping'),
                Text('Is Generic'),
                Text('Actions'),
              ],
            ),
            Expanded(
              flex: 3,
              child: Container(
                margin: EdgeInsets.all(12.0),
                child: ListView.separated(
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int itemIndex) =>
                        ItemChip(item: items.userItemsAndGroups.userItems[itemIndex]),
                    separatorBuilder: (BuildContext context, int outfitIndex) =>
                        SizedBox(width: 30.0),
                    itemCount: items.userItemsAndGroups.userItems.length),
              ),
            ),
            const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                  style: TextStyle(fontWeight: FontWeight.bold),
                  "Additional Items")
            ]),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('Item'),
                Text('Actions'),
              ],
            ),
            Expanded(
              flex: 1,
              child: Container(
                margin: EdgeInsets.all(12.0),
                child: ListView.separated(
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int itemIndex) =>
                        AdditionalItemChip(item: items.userAdditionalItemsAndSections.userAdditionalItems[itemIndex]),
                    separatorBuilder: (BuildContext context, int outfitIndex) =>
                        SizedBox(height: 8.0),
                    itemCount: items.userAdditionalItemsAndSections.userAdditionalItems.length),
              ),
            )
          ],
        ),
      _ => CircularProgressIndicator(),
    };
  }
}
