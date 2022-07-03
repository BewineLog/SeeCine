import 'package:flutter/material.dart';
import 'package:movie/component/text_field_container.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final Icon icon;
  final ValueChanged<String> onChanged;

  const RoundedInputField({
    Key? key,
    required this.hintText,
    required this.icon,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        enabled: true,
        onChanged: onChanged,
        cursorColor: Colors.black.withOpacity(0.8),
        decoration: InputDecoration(icon: icon, hintText: hintText),
      ),
    );
  }
}
