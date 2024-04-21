import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tote_f/consumers/update_outfit.dart';
import 'package:tote_f/models/user/outfit_template.dart';
import 'package:tote_f/providers/trip_provider.dart';

class SelectOutfitType extends ConsumerWidget {
  const SelectOutfitType(
      {super.key,
      required this.options,
      required this.dayIndex,
      required this.ordering});
  final List<OutfitTemplate> options;
  final int dayIndex;
  final int ordering;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final outfitRef = ref.watch(tripNotifierProvider.select((trip) => trip
        .days[dayIndex].outfits!
        .firstWhere((outfit) => outfit.ordering == ordering)));
    final OutfitTemplate outfitType = options.firstWhere((template) => template.type == outfitRef.type);

    return DropdownButton<OutfitTemplate>(value: outfitType, underline: const SizedBox(height: 0,), onChanged: (OutfitTemplate? value) {
      if (value != null) {
        ref.read(updateOutfitProvider.notifier).updateOutfitType(dayIndex, ordering, value);
      }
    },
    items: options.map<DropdownMenuItem<OutfitTemplate>>((OutfitTemplate value) {
      return DropdownMenuItem<OutfitTemplate>(
        value: value,
        child: Text(value.type, style: const TextStyle(fontSize: 10),),
      );
    }).toList(),
    );
  }
}
