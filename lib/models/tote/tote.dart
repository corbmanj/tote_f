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
}
