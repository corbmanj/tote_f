import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tote_f/models/tote/additional_item_section.dart';
import 'package:tote_f/providers/additional_items_provider.dart';

class AssignAdditionalItems extends ConsumerStatefulWidget {
  const AssignAdditionalItems({super.key});
  @override 
  ConsumerState createState() => _AssignAdditionalItemsState();
}
  class _AssignAdditionalItemsState extends ConsumerState<AssignAdditionalItems> {
  late AdditionalItemSection? _selectedItem;
  
  void setSelected(AdditionalItemSection newItem) {
    setState(() {
      _selectedItem = newItem;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<AdditionalItemSection> sections = ref.watch(additionalItemsNotifierProvider)
    _selectedItem ??= sections.first;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0.0, 1.0),
            blurRadius: 6.0,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(child: Text('Additional Items')),
          const Divider(
            thickness: 4,
          ),
          Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 4),
          child: IntrinsicHeight(
            child: Row(
              children: [
                Column(
                    children: sections
                        .map((section) => GestureDetector(
                              child: Text(
                                section.name,
                                style: section.name == _selectedItem!.name
                                    ? const TextStyle(color: Colors.blue)
                                    : null,
                              ),
                              onTap: () =>
                                  setSelected(section),
                            ))
                        .toList()),
                const VerticalDivider(
                  thickness: 2,
                  color: Colors.grey,
                ),
                AssignedAdditionalItems(
                    selectedItem: _selectedItem!,
                    dayIndex: dayIndex,
                    outfitOrdering: outfit.ordering)
              ],
            ),
          ),
        ),
        NamedItemsForOutfit(outfit: outfit),
      ],
    );
        ],
      ),
    );
  }
}

class AssignedAdditionalItems extends ConsumerWidget {
  final AdditionalItemSection selectedItem;
  const AssignedAdditionalItems({super.key, required this.selectedItem});

  @override 
  Widget build(BuildContext context, WidgetRef ref) {
    return Container();
  }
}
