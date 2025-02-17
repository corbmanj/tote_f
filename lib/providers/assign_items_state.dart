import 'package:collection/collection.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tote_f/models/trip/outfit_item.dart';

part 'assign_items_state.g.dart';

Function listEq = const ListEquality().equals;

class AssignStateType {
  List<int> expanded;
  OutfitItem? selected;
  AssignStateType(this.expanded, [this.selected]);
}

@riverpod
class AssignItemsState extends _$AssignItemsState {
  @override
  AssignStateType build() {
    return AssignStateType([-1, -1]);
  }

  void setExpanded(int dayIndex, int outfitIndex) {
    if (listEq(state.expanded, [dayIndex, outfitIndex])) {
      state = AssignStateType([-1, -1], state.selected);
    } else {
      state = AssignStateType([dayIndex, outfitIndex], state.selected);
    }
  }

  void setSelectedItem(OutfitItem newSelectedItem) {
    state = AssignStateType(state.expanded, newSelectedItem);
  }

  void clearSelected() {
    state = AssignStateType(state.expanded, null);
  }
}
