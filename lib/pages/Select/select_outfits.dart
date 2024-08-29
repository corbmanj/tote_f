import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tote_f/models/trip.dart';
import 'package:tote_f/pages/Assign/assign_items.dart';
import 'package:tote_f/pages/Select/select_day.dart';
import 'package:tote_f/providers/trip_provider.dart';

class SelectOutfits extends ConsumerWidget {
  const SelectOutfits({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Trip tripRef = ref.watch(tripNotifierProvider);
    int dayCount = tripRef.days.length;
    String cityName = tripRef.city;
    if (dayCount == 0) {
      return Container();
    }
    return Scaffold(
      appBar: AppBar(title: Text(cityName)),
      body: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: dayCount,
        itemBuilder: (BuildContext context, int index) =>
            SelectDay(day: tripRef.days[index], dayIndex: index,),
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
          else
            {Navigator.pop(context)}
        },
      ),
    );
  }
}
