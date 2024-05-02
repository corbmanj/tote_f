import 'package:flutter/material.dart';

class EditText extends StatefulWidget {
  final String textValue;
  final String textLabel;
  final dynamic updateText;
  const EditText(
      {super.key, required this.textValue, required this.textLabel, required this.updateText});

  @override
  State createState() => _EditTextState();
}

class _EditTextState extends State<EditText> {
  late TextEditingController _controller;

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

  @override
  Widget build(BuildContext context) {
    _controller.text = widget.textValue;
    return TextField(
      controller: _controller,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: widget.textLabel,
      ),
      onSubmitted: (String? value) {
        if (value != null) {
          widget.updateText(value);
        }
      },
      onTapOutside: (PointerDownEvent? value) {
        if (value != null && _controller.text != widget.textValue) {
          widget.updateText(_controller.text);
        }
        FocusScope.of(context).unfocus();
      },
    );
  }
}
