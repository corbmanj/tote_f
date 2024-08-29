import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tote_f/consumers/create_trip_consumer.dart';
import 'package:tote_f/pages/create/create_trip.dart';
import '../load/load_trip.dart';

class Home extends ConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text("Welcome To Tote"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                maximumSize: const Size(200, 50),
                minimumSize: const Size(200, 50),
              ),
              onPressed: () {
                ref.read(createTripConsumerProvider.notifier).initializeNewTrip();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: ((context) => const CreateTrip())),
                );
              },
              child: const Text("Plan a New Trip"),
            ),
            const SizedBox(
              height: 50,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                maximumSize: const Size(200, 50),
                minimumSize: const Size(200, 50),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: ((context) => const LoadTrip())),
                );
              },
              child: const Text("Load a Trip"),
            )
          ],
        ),
      ),
    );
  }
}
