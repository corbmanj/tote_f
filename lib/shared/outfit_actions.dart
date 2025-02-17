import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:tote_f/consumers/update_day.dart';
import 'package:tote_f/models/trip/day.dart';
import 'package:tote_f/models/trip/outfit.dart';
import 'package:tote_f/models/trip/trip.dart';
import 'package:tote_f/providers/trip_provider.dart';
import 'package:tote_f/shared/copy_outfit.dart';

class OutfitActions extends ConsumerWidget {
  final Outfit outfit;
  final int dayIndex;
  const OutfitActions({
    super.key,
    required this.outfit,
    required this.dayIndex,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Day> daysRef =
        ref.watch(tripNotifierProvider.select((Trip trip) => trip.days));
    final Day day = daysRef[dayIndex];

    void openCopyModal() {
      showModalBottomSheet(
          context: context,
          builder: (context) =>
              CopyOutfit(outfit: outfit, days: daysRef, currentDay: day));
    }

    void deleteOutfit() {
      final updateDayRef = ref.read(updateDayProvider.notifier);
      updateDayRef.deleteOutfitFromDay(outfit, day);
    }

    final dateString = DateFormat('E, MMM d').format(day.day);

    return Column(
      children: [
        Text('${outfit.name} - $dateString'),
        ListTile(
          leading: const Icon(Icons.copy),
          title: const Text('Copy Outfit'),
          onTap: () {
            Navigator.pop(context);
            openCopyModal();
          },
        ),
        ListTile(
            leading: const Icon(Icons.delete),
            title: const Text('Delete Outfit'),
            onTap: () {
              deleteOutfit();
              Navigator.pop(context);
            }),
      ],
    );
  }
}
