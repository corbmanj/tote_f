import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tote_f/consumers/update_day.dart';
import 'package:tote_f/fixtures/mock_trip.dart';
import 'package:tote_f/providers/trip_provider.dart';

import '../../view_models/expansion_outfit.dart';
import 'outfit_list.dart';

class SelectOutfit extends ConsumerWidget {
  final int dayIndex;
  const SelectOutfit({super.key, required this.dayIndex});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dayRef =
        ref.watch(tripNotifierProvider.select((trip) => trip.days[dayIndex]));
    final newOutfitType = outfitTypeList[0];
    final outfits = dayRef.outfits!
        .map((outfit) => ExpansionOutfit(
              expandedValue: outfit,
              headerValue: outfit.name,
              ordering: outfit.ordering,
            ))
        .toList();
    if (dayRef.outfits == null) {
      return Container();
    }
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
