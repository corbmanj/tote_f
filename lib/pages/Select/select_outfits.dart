import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tote_f/pages/Assign/assign_items.dart';
import 'package:tote_f/pages/Select/select_day.dart';
import 'package:tote_f/providers/trip_provider.dart';

class SelectOutfits extends ConsumerWidget {
  const SelectOutfits({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int dayCountRef = ref.watch(tripNotifierProvider.select((value) => value.days.length));
    final String cityNameRef = ref.watch(tripNotifierProvider.select((value) => value.city));
    return Scaffold(
      appBar: AppBar(title: Text(cityNameRef)),
      body: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: dayCountRef,
        itemBuilder: (BuildContext context, int index) =>
            SelectDay(index: index),
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
          if (value == 1)
            {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AssignItems()))
            }
        },
      ),
    );
  }
}
