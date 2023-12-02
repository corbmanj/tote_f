import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tote_f/models/trip.dart';
import '../../fixtures/mock_trip.dart';
import '../Select/select_outfits.dart';

class LoadTrip extends HookConsumerWidget {
  const LoadTrip({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Start Here"),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(8.0),
        itemCount: trips.length,
        itemBuilder: (BuildContext context, int index) =>
            _buildTile(context, index, ref),
        separatorBuilder: ((context, index) => const Divider()),
      ),
    );
  }

  Widget _buildTile(BuildContext context, int index, WidgetRef ref) {
    final currentTrip = trips[index];
    final state = currentTrip.city.split(',')[1].trim();
    return ListTile(
      onTap: () {
        ref.read(tripProvider.notifier).loadTrip(trip);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const SelectOutfits()));
      },
      leading: CircleAvatar(child: Text(state)),
      title: Text(currentTrip.city),
      subtitle: Text(currentTrip.startDate.toString()),
    );
  }
}
