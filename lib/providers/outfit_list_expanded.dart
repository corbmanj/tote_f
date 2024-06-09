import 'package:collection/collection.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'outfit_list_expanded.g.dart';

Function listEq = const ListEquality().equals;

class OutfitExpandedType {
  List<int> expanded;
  bool editing;
  OutfitExpandedType(this.expanded, this.editing);
}

@riverpod
class OutfitListExpanded extends _$OutfitListExpanded {
  @override
  OutfitExpandedType build() {
    return OutfitExpandedType([-1, -1], false);
  }

  Future<void> setExpanded(int dayIndex, int outfitIndex) async {
    if (listEq(state.expanded, [dayIndex, outfitIndex])) {
      state = OutfitExpandedType([-1, -1], false);
    } else {
      state = OutfitExpandedType([dayIndex, outfitIndex], false);
    }
  }

  Future<void> setEditing(bool newEditing) async {
    state = OutfitExpandedType(state.expanded, newEditing);
  }

  Future<void> setEditingAndExpanded(
    int dayIndex,
    int outfitIndex,
    bool newEditing,
  ) async {
    if (listEq(state.expanded, [dayIndex, outfitIndex])) {
      state = OutfitExpandedType([-1, -1], false);
    } else {
      state = OutfitExpandedType([dayIndex, outfitIndex], newEditing);
    }
  }
}
