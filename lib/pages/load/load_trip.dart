import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:tote_f/consumers/load_trip.dart';
import 'package:tote_f/models/trip_meta.dart';
import 'package:tote_f/providers/trip_list_provider.dart';
import 'package:tote_f/providers/trip_provider.dart';
import '../Select/select_outfits.dart';

class LoadTrip extends ConsumerWidget {
  const LoadTrip({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(tripNotifierProvider);
    final AsyncValue<List<TripMeta>> tripList = ref.watch(tripListProvider);
    return Scaffold(
        appBar: AppBar(
          title: const Text("Start Here"),
        ),
        body: switch (tripList) {
          AsyncData(:final value) => TripList(tripList: value),
          AsyncError() => const Text('Oops, something unexpected happened'),
          _ => const CircularProgressIndicator(),
        });
  }
}

class TripList extends StatelessWidget {
  final List<TripMeta> tripList;
  const TripList({super.key, required this.tripList});

  

  @override
  Widget build(BuildContext context) {
    tripList.sort((a, b) => b.dateRange.start.compareTo(a.dateRange.start));
    return ListView.separated(
      padding: const EdgeInsets.all(8.0),
      itemCount: tripList.length,
      itemBuilder: (BuildContext context, int index) => TripTile(
        trip: tripList[index],
      ),
      separatorBuilder: ((context, index) => const Divider()),
    );
  }
}

class TripTile extends ConsumerWidget {
  final TripMeta trip;
  const TripTile({super.key, required this.trip});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final startDateString = DateFormat('E, MMM d').format(trip.dateRange.start);
    final endDateString = DateFormat('E, MMM d').format(trip.dateRange.end);
    final loadTripConsumer = ref.read(loadTripProvider.notifier);
    final state = trip.city.split(',').last.trim();
    return Slidable(
      key: ValueKey(trip.id),
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            onPressed: (BuildContext context) {
              loadTripConsumer.deleteTrip(trip.id);
            },
          ),
        ],
      ),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            onPressed: (BuildContext context) {
              loadTripConsumer.deleteTrip(trip.id);
            },
          ),
        ],
      ),
      child: ListTile(
        onTap: () {
          loadTripConsumer.loadTrip(trip.id);
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const SelectOutfits()));
        },
        leading: CircleAvatar(child: Text(state)),
        title: Text(trip.city),
        subtitle: Text('$startDateString - $endDateString'),
      ),
    );
  }
}
