import 'package:flutter/material.dart';
import 'package:movie/component/text_field_container.dart';
import 'package:movie/constants/colors.dart';

class RoundedPasswordField extends StatelessWidget {
  final ValueChanged<String> onChanged;

  const RoundedPasswordField({
    Key? key,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        obscureText: true,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: "Password",
          icon: Icon(
            Icons.lock,
            color: kGridColor,
          ),
          suffixIcon: Icon(
            Icons.visibility_off,
            color: kGridColor,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
