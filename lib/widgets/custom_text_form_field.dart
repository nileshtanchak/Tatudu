import 'package:flutter/material.dart';

import '../utils/utils.dart';

class CustomTextFormField extends StatelessWidget {
  final String? label;
  final String? hintText;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final Function(String)? onFieldSubmitted;
  final bool singleLine;

  const CustomTextFormField({
    this.label,
    this.hintText,
    this.controller,
    this.onChanged,
    this.onFieldSubmitted,
    this.singleLine = true,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onFieldSubmitted: onFieldSubmitted,
      onChanged: onChanged,
      controller: controller,
      minLines: singleLine ? 1 : 5,
      maxLines: singleLine ? 1 : 8,
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: Utils.purpleBorder,
        enabledBorder: Utils.purpleBorder,
      ),
    );
  }
}
