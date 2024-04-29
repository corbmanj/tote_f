import 'package:flutter/material.dart';
import 'package:tote_f/pages/Select/select_outfits.dart';
import 'package:tote_f/pages/home/home.dart';
import 'package:tote_f/utils/date_formatter.dart';

class CreateTrip extends StatefulWidget {
  const CreateTrip({super.key});

  @override
  State createState() => _CreateTripState();
}

class _CreateTripState extends State<CreateTrip> {
  DateTimeRange _dateTimeRange =
      DateTimeRange(start: DateTime.now(), end: DateTime.now());

  setDateRange(DateTimeRange newRange) {
    setState(() {
      _dateTimeRange = newRange;
    });
  }

  Future openDatePicker() async {
    final result = await showDateRangePicker(
      context: context,
      initialDateRange: _dateTimeRange,
      firstDate: DateTime(2000), // tanggal awal yang diperbolehkan di pilih
      lastDate: DateTime(2100), // tanggal akhir yang diperbolehkan di pilih
    );

    if (result != null) {
      setState(() {
        _dateTimeRange = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final formattedStartDate = formatter.format(_dateTimeRange.start);
    final formattedEndDate = formatter.format(_dateTimeRange.end);
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
                onPressed: openDatePicker,
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
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 150.0,
                height: 40.0,
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'City, ST',
                  ),
                ),
              )
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
          final Widget page = value == 1 ? const SelectOutfits() : const Home();

          Navigator.push(
              context, MaterialPageRoute(builder: (context) => page));
        },
      ),
    );
  }
}
