import 'package:flutter/material.dart';
import 'package:tote_f/pages/Select/select_outfit.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tote_f/providers/trip_provider.dart';
import '../../shared/day_header.dart';

class SelectDay extends ConsumerWidget {
  final int index;
  const SelectDay({super.key, required this.index});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dayRef = ref.watch(tripNotifierProvider.select((trip) => trip.days[index]));
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0.0, 1.0),
              blurRadius: 6.0,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DayHeader(day: dayRef),
            const Divider(
              thickness: 4,
            ),
            SelectOutfit(dayIndex: index),
          ],
        ),
      ),
    );
  }
}
