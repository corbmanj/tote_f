import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tote_f/models/tote/named.dart';

part 'named_items_provider.g.dart';

@Riverpod(keepAlive: true)
class NamedItemsNotifier extends _$NamedItemsNotifier {
  @override
  List<Named> build() {
    return [];
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
    return updatedItem;
  }

  void addNamed(Named newItem) {
    List<Named> newList = [...state];
    newList.add(newItem);
    state = newList;
  }
}
