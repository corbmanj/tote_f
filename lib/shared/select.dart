import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tote_f/consumers/update_outfit.dart';
import '../models/user/outfit_template.dart';

class Select extends ConsumerStatefulWidget {
  const Select(
      {super.key,
      required this.options,
      required this.typeFinal,
      required this.dayIndex,
      required this.ordering});

  final List<OutfitTemplate> options;
  final OutfitTemplate typeFinal;
  final int dayIndex;
  final int ordering;

  @override
  ConsumerState<Select> createState() => _SelectState();
}

class _SelectState extends ConsumerState<Select> {
  // var dropdownValue = widget.type as OutfitTemplate;
  late OutfitTemplate dropdownValue = widget.typeFinal;
  // @override
  // void initState() {
  //   super.initState();
  // }

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
              .read(updateOutfitProvider.notifier)
              .updateOutfitType(widget.dayIndex, widget.ordering, value);
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
