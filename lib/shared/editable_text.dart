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
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _focusNode = FocusNode();
    
    // Listen for focus changes
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus && _controller.text != widget.textValue) {
        // Text field lost focus and text has changed
        widget.updateText(_controller.text);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _controller.text = widget.textValue;
    return TextField(
      controller: _controller,
      focusNode: _focusNode,
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
        // Still keep this for when tapping completely outside
        FocusScope.of(context).unfocus();
      },
    );
  }
}
