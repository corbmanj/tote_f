import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tote_f/consumers/update_day.dart';
import 'package:tote_f/fixtures/mock_trip.dart';
import 'package:tote_f/models/tote/day.dart';

import '../../view_models/expansion_outfit.dart';
import 'outfit_list.dart';

class SelectOutfit extends ConsumerWidget {
  final Day? day;
  final int dayIndex;
  const SelectOutfit({super.key, required this.day, required this.dayIndex});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (day == null || day!.outfits == null) {
      return Container();
    }
    final newOutfitType = outfitTypeList[0];
    final outfits = day!.outfits!
        .map((outfit) => ExpansionOutfit(
              expandedValue: outfit,
              headerValue: outfit.name,
              ordering: outfit.ordering,
            ))
        .toList();
    return Column(
      children: [
        OutfitList(outfits: outfits, dayIndex: dayIndex),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
                onPressed: () {
                  ref
                      .read(updateDayProvider.notifier)
                      .addOutfitToDay(dayIndex, newOutfitType);
                },
                icon: const Icon(Icons.add))
          ],
        ),
      ],
    );
  }
}
