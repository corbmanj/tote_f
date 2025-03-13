import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tote_f/models/user/additional_item_section_template.dart';
import 'package:tote_f/providers/user_additional_items_provider.dart';

class SectionHeader extends ConsumerStatefulWidget {
  final AdditionalItemSectionTemplate section;
  final UserAdditionalItems notifier;

  const SectionHeader({super.key, required this.section, required this.notifier});

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
            widget.notifier.renameAdditionalItemSection(widget.section, _controller.text);
            setEditing(false);
          }
        },
      );
    }
    return GestureDetector(
      child: Container(
        decoration:
            BoxDecoration(border: Border.all(color: Colors.black12, width: 2.0)),
        child: Center(
          child: Text(widget.section.name),
        ),
      ),
      onLongPress: () => setEditing(true),
      onDoubleTap: () => setEditing(true),
    );
  }
}
