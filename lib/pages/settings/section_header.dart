import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tote_f/models/user/additional_item_section_template.dart';
import 'package:tote_f/providers/user_additional_items_provider.dart';

class SectionHeader extends ConsumerStatefulWidget {
  final AdditionalItemSectionTemplate section;
  final UserAdditionalItems notifier;

  const SectionHeader(
      {super.key, required this.section, required this.notifier});

  @override
  ConsumerState createState() => _SectionHeaderState();
}

class _SectionHeaderState extends ConsumerState<SectionHeader> {
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
    void openMenu(AdditionalItemSectionTemplate section) {
      showModalBottomSheet(
        context: context,
        builder: (context) =>
            SectionActions(section: section, notifier: widget.notifier),
      );
    }

    if (_isEditing) {
      _controller.text = widget.section.name;
      _controller.selection =
          TextSelection(baseOffset: 0, extentOffset: _controller.text.length);
      return TextField(
        autofocus: true,
        controller: _controller,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Section name',
        ),
        onSubmitted: (String? value) {
          if (value != null) {
            widget.notifier.renameAdditionalItemSection(widget.section, value);
            setEditing(false);
          }
        },
        onTapOutside: (ev) {
          if (_controller.text != "") {
            widget.notifier
                .renameAdditionalItemSection(widget.section, _controller.text);
            setEditing(false);
          }
        },
      );
    }
    return Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black12, width: 2.0)),
        child: Row(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: GestureDetector(
                onTap: () => openMenu(widget.section),
                child: const Icon(
                  Icons.menu,
                  size: 16,
                ),
              ),
            ),
            Spacer(),
            Align(
              alignment: Alignment.center,
              child: GestureDetector(
                child: Center(
                  child: Text(widget.section.name),
                ),
                onLongPress: () => setEditing(true),
                onDoubleTap: () => setEditing(true),
              ),
            ),
            Spacer(),
          ],
        ));
  }
}

class SectionActions extends ConsumerWidget {
  final AdditionalItemSectionTemplate section;
  final UserAdditionalItems notifier;
  const SectionActions({
    super.key,
    required this.section,
    required this.notifier,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void deleteSection() {
      showModalBottomSheet(
          context: context,
          builder: (context) =>
              DeleteSectionModal(section: section, notifier: notifier));
    }

    return Column(
      children: [
        Text(section.name),
        ListTile(
            leading: const Icon(Icons.delete),
            title: const Text('Delete Section'),
            onTap: () {
              Navigator.pop(context);
              deleteSection();
            }),
      ],
    );
  }
}

class DeleteSectionModal extends ConsumerWidget {
  final AdditionalItemSectionTemplate section;
  final UserAdditionalItems notifier;
  const DeleteSectionModal(
      {super.key, required this.section, required this.notifier});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Align(alignment: Alignment.topCenter, child: Text(section.name)),
        Spacer(),
        ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              notifier.deleteAdditionalItemSection(section, true);
            },
            child: Text("Delete section and all items")),
        Spacer(),
        ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              notifier.deleteAdditionalItemSection(section, false);
            },
            child: Text("Unassign items and delete section")),
        Spacer(),
      ],
    );
  }
}
