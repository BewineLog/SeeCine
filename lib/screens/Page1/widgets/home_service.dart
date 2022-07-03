import 'package:flutter/material.dart';
import 'package:movie/component/MultiSwitch.dart';
import 'package:movie/component/variable.dart';
import 'package:movie/screens/Page1/widgets/appname_logo.dart';
import 'package:movie/screens/Page1/widgets/grey_grid.dart';
import 'package:movie/screens/Page1/widgets/personel_profile.dart';
import 'package:movie/screens/Page1/widgets/upper_teamname.dart';
import 'package:movie/screens/Page2/map.dart';
// import 'dart:developer' as dvr;

import '../../../DB/recommendBm.dart';

class HomePageUi extends StatefulWidget {
  const HomePageUi({Key? key}) : super(key: key);

  @override
  _HomePageUiState createState() => _HomePageUiState();
}

class _HomePageUiState extends State<HomePageUi> {
  @override
  Widget build(BuildContext context) {
    final mqsize = MediaQuery.of(context);
    final width = mqsize.size.width;
    final height = mqsize.size.height;

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Upper_TeamName(), // 최상단 TeamName Bar
          grey_grid(),
          logo_name(), //App_Name + center logo
          SizedBox(height: height * 0.1),
          grey_grid(),
          book_mark(), //파일 명 변경 예정, 개인 프로필 버튼
          grey_grid(),
          Container(
            height: 0,
            child: ListView.builder(
                itemCount: recommend_future.length,
                itemBuilder: (context, index) {
                  recommend_data[recommend_future[index].name] =
                      int.parse(recommend_future[index].mvcount);
                  return Container();
                }),
          ),

          //* root
          // option_view(
          //   selectedValue: '영화가 우선',
          //   OptionList: ['영화가 우선', '장소가 우선', '시간이 우선'],
          // ), // 변경해야할 부분

//*1차 시도: 오류 - RenderBox was not laid out.
          // CustomSwitch(
          //   selectedValue: '장소가 중요해!',
          //   optionlist: ['장소가 중요해!', '시간이 중요해!'],
          // ),
//*2차 시도:
          Stack(
            children: [
              Container(
                height: height * 0.5,
                child: MultiSwitch(),
              ),
            ],
          ), // userBookmark DB 호출하여 스위치 생성
          SizedBox(height: height * 0.02),

          Center(
              child: FloatingActionButton(
                  heroTag: null,
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (builder) => CinemaMap()));
                  }))
        ],
      ),
    );
  }
}
