import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tote_f/models/tote/named.dart';
import 'package:tote_f/providers/trip_provider.dart';

part 'named_items_provider.g.dart';

@Riverpod(keepAlive: true)
class NamedItemsNotifier extends _$NamedItemsNotifier {
  @override
  List<Named> build() {
    return [];
  }

  void loadList(List<Named> newList) {
    state = newList;
  }

  Named updateName(String newName, int ordering) {
    late Named updatedItem;
    copyItem(Named item) {
      if (item.ordering == ordering) {
        updatedItem = item.copyWith(
            name: newName, ordering: ordering == -1 ? state.length : ordering);
      }
      return item.ordering == ordering ? updatedItem : item;
    }
    List<Named> newList = state.map(copyItem).toList();
    state = newList;
    ref.read(tripNotifierProvider.notifier).replaceNamedAndUpdateTrip(newList);
    return updatedItem;
  }

  void addNamed(Named newItem) {
    List<Named> newList = [...state];
    newList.add(newItem);
    ref.read(tripNotifierProvider.notifier).replaceNamedAndUpdateTrip(newList);
    state = newList;
  }
}
