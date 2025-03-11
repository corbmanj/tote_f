import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tote_f/consumers/update_outfit.dart';
import 'package:tote_f/models/trip/outfit.dart';
import 'package:tote_f/models/user/outfit_template.dart';

class SelectOutfitType extends ConsumerWidget {
  const SelectOutfitType({
    super.key,
    required this.options,
    required this.dayIndex,
    required this.ordering,
    required this.outfit,
  });
  final List<OutfitTemplate> options;
  final int dayIndex;
  final int ordering;
  final Outfit? outfit;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (outfit == null) {
      return Container();
    }

    final OutfitTemplate outfitType =
        options.firstWhere((template) => template.type == outfit!.type);

    return DropdownButton<OutfitTemplate>(
      value: outfitType,
      underline: const SizedBox(
        height: 0,
      ),
      onChanged: (OutfitTemplate? value) {
        if (value != null && value != outfitType) {
          ref
              .read(updateOutfitProvider.notifier)
              .updateOutfitType(dayIndex, ordering, value);
        }
      },
      items:
          options.map<DropdownMenuItem<OutfitTemplate>>((OutfitTemplate value) {
        return DropdownMenuItem<OutfitTemplate>(
          value: value,
          child: Text(
            value.type,
            style: const TextStyle(fontSize: 10),
          ),
        );
      }).toList(),
    );
  }
}
