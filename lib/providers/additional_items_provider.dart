import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tote_f/models/tote/additional_item_section.dart';

part 'additional_items_provider.g.dart';

@Riverpod(keepAlive: true)
class AdditionalItemsNotifier extends _$AdditionalItemsNotifier {
  @override
  List<AdditionalItemSection> build() {
    return [];
  }

  void loadList(List<AdditionalItemSection> newList) {
    state = newList;
  }

  void updateSectionInList(AdditionalItemSection itemSection) {
    state = state
        .map((AdditionalItemSection section) =>
            section.name == itemSection.name ? itemSection : section)
        .toList();
  }
}
