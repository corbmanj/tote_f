import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tote_f/models/user/additional_item_section_template.dart';
import 'package:tote_f/models/user/additional_item_template.dart';
import 'package:tote_f/pages/settings/item_draggable_chip.dart';
import 'package:tote_f/pages/settings/section_header.dart';
import 'package:tote_f/providers/user_additional_items_provider.dart';

class SettingsAdditionalItems extends ConsumerWidget {
  const SettingsAdditionalItems({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final additionalItemsRef = ref.watch(userAdditionalItemsProvider);
    return switch (additionalItemsRef) {
      AsyncData(:final value) => ItemsAndSections(
          additionalItems: value.userAdditionalItems,
          sections: value.userAdditionalItemSections),
      _ => CircularProgressIndicator()
    };
  }
}

class ItemsAndSections extends ConsumerWidget {
  final List<AdditionalItemTemplate> additionalItems;
  final List<AdditionalItemSectionTemplate> sections;
  const ItemsAndSections(
      {super.key, required this.additionalItems, required this.sections});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final additionalItemsNotifier =
        ref.read(userAdditionalItemsProvider.notifier);
    return Column(
      children: [
        ItemsSection(
          items: additionalItems.where((i) => i.sectionId == null).toList(),
          notifier: additionalItemsNotifier,
        ),
        SizedBox(
          height: 10.0,
        ),
        SectionsSection(
          items: additionalItems,
          sections: sections,
          notifier: additionalItemsNotifier,
        ),
      ],
    );
  }
}

class ItemsSection extends StatelessWidget {
  final List<AdditionalItemTemplate> items;
  final UserAdditionalItems notifier;
  const ItemsSection({super.key, required this.items, required this.notifier});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black12, width: 2.0),
        ),
        child: Center(child: Text("Unassigned Items")),
      ),
      DragTarget(
        builder: (BuildContext context, _, __) => Container(
          height: 75.0,
          padding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
          color: Colors.black12,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (_, int index) => index == items.length ? AddChip(notifier: notifier) :
                DraggableSectionItem(item: items[index]),
            separatorBuilder: (_, __) => SizedBox(width: 10.0),
            itemCount: items.length + 1,
          ),
        ),
        onAcceptWithDetails:
            (DragTargetDetails<AdditionalItemTemplate> details) =>
                notifier.removeItemFromSection(details.data),
      )
    ]);
  }
}

class SectionsSection extends StatelessWidget {
  final List<AdditionalItemTemplate> items;
  final List<AdditionalItemSectionTemplate> sections;
  final UserAdditionalItems notifier;
  const SectionsSection(
      {super.key,
      required this.items,
      required this.sections,
      required this.notifier});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(12.0),
        child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int sectionIndex) {
              if (sectionIndex == sections.length) {
                return ElevatedButton(
                    onPressed: () {
                      notifier.addAdditionalItemSection();
                    },
                    child: Text("Add Section"));
              }
              return Section(
                items: items
                    .where((i) => i.sectionId == sections[sectionIndex].id)
                    .toList(),
                section: sections[sectionIndex],
                notifier: notifier,
              );
            },
            separatorBuilder: (BuildContext context, int outfitIndex) =>
                SizedBox(width: 30.0),
            itemCount: sections.length + 1),
      ),
    );
  }
}

class Section extends StatelessWidget {
  final List<AdditionalItemTemplate> items;
  final AdditionalItemSectionTemplate section;
  final UserAdditionalItems notifier;
  const Section(
      {super.key,
      required this.items,
      required this.section,
      required this.notifier});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Column(
        children: [
          SectionHeader(section: section, notifier: notifier),
          Expanded(
              child: SectionItemsList(
            items: items.sorted((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase())),
            section: section,
            notifier: notifier,
          )),
        ],
      ),
    );
  }
}

class SectionItemsList extends StatelessWidget {
  final List<AdditionalItemTemplate> items;
  final AdditionalItemSectionTemplate section;
  final UserAdditionalItems notifier;
  const SectionItemsList(
      {super.key,
      required this.items,
      required this.section,
      required this.notifier});

  @override
  Widget build(BuildContext context) {
    return DragTarget(builder: (
      BuildContext context,
      List<dynamic> accepted,
      List<dynamic> rejected,
    ) {
      return Container(
        width: 300,
        padding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
        color: Colors.black12,
        child: ListView.builder(
          // TODO: add a scrollController to the listView to scroll to the bottom when a new item is added to the list
          itemCount: items.length,
          itemBuilder: (context, index) => SectionItemRow(
            item: items[index],
          ),
        ),
      );
    }, onAcceptWithDetails:
        (DragTargetDetails<AdditionalItemTemplate> details) {
      notifier.addItemToSection(details.data, section);
    });
  }
}

class SectionItemRow extends ConsumerWidget {
  final AdditionalItemTemplate item;
  const SectionItemRow({super.key, required this.item});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final additionalItemRef = ref.read(userAdditionalItemsProvider.notifier);
    return Row(
      children: [
        DraggableSectionItem(item: item),
        Checkbox(
            value: item.defaultIncluded,
            onChanged: (bool? value) {
              additionalItemRef.updateAdditionalItemDefaultIncluded(
                  item, value ?? false);
            })
      ],
    );
  }
}

class DraggableSectionItem extends ConsumerStatefulWidget {
  final AdditionalItemTemplate item;
  const DraggableSectionItem({super.key, required this.item});

  @override
  ConsumerState createState() => _ItemChipState();
}

class _ItemChipState extends ConsumerState<DraggableSectionItem> {
  late TextEditingController _controller;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void setEditing(bool newValue) {
    setState(() {
      _isEditing = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    final additionalItemRef = ref.read(userAdditionalItemsProvider.notifier);
    final GlobalKey dragKey = GlobalKey();
    if (_isEditing) {
      _controller.text = widget.item.name;
      _controller.selection =
          TextSelection(baseOffset: 0, extentOffset: _controller.text.length);
      return IntrinsicWidth(child: TextField(
        autofocus: true,
        controller: _controller,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Item name',
        ),
        onSubmitted: (String? value) {
          if (value != null) {
            additionalItemRef.renameAdditionalItem(widget.item, value);
            setEditing(false);
          }
        },
        onTapOutside: (ev) {
          if (_controller.text != "") {
            additionalItemRef.renameAdditionalItem(widget.item, _controller.text);
            setEditing(false);
          }
        },
      ));
    }
    return GestureDetector(
      child: Draggable<AdditionalItemTemplate>(
        data: widget.item,
        dragAnchorStrategy: pointerDragAnchorStrategy,
        feedback: Transform.translate(
          offset: Offset(-20.0, -50.0),
          child: DraggingChip(dragKey: dragKey, label: widget.item.name),
        ),
        childWhenDragging: Chip(
          backgroundColor: Colors.black12,
          label: Text(widget.item.name),
          elevation: 16.0,
        ),
        child: Chip(
          label: Text(widget.item.name),
        ),
      ),
      onLongPress: () => setEditing(true),
      onDoubleTap: () => setEditing(true),
    );
  }
}

class AddChip extends StatelessWidget {
  final UserAdditionalItems notifier;
  const AddChip({super.key, required this.notifier});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => notifier.addUserAdditionalItem('new item'),
        child: Chip(
            label: Icon(
          Icons.add,
          size: 18.0,
        )));
  }
}
