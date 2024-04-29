import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tote_f/models/tote/named.dart';
import 'package:tote_f/providers/trip_provider.dart';

part 'packing_list.g.dart';

class PackingListType {
  final Map<String, List<Named>> namedItems;
  final Map<String, int> unnamedItems;
  PackingListType(this.namedItems, this.unnamedItems);
}

@riverpod
class PackingListNotifier extends _$PackingListNotifier {
  @override
  PackingListType build() {
    Map<String, List<Named>> named = {};
    Map<String, int> unnamed = {};
    final days = ref.watch(tripNotifierProvider).days;
    for (var day in days) {
      final outfits = day.outfits;
      if (outfits != null && outfits.isNotEmpty) {
        for (var outfit in outfits) {
          final items = outfit.items;
          for (var item in items) {
            if (item.parentType == null) {
              if (!unnamed.containsKey(item.type)) {
                unnamed.addAll({item.type: 0});
              }
              unnamed.update(item.type, (value) => value + 1);
            } else if (item.namedItem != null) {
              if (!named.containsKey(item.parentType)) {
                named.addAll({item.parentType!: []});
              }
              named.update(item.parentType!, (value) => [...value, item.namedItem!]);
            }
          }
        }
      }
    }
    return PackingListType(named, unnamed);
  }

  
}