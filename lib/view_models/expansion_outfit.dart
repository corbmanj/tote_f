import 'package:tote_f/models/tote/outfit.dart';

class ExpansionOutfit {
  ExpansionOutfit({
    required this.expandedValue,
    required this.headerValue,
    this.isExpanded = false,
  });

  Outfit expandedValue;
  String headerValue;
  bool isExpanded;
}
