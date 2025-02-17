import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:tote_f/consumers/update_outfit.dart';
import 'package:tote_f/models/trip/day.dart';
import 'package:tote_f/models/trip/outfit.dart';

class CopyOutfit extends ConsumerStatefulWidget {
  final Outfit outfit;
  final List<Day> days;
  final Day currentDay;
  const CopyOutfit({
    super.key,
    required this.outfit,
    required this.days,
    required this.currentDay,
  });

  @override
  ConsumerState createState() => _CopyOutfitState();
}

class _CopyOutfitState extends ConsumerState<CopyOutfit> {
  List<int> _selectedDays = [];

  void setSelected(int clickedDayCode) {
    setState(() {
      if (_selectedDays.contains(clickedDayCode)) {
        _selectedDays =
            _selectedDays.whereNot((int el) => el == clickedDayCode).toList();
      } else {
        _selectedDays.add(clickedDayCode);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final dateFormatter = DateFormat('E, MMM d');
    final updateOutfitsRef = ref.read(updateOutfitProvider.notifier);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            automaticallyImplyLeading: false,
            leading: null,
            expandedHeight: 10.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: RichText(
                  text: TextSpan(
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                      ),
                      children: [
                    const TextSpan(text: 'Copy '),
                    TextSpan(
                        text: widget.outfit.name,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(
                        text:
                            ' (${dateFormatter.format(widget.currentDay.day)}) to:'),
                  ])),
            ),
          ),
        ],
        body: Column(
          children: [
            Expanded(
              child: ListView(
                children: widget.days
                    .map((Day day) => CheckboxListTile(
                          title: Text('${dateFormatter.format(day.day)} ${day.day == widget.currentDay.day ? '(current day)' : ''}'),
                          controlAffinity: ListTileControlAffinity.leading,
                          value: _selectedDays.contains(day.dayCode),
                          onChanged: (value) {
                            setSelected(day.dayCode);
                          },
                        ))
                    .toList(),
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      updateOutfitsRef.copyOutfitToDays(
                          _selectedDays, widget.outfit);
                      Navigator.pop(context);
                    },
                    child: const Text('Apply'),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
