import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tote_f/models/user/outfit_template.dart';
import 'package:tote_f/providers/user_outfits_provider.dart';

class OutfitHeader extends ConsumerStatefulWidget {
  final OutfitTemplate outfit;

  const OutfitHeader({super.key, required this.outfit});

  @override
  ConsumerState createState() => _OutfitHeaderState();
}

class _OutfitHeaderState extends ConsumerState<OutfitHeader> {
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
    final outfitNotifier = ref.read(userOutfitsProvider.notifier);
    if (_isEditing) {
      _controller.text = widget.outfit.type;
      _controller.selection =
          TextSelection(baseOffset: 0, extentOffset: _controller.text.length);
      return TextField(
        autofocus: true,
        controller: _controller,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Outfit name',
        ),
        onSubmitted: (String? value) {
          if (value != null) {
            outfitNotifier.updateOutfitName(widget.outfit, value);
            setEditing(false);
          }
        },
        onTapOutside: (ev) {
          if (_controller.text != "") {
            outfitNotifier.updateOutfitName(widget.outfit, _controller.text);
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
          child: Text(widget.outfit.type),
        ),
      ),
      onLongPress: () => setEditing(true),
      onDoubleTap: () => setEditing(true),
    );
  }
}
