import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tote_f/consumers/update_additional.dart';
import 'package:tote_f/models/tote/additional_item.dart';
import 'package:tote_f/models/tote/additional_item_section.dart';
import 'package:tote_f/pages/Assign/editable_additional_chip.dart';
import 'package:tote_f/providers/additional_items_provider.dart';

class AssignAdditionalItems extends ConsumerStatefulWidget {
  const AssignAdditionalItems({super.key});
  @override
  ConsumerState createState() => _AssignAdditionalItemsState();
}

class _AssignAdditionalItemsState extends ConsumerState<AssignAdditionalItems> {
  AdditionalItemSection? _selectedItem;
  bool _isEditing = false;

  void setSelected(AdditionalItemSection? newItem) {
    setState(() {
      _selectedItem = newItem;
    });
  }
  
  void setEditing(bool newValue) {
    setState(() {
      _isEditing = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<AdditionalItemSection> sections =
        ref.watch(additionalItemsNotifierProvider);
    if (_selectedItem == null) {
      setSelected(sections.firstOrNull);
    }
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
              sections.isEmpty
                  ? Container()
                  : Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 8, 4),
                      child: IntrinsicHeight(
                        child: Row(
                          children: [
                            Column(
                              children: sections
                                  .map((section) => GestureDetector(
                                        child: Text(
                                          section.name,
                                          style: section.name ==
                                                  _selectedItem!.name
                                              ? const TextStyle(
                                                  color: Colors.blue)
                                              : null,
                                        ),
                                        onTap: () => setSelected(section),
                                      ))
                                  .toList(),
                            ),
                            const VerticalDivider(
                              thickness: 2,
                              color: Colors.grey,
                            ),
                            AssignedAdditionalItems(
                              selectedSection: _selectedItem!,
                              isEditing: _isEditing,
                              setEditing: setEditing,
                            )
                          ],
                        ),
                      ),
                    ),
            ],
          )
        ],
      ),
    );
  }
}

class AssignedAdditionalItems extends ConsumerWidget {
  final AdditionalItemSection selectedSection;
  final bool isEditing;
  final Function(bool) setEditing;
  const AssignedAdditionalItems({
    super.key,
    required this.selectedSection,
    required this.isEditing,
    required this.setEditing,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final addItemProvider = ref.read(updateAdditionalProvider.notifier);
    return Expanded(
      child: Wrap(
        spacing: 4.0,
        runSpacing: 8.0,
        children: [
          ...selectedSection.items.map((AdditionalItem item) =>
              EditableAdditionalChip(
                  item: item,
                  section: selectedSection,
                  setParentEditing: setEditing)),
          isEditing
              ? Container()
              : ElevatedButton(
                  onPressed: () {
                    addItemProvider.addAdditionalToSection(selectedSection);
                    setEditing(true);
                  },
                  child: const Text('add item'))
        ],
      ),
    );
  }
}
