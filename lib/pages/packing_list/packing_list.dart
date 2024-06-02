import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tote_f/pages/load/load_trip.dart';
import 'package:tote_f/pages/packing_list/named_items_to_pack.dart';
import 'package:tote_f/pages/packing_list/unnamed_items_to_pack.dart';
import 'package:tote_f/providers/packing_list_provider.dart';

class PackingList extends ConsumerWidget {
  const PackingList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final packingListRef = ref.watch(packingListNotifierProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Packing List')),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      NamedItemsToPack(namedItems: packingListRef.namedItems),
                      UnnamedItemsToPack(unnamedItems: packingListRef.unnamedItems),
                    ],
                  ),
                ),
              ),
            ],
          ),
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
          if (value == 1)
            {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const LoadTrip()));
            }
          else
            {Navigator.pop(context);}
        },
      ),
    );
  }
}
