import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tote_f/models/tote/named.dart';
import 'package:tote_f/providers/named_items_provider.dart';

part 'update_named.g.dart';

@riverpod
class UpdateNamed extends _$UpdateNamed {
  @override
  void build() {}

  void addNamed(String parentType) {
    final newItem = Named('new name', parentType, -1);
    ref.read(namedItemsNotifierProvider.notifier).addNamed(newItem);
  }

  void updateName(String newName, int ordering) {
    ref.read(namedItemsNotifierProvider.notifier).updateName(newName, ordering);
  }
}