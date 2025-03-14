import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tote_f/pages/Assign/assign_additional_items.dart';
import 'package:tote_f/pages/packing_list/packing_list.dart';
import 'package:tote_f/providers/trip_provider.dart';

import 'assign_day.dart';

class AssignItems extends ConsumerWidget {
  const AssignItems({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tripRef = ref.watch(tripNotifierProvider);
    if (tripRef.days.isEmpty) {
      return Container();
    }
    return Scaffold(
      appBar: AppBar(title: const Text('Assign Items')),
      body: ListView(
        padding: const EdgeInsets.all(8.0),
        children: [const AssignAdditionalItems(),
        ...tripRef.days.asMap().entries.map((entry) => AssignDay(index: entry.key, day: entry.value))],
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
        onTap: (value) {
          if (value == 1) {
            Navigator.push(
              context, MaterialPageRoute(builder: (context) => const PackingList()));
          } else {
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
