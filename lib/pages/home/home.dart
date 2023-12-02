import 'package:flutter/material.dart';
import '../load/load_trip.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
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
                print("you can't do that yet");
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
