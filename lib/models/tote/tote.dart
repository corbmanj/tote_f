import 'dart:convert';

import 'additional_item_section.dart';
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
        'unnamed': jsonEncode(unnamed),
        'named': jsonEncode(named),
        'additionalItems': jsonEncode(additionalItems)
      };

  factory Tote.fromMap(Map<String, dynamic> map) {
    return Tote(
      named: jsonDecode(map['named'] ?? '[]')
          .map<Named>((named) => Named.fromMap(named))
          .toList(),
      unnamed: jsonDecode(map['unnamed'] ?? '[]')
          .map<Unnamed>((unnamed) => Unnamed.fromMap(unnamed))
          .toList(),
      additionalItems: jsonDecode(map['additionalItems'] ?? '[]')
          .map<AdditionalItemSection>(
              (additional) => AdditionalItemSection.fromMap(additional))
          .toList(),
    );
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
