import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tote_f/consumers/create_trip_consumer.dart';
import 'package:tote_f/models/trip_meta.dart';
import 'package:tote_f/pages/Select/select_outfits.dart';
import 'package:tote_f/providers/trip_meta_provider.dart';
import 'package:tote_f/shared/editable_text.dart';
import 'package:tote_f/utils/date_formatter.dart';

class CreateTrip extends ConsumerWidget {
  const CreateTrip({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TripMeta tripMetaRef = ref.watch(tripMetaNotifierProvider);
    final tripMetaProvider = ref.read(tripMetaNotifierProvider.notifier);
    final tripProvider = ref.read(createTripConsumerProvider.notifier);

    Future openDatePicker() async {
      final result = await showDateRangePicker(
        context: context,
        initialDateRange: DateTimeRange(
            start: tripMetaRef.dateRange.start, end: tripMetaRef.dateRange.end),
        firstDate: DateTime.now(),
        lastDate: DateTime(2050),
      );

      if (result != null) {
        tripMetaProvider.updateDates(result);
      }
    }

    final formattedStartDate = formatter.format(tripMetaRef.dateRange.start);
    final formattedEndDate = formatter.format(tripMetaRef.dateRange.end);
    return Scaffold(
      appBar: AppBar(title: const Text("Create a Trip")),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => openDatePicker(),
                child: Text(formattedStartDate),
              ),
              const SizedBox(width: 50.0),
              ElevatedButton(
                onPressed: openDatePicker,
                child: Text(formattedEndDate),
              ),
            ],
          ),
          const SizedBox(height: 50.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: EditText(
                        textValue: tripMetaRef.name,
                        textLabel: "Trip Name",
                        updateText: tripMetaProvider.updateName),
                  ))
            ],
          ),
          const SizedBox(height: 50.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: EditText(
                        textValue: tripMetaRef.city,
                        textLabel: "City, ST",
                        updateText: tripMetaProvider.updateCity),
                  ))
            ],
          )
        ],
      )),
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
        onTap: (value) async {
          if (value == 1) {
            final trip = await tripProvider.createTripFromSchedule(tripMetaRef);
            if (trip != null && trip.days.isNotEmpty) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SelectOutfits()));
            } else {
              print('Error: Trip creation failed or has no days');
            }
          } else {
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
