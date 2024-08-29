import 'package:flutter/material.dart';
import 'package:tote_f/models/tote/day.dart';
import 'package:tote_f/pages/Select/select_outfit.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../shared/day_header.dart';

class SelectDay extends ConsumerWidget {
  final Day? day;
  final int dayIndex;
  const SelectDay({super.key, required this.day, required this.dayIndex});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (day == null) {
      return Container();
    }
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
            DayHeader(day: day!),
            const Divider(
              thickness: 4,
            ),
            SelectOutfit(day: day, dayIndex: dayIndex),
          ],
        ),
      ),
    );
  }
}
