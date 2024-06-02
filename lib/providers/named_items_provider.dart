import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tote_f/models/tote/named.dart';

part 'named_items_provider.g.dart';

@Riverpod(keepAlive: true)
class NamedItemsNotifier extends _$NamedItemsNotifier {
  @override
  List<Named> build() {
    return [];
  }

  void updateName(String newName, int ordering) {
    List<Named> newList = state.map((Named item) =>
        item.ordering == ordering ? item.copyWith(name: newName, ordering: ordering == -1 ? state.length : ordering) : item).toList();
    state = newList;
  }

  void addNamed(Named newItem) {
    List<Named> newList = [...state];
    newList.add(newItem);
    state = newList;
  }
}
