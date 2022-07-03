import 'package:flutter/material.dart';
import 'package:movie/constants/colors.dart';

class AlreadyHaveAnAccountCheck extends StatelessWidget {
  final bool login;
  final void Function()? press;
  const AlreadyHaveAnAccountCheck({
    Key? key,
    this.login = true,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          login ? "Don't have an Account? " : "Already have an Account? ",
          style: TextStyle(color: kGridColor),
        ),
        GestureDetector(
            onTap: press,
            child: Text(login ? "회원가입" : "로그인",
                style: TextStyle(
                  color: kGridColor,
                  fontWeight: FontWeight.bold,
                )))
      ],
    );
  }
}
