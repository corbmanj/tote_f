import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tote_f/models/tote/unnamed.dart';
import 'package:tote_f/providers/trip_provider.dart';

part 'unnamed_items_provider.g.dart';

@Riverpod(keepAlive: true)
class UnnamedItemsNotifier extends _$UnnamedItemsNotifier {
  @override
  List<Unnamed> build() {
    return [];
  }

  void loadList(List<Unnamed> newList) {
    state = newList;
  }

// todo change to an unnamed item provider
  void incrementCount(String name) {
    final List<Unnamed> newList = [...state];
    for (final item in newList) {
      if (item.name == name) {
        item.incrementCount();
      }
    }
    state = newList;
    ref.read(tripNotifierProvider.notifier).replaceUnnamedAndUpdateTrip(newList);
  }

  void decrementCount(String name) {
    final List<Unnamed> newList = [...state];
    for (final item in newList) {
      if (item.name == name) {
        item.decrementCount();
      }
    }
    state = newList;
    ref.read(tripNotifierProvider.notifier).replaceUnnamedAndUpdateTrip(newList);
  }

  void addAndPackItem(String itemName, int itemCount) {
    final newList = [...state, Unnamed(itemName, itemCount, true)];
    state = newList;
    ref.read(tripNotifierProvider.notifier).replaceUnnamedAndUpdateTrip(newList);
  }

  void packUnnamed(Unnamed item, bool isPacked) {
    final List<Unnamed> newList = [...state];
    for (final oldItem in newList) {
      if (oldItem.name == item.name) {
        item.setIsPacked(isPacked);
      }
    }
    state = newList;
    ref.read(tripNotifierProvider.notifier).replaceUnnamedAndUpdateTrip(newList);
  }
}
