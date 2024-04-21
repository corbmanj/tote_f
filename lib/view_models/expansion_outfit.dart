import 'package:tote_f/models/tote/outfit.dart';

class ExpansionOutfit {
  ExpansionOutfit({
    required this.expandedValue,
    required this.headerValue,
    required this.ordering,
    this.isExpanded = false,
  });

  Outfit expandedValue;
  String headerValue;
  int ordering;
  bool isExpanded;
}
