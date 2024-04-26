import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tote_f/models/user/outfit_item.dart';

part 'assign_items_state.g.dart';

class AssignStateType {
  List<int> expanded;
  OutfitItem? selected;
  AssignStateType(
    this.expanded,
    [this.selected]
  );
}

@riverpod
class AssignItemsState extends _$AssignItemsState {
  @override
  AssignStateType build() {
    return AssignStateType([-1, -1]);
  }

  void setExpanded(int dayIndex, int outfitIndex) {
    state = AssignStateType([dayIndex, outfitIndex], state.selected);
  }

  void setSelectedItem(OutfitItem newSelectedItem) {
    state = AssignStateType(state.expanded, newSelectedItem);
  }
}
