import 'package:flutter/material.dart';
import 'package:movie/screens/loginService/login_success_page/login_success_page.dart';

import 'package:movie/screens/loginService/widgets/profile_bar.dart';

class MyPage extends StatelessWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: EdgeInsets.only(
        top: 60,
        bottom: 15,
        left: 25,
        right: 25,
      ),
      child: profileBar(
        page: loginSuccessScreen(), //LoginScreen(),
        txt: "로그인이 필요한 서비스 입니다.",
      ),
    ));
  }
}
