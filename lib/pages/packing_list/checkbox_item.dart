import 'package:flutter/material.dart';

class CheckboxItem extends StatefulWidget {
  final String text;
  const CheckboxItem({super.key, required this.text});

  @override
  State createState() => _CheckboxItemState();
}

class _CheckboxItemState extends State<CheckboxItem> {
  bool _isChecked = false;

  void toggle(bool? isChecked) {
    setState(() {
      _isChecked = isChecked ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Checkbox(value: _isChecked, onChanged: toggle),
        GestureDetector(
          child: Text(widget.text),
          onTap: () => toggle(!_isChecked),
        ),
      ],
    );
  }
}
