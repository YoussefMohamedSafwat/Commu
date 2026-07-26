import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final bool multiLines;
  final String name;
  const TextFormFieldWidget({
    super.key,
    required this.controller,
    required this.multiLines,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: TextFormField(
        minLines: multiLines ? 6 : 2,
        maxLines: multiLines ? 6 : 2,
        controller: controller,
        decoration: InputDecoration(hintText: name),
        validator: (val) => val!.isEmpty ? "$name Can't be empty" : null,
      ),
    );
  }
}
