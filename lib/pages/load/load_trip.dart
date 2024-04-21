import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tote_f/consumers/load_trip.dart';
import 'package:tote_f/providers/trip_provider.dart';
import '../../fixtures/mock_trip.dart';
import '../Select/select_outfits.dart';

class LoadTrip extends ConsumerWidget {
  const LoadTrip({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(tripNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Start Here"),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(8.0),
        itemCount: trips.length,
        itemBuilder: (BuildContext context, int index) =>
            TripTile(index: index,),
        separatorBuilder: ((context, index) => const Divider()),
      ),
    );
  }

  // Widget _buildTile(BuildContext context, int index, WidgetRef ref) {
  //   final currentTrip = trips[index];
  //   final state = currentTrip.city.split(',')[1].trim();
  //   return ListTile(
  //     onTap: () {
  //       ref.read(tripNotifierProvider.notifier).loadTrip(trip);
  //       Navigator.push(context,
  //           MaterialPageRoute(builder: (context) => const SelectOutfits()));
  //     },
  //     leading: CircleAvatar(child: Text(state)),
  //     title: Text(currentTrip.city),
  //     subtitle: Text(currentTrip.startDate.toString()),
  //   );
  // }
}

class TripTile extends ConsumerWidget {
  final int index;
  const TripTile({super.key, required this.index});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTrip = trips[index];
    final state = currentTrip.city.split(',')[1].trim();
    return ListTile(
      onTap: () {
        ref.read(loadTripProvider.notifier).loadTrip(currentTrip);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const SelectOutfits()));
      },
      leading: CircleAvatar(child: Text(state)),
      title: Text(currentTrip.city),
      subtitle: Text(currentTrip.startDate.toString()),
    );
  }
}
