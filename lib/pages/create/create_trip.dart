import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tote_f/consumers/create_trip_consumer.dart';
import 'package:tote_f/models/trip/trip.dart';
import 'package:tote_f/pages/Select/select_outfits.dart';
import 'package:tote_f/providers/trip_provider.dart';
import 'package:tote_f/shared/editable_text.dart';
import 'package:tote_f/utils/date_formatter.dart';

class CreateTrip extends ConsumerWidget {
  const CreateTrip({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Trip tripRef = ref.watch(tripNotifierProvider);
    final tripProvider = ref.read(createTripConsumerProvider.notifier);
    final bool hasOutfits = tripRef.days
        .any((day) => day.outfits != null && day.outfits!.isNotEmpty);

    Future openDatePicker() async {
      final result = await showDateRangePicker(
        context: context,
        initialDateRange: DateTimeRange(
            start: tripRef.dateRange.start, end: tripRef.dateRange.end),
        firstDate: DateTime.now(),
        lastDate: DateTime(2050),
      );

      if (result != null) {
        tripProvider.updateDates(result);
      }
    }

    Future<void> openWarningDialog() async {
      return showDialog<void>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Reset Current Trip?"),
              content: const SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text(
                        'Warning, you have already added outfits to your trip.'),
                    Text('Would you like to RESET the trip with new dates or leave the trip unchanged'),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('RESET'),
                  onPressed: () {
                    tripProvider.createTripFromSchedule(reset: true);
                    Navigator.pop(context, 'reset');
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SelectOutfits()));
                  },
                ),
                TextButton(
                  child: const Text('Continue unchanged'),
                  onPressed: () {
                    Navigator.pop(context, 'continue');
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SelectOutfits()));
                  },
                ),
              ],
            );
          });
    }

    final formattedStartDate = formatter.format(tripRef.dateRange.start);
    final formattedEndDate = formatter.format(tripRef.dateRange.end);
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
          const SizedBox(height: 100.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                  width: 150.0,
                  height: 40.0,
                  child: EditText(
                      textValue: tripRef.city,
                      textLabel: "City, ST",
                      updateText: tripProvider.updateCity))
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
        onTap: (value) {
          if (value == 1) {
            if (hasOutfits) {
              openWarningDialog();
            } else {
              tripProvider.createTripFromSchedule();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SelectOutfits()));
            }
          } else {
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
