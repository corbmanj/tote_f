import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tote_f/utils/get_day_icon.dart';
import '../models/tote/day.dart';

class DayHeader extends StatelessWidget {
  final Day day;
  const DayHeader({super.key, required this.day});

  @override
  Widget build(BuildContext context) {
    final date = day.day;
    final dateString = DateFormat('E, MMM d').format(date);
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 16.0, 0, 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(dateString),
              getDayIcon(day.icon),
              Column(
                children: [
                  Text('Low: ${day.low.round()}\u{00b0}F'),
                  Text('High: ${day.high.round()}\u{00b0}F'),
                ],
              )
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Text(day.summary),
        ],
      ),
    );
  }
}
