import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tote_f/models/tote/named.dart';
import 'package:tote_f/providers/named_items_provider.dart';
import 'package:tote_f/providers/trip_provider.dart';

part 'packing_list_provider.g.dart';

class PackingListType {
  final Map<String, Set<Named>> namedItems;
  final Map<String, int> unnamedItems;
  PackingListType(this.namedItems, this.unnamedItems);
}

@riverpod
class PackingListNotifier extends _$PackingListNotifier {
  @override
  PackingListType build() {
    Map<String, Set<Named>> named = {};
    Map<String, int> unnamed = {};
    final days = ref.watch(tripNotifierProvider).days;
    final namedItems = ref.watch(namedItemsNotifierProvider);
    for (var day in days) {
      final outfits = day.outfits;
      if (outfits != null && outfits.isNotEmpty) {
        for (var outfit in outfits) {
          final items = outfit.items;
          for (var item in items) {
            if (item.selected == true && item.parentType == null) {
              if (!unnamed.containsKey(item.type)) {
                unnamed.addAll({item.type: 0});
              }
              unnamed.update(item.type, (value) => value + 1);
            } else if (item.namedItemId != null) {
              if (!named.containsKey(item.parentType)) {
                named.addAll({item.parentType!: {}});
              }
              named.update(
                  item.parentType!,
                  (value) => value.union({
                        namedItems.firstWhere(
                            (named) => named.ordering == item.namedItemId)
                      }));
            }
          }
        }
      }
    }
    return PackingListType(named, unnamed);
  }
}
