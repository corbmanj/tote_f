import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tote_f/pages/create/create_trip.dart';
import 'package:tote_f/pages/settings/settings_page.dart';
import 'package:tote_f/providers/trip_meta_provider.dart';
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
                ref.read(tripMetaNotifierProvider.notifier).reset();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: ((context) => const CreateTrip())),
                );
              },
              child: const Text("Plan a New Trip"),
            ),
            const SizedBox(
              height: 40,
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
            ),
            const SizedBox(
              height: 40,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                maximumSize: const Size(200, 50),
                minimumSize: const Size(200, 50),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: ((context) => const SettingsPage())),
                );
              },
              child: const Text("Setup Outfits"),
            )
          ],
        ),
      ),
    );
  }
}
