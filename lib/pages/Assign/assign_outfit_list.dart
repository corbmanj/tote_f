import 'package:flutter/material.dart';
import 'package:tote_f/view_models/expansion_outfit.dart';

import 'assign_outfit_items.dart';

class AssignOutfitList extends StatefulWidget {
  final List<ExpansionOutfit> outfits;
  final int dayIndex;
  const AssignOutfitList({
    super.key,
    required this.outfits,
    required this.dayIndex,
  });

  @override
  State<AssignOutfitList> createState() => _AssignOutfitListState();
}

class _AssignOutfitListState extends State<AssignOutfitList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: _buildPanel(),
    );
  }

  Widget _buildPanel() {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          widget.outfits[index].isExpanded = isExpanded;
        });
      },
      children: widget.outfits.map<ExpansionPanel>((ExpansionOutfit outfit) {
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) =>
              Text(outfit.headerValue),
          body: AssignOutfitItems(
              outfit: outfit.expandedValue, dayIndex: widget.dayIndex),
          isExpanded: outfit.isExpanded,
        );
      }).toList(),
    );
  }
}
