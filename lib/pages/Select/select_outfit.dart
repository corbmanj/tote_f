import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tote_f/fixtures/mock_trip.dart';
import 'package:tote_f/models/trip.dart';

import '../../view_models/expansion_outfit.dart';
import 'outfit_list.dart';

class SelectOutfit extends HookConsumerWidget {
  final int dayIndex;
  const SelectOutfit({super.key, required this.dayIndex});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dayRef =
        ref.watch(tripProvider.select((trip) => trip.days[dayIndex]));
    final newOutfitType = outfitTypeList[0];
    final outfits = dayRef.outfits!
        .map((outfit) => ExpansionOutfit(
              expandedValue: outfit,
              headerValue: outfit.name,
            ))
        .toList();
    if (dayRef.outfits == null) {
      return Container();
    }
    return Column(
      children: [
        OutfitList(outfits: outfits, dayIndex: dayIndex),
        ElevatedButton(
          onPressed: () {
            ref
                .read(tripProvider.notifier)
                .addOutfitToDay(dayIndex, newOutfitType);
          },
          child: const Text("Add Outfit"),
        )
      ],
    );
  }
}
