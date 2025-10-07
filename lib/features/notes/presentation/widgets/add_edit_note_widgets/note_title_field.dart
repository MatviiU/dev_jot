import 'package:flutter/material.dart';

class NoteTitleField extends StatelessWidget {
  const NoteTitleField({required this.controller, super.key});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: const InputDecoration(
        hintText: 'Title',
        border: InputBorder.none,
      ),
      style: Theme.of(context).textTheme.headlineMedium,
      maxLines: 1,
    );
  }
}
