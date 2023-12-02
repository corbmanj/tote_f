import 'package:flutter/material.dart';
import 'package:tote_f/models/tote/day.dart';

import '../../view_models/expansion_outfit.dart';
import 'assign_outfit_list.dart';

class AssignOutfit extends StatelessWidget {
  final int dayIndex;
  final Day day;
  const AssignOutfit({super.key, required this.dayIndex, required this.day});

  @override
  Widget build(BuildContext context) {
    final outfits = day.outfits!
        .map((outfit) => ExpansionOutfit(
              expandedValue: outfit,
              headerValue: outfit.name,
            ))
        .toList();
    if (day.outfits == null) {
      return Container();
    }
    return AssignOutfitList(outfits: outfits, dayIndex: dayIndex);
  }
}
