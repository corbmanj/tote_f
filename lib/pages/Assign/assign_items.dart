import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tote_f/pages/Select/select_outfits.dart';
import 'package:tote_f/providers/trip_provider.dart';

import 'assign_day.dart';

class AssignItems extends ConsumerWidget {
  const AssignItems({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tripRef = ref.watch(tripNotifierProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Assign Items')),
      body: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: tripRef.days.length,
        itemBuilder: (BuildContext context, int index) =>
            AssignDay(index: index),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedIconTheme: const IconThemeData(color: Colors.blueGrey),
        selectedItemColor: Colors.blueGrey,
        unselectedIconTheme: const IconThemeData(
          color: Colors.blueGrey,
        ),
        unselectedItemColor: Colors.blueGrey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.arrow_back),
            label: "back",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.arrow_forward),
            label: "next",
          ),
        ],
        onTap: (value) => {
          if (value == 0)
            {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SelectOutfits()))
            }
        },
      ),
    );
  }
}
