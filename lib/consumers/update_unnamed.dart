import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tote_f/models/tote/unnamed.dart';
import 'package:tote_f/providers/unnamed_items_provider.dart';

part 'update_unnamed.g.dart';

@riverpod
class UpdateUnnamed extends _$UpdateUnnamed {
  @override
  void build() {}

  void selectUnnamed(String itemName) {
    ref.read(unnamedItemsProvider.notifier).incrementCount(itemName);
  }

  void deselectUnnamed(String itemName) async {
    ref.read(unnamedItemsProvider.notifier).decrementCount(itemName);
  }

  void addAndPackItem(String itemName, int itemCount) {
    ref.read(unnamedItemsProvider.notifier).addAndPackItem(itemName, itemCount);
  }

  void packUnnamedItem(Unnamed item, bool isPacked) {
    ref.read(unnamedItemsProvider.notifier).packUnnamed(item, isPacked);
  }
}
