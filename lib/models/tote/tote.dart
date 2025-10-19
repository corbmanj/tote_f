import 'package:tote_f/providers/user_additional_items_provider.dart';
import 'additional_item_section.dart';
import './additional_item.dart';
import './named.dart';
import './unnamed.dart';

class Tote {
  List<Unnamed> unnamed;
  List<Named> named;
  List<AdditionalItemSection> additionalItems;

  Tote({
    required this.named,
    required this.unnamed,
    required this.additionalItems,
  });

  Map toJson() => {
        'unnamed': unnamed,
        'named': named,
        'additionalItems': additionalItems
      };

  factory Tote.fromMap(Map<String, dynamic> map) {
    return Tote(
      named: (map['named'] as List? ?? [])
          .map<Named>((named) => Named.fromMap(named))
          .toList(),
      unnamed: (map['unnamed'] as List? ?? [])
          .map<Unnamed>((unnamed) => Unnamed.fromMap(unnamed))
          .toList(),
      additionalItems: (map['additionalItems'] as List? ?? [])
          .map<AdditionalItemSection>(
              (additional) => AdditionalItemSection.fromMap(additional))
          .toList(),
    );
  }

  factory Tote.fromUserAdditionalItemsAndSections({
    required List<Named> named,
    required List<Unnamed> unnamed,
    required UserAdditionalItemsAndSections userData,
  }) {
    // Map section templates to AdditionalItemSection
    final sections = userData.userAdditionalItemSections.map((sectionTemplate) {
      final items = userData.userAdditionalItems
          .where((item) => item.sectionId == sectionTemplate.id)
          .map((item) => AdditionalItem(item.name, item.defaultIncluded))
          .toList();
      return AdditionalItemSection(sectionTemplate.name, items);
    }).toList();
    // Handle unassigned items (sectionId == null)
    final unassignedItems = userData.userAdditionalItems
        .where((item) => item.sectionId == null)
        .map((item) => AdditionalItem(item.name, item.defaultIncluded))
        .toList();
    if (unassignedItems.isNotEmpty) {
      sections.add(AdditionalItemSection('Unassigned', unassignedItems));
    }
    return Tote(named: named, unnamed: unnamed, additionalItems: sections);
  }
}

extension MutableTote on Tote {
  Tote copyWith(
      {List<Unnamed>? unnamed,
      List<Named>? named,
      List<AdditionalItemSection>? additionalItems}) {
    return Tote(
        unnamed: unnamed ?? this.unnamed,
        named: named ?? this.named,
        additionalItems: additionalItems ?? this.additionalItems);
  }
}
