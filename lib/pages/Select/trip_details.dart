import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:tote_f/models/trip.dart';
import 'package:tote_f/providers/trip_provider.dart';

class TripDetails extends ConsumerWidget {
  const TripDetails({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Trip tripRef = ref.watch(tripNotifierProvider);
    final DateFormat formatter = DateFormat('MM/dd/yyyy');
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.red, title: Text(tripRef.city)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(tripRef.city),
            Text(formatter.format(tripRef.startDate)),
            Text(formatter.format(tripRef.endDate)),
          ],
        ),
      ),
    );
  }
}