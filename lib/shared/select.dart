import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tote_f/models/trip.dart';
import '../models/user/outfit_template.dart';

class Select extends ConsumerStatefulWidget {
  final List<OutfitTemplate> options;
  final OutfitTemplate typeFinal;
  final int dayIndex;
  final int ordering;
  const Select(
      {super.key,
      required this.options,
      required this.typeFinal,
      required this.dayIndex,
      required this.ordering});

  @override
  SelectState createState() => SelectState();
}

class SelectState extends ConsumerState<Select> {
  // var dropdownValue = widget.type as OutfitTemplate;
  late OutfitTemplate dropdownValue = widget.typeFinal;
  @override
  void initState() {
    super.initState();
    ref.read(tripProvider);
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<OutfitTemplate>(
      value: widget.typeFinal,
      underline: const SizedBox(height: 0),
      onChanged: (OutfitTemplate? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
          ref
              .read(tripProvider.notifier)
              .changeOutfitType(widget.dayIndex, widget.ordering, value);
        });
      },
      items: widget.options.map<DropdownMenuItem<OutfitTemplate>>((
        OutfitTemplate value,
      ) {
        return DropdownMenuItem<OutfitTemplate>(
          value: value,
          child: Text(value.type, style: const TextStyle(fontSize: 10)),
        );
      }).toList(),
    );
  }
}
