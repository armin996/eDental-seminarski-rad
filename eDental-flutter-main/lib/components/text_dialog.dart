import 'package:flutter/material.dart';

class TextDialog extends StatefulWidget {
  final String title;

  TextDialog({required this.title});

  @override
  _TextDialogState createState() => _TextDialogState();
}

class _TextDialogState extends State<TextDialog> {
  late TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: TextField(
        controller: _textController,
        decoration: const InputDecoration(
          hintText: 'Enter some text',
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, _textController.text),
          child: const Text('OK'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}
