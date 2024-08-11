import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tote_f/models/tote/unnamed.dart';
import 'package:tote_f/providers/unnamed_items_provider.dart';

part 'update_unnamed.g.dart';

@riverpod
class UpdateUnnamed extends _$UpdateUnnamed {
  @override
  void build() {}

  void selectUnnamed(String itemName) {
    ref.read(unnamedItemsNotifierProvider.notifier).incrementCount(itemName);
  }

  void deselectUnnamed(String itemName) async {
    ref.read(unnamedItemsNotifierProvider.notifier).decrementCount(itemName);
  }

  void addAndPackItem(String itemName, int itemCount) {
    ref.read(unnamedItemsNotifierProvider.notifier).addAndPackItem(itemName, itemCount);
  }

  void packUnnamedItem(Unnamed item, bool isPacked) {
    ref.read(unnamedItemsNotifierProvider.notifier).packUnnamed(item, isPacked);
  }
}
