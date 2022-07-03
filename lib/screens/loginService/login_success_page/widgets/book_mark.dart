import 'dart:io';

import 'package:flutter/material.dart';
import 'package:movie/DB/userBookmark.dart';
import 'package:movie/component/rounded_input_field.dart';
import 'package:movie/component/variable.dart';
import 'package:movie/screens/Page1/widgets/home_service.dart';

//
// This is tmp Code.
//

class BookMark extends StatefulWidget {
  const BookMark({Key? key}) : super(key: key);

  @override
  _BookMarkState createState() => _BookMarkState();
}

class _BookMarkState extends State<BookMark> {
  int theater_idx = -1;
  int region_idx = -1;
  int thearegion_idx = -1;
//  int _colorSelected = 0;
  late int _length;
  String CompanyName = '';
  String RegionName = '';
  String ComReTheater = '';
  List<Color> colorTh =
      List.generate(3, (index) => Colors.black); // CGV , 롯데시네마, 메가박스  ->> 3개
  List<Color> colorRe = List.generate(7, (index) => Colors.black); // 지역 7개
  late List<Color> colorThR;

  List<dynamic> _tmp = [];

  @override
  void initState() {
    _tmp = recommend_data.keys.toList();
    debugPrint('_tmp length:' + '${_tmp.length}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('BookMark')),
        // ignore: unnecessary_new
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            (_tmp.length != 0)
                ? Container(
                    height: 100,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _tmp.length,
                        itemBuilder: (context, index) {
                          return TextButton(
                            child: Text(_tmp[index].toString()),
                            onPressed: () {
                              var _company;
                              var _theater;
                              if (_tmp[index].toString().contains('CGV')) {
                                _company = 'CGV';
                              } else if (_tmp[index]
                                  .toString()
                                  .contains('롯데시네마')) {
                                _company = '롯데시네마';
                              } else {
                                _company = '메가박스';
                              } // ex) 롯데시네마도곡 -> 영화브랜드 구분

                              _theater = _tmp[index].toString().substring(
                                  _company
                                      .toString()
                                      .length); // ex) 롯데시네마도곡 -> 지역 추출

                              provider.insertData(Bookmark(
                                  varNum,
                                  _company,
                                  'recommend',
                                  _theater)); // Bookmark DB에 데이터 삽입 -> 영화브랜드 & 지역

                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (builder) => HomePageUi()));
                            },
                          );
                        }))
                : Container(height: 0),

            //기존 코드
            Container(
              height: 100,
              child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: theater_company
                      .length, //theater_company = ['CGV', '롯데시네마', '메가박스'];
                  itemBuilder: (context, index) {
                    return TextButton(
                      child: Text(theater_company[index]),
                      onPressed: () {
                        setState(() {
                          if (colorTh.contains(Colors.amberAccent)) {
                            colorTh[colorTh.indexOf(Colors.amberAccent)] =
                                Colors.black;
                            colorTh[index] = Colors.amberAccent;
                          } else {
                            colorTh[index] = Colors.amberAccent;
                          }
                          theater_idx = index;
                        });
                      },
                      onLongPress: null,
                      style: TextButton.styleFrom(
                        primary: colorTh[index],
                        padding: const EdgeInsets.all(8),
                      ),
                    );
                  }),
            ),
            Container(
              height: 100,
              child: (theater_idx != -1)
                  ? ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: colorRe.length,
                      itemBuilder: (context, index) {
                        return TextButton(
                          child: Text(region[index]),
                          onPressed: () {
                            setState(() {
                              if (colorRe.contains(Colors.amberAccent)) {
                                colorRe[colorRe.indexOf(Colors.amberAccent)] =
                                    Colors.black;
                                colorRe[index] = Colors.amberAccent;
                              } else {
                                colorRe[index] = Colors.amberAccent;
                              }
                              region_idx = index;
                              CompanyName = theater_company[theater_idx];
                              RegionName = region[region_idx];
                              _length = theater[CompanyName]![RegionName]!
                                  .length; // theater -> 해당 지역의 선택된 회사에 속한 영화관 갯수 get.
                              colorThR = List.generate(_length,
                                  (index) => Colors.black); // 최종 영화관 목록 컬러리스트
                            });
                          },
                          onLongPress: null,
                          style: TextButton.styleFrom(
                            primary: colorRe[index],
                            padding: const EdgeInsets.all(8),
                          ),
                        );
                      })
                  : Container(),
            ),
            Container(
              height: 100,
              child: (theater_idx != -1 && region_idx != -1)
                  ? ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: _length,
                      itemBuilder: (context, index) {
                        return TextButton(
                          child:
                              Text(theater[CompanyName]![RegionName]![index]),
                          onPressed: () {
                            setState(
                              () {
                                if (colorThR.contains(Colors.amberAccent)) {
                                  colorThR[colorThR.indexOf(
                                      Colors.amberAccent)] = Colors.black;
                                  colorThR[index] = Colors.amberAccent;
                                } else {
                                  colorThR[index] = Colors.amberAccent;
                                }
                                thearegion_idx = index;
                                ComReTheater = theater[CompanyName]![
                                    RegionName]![thearegion_idx];
                              },
                            );
                          },
                          onLongPress: null,
                          style: TextButton.styleFrom(
                            primary: colorThR[index],
                            padding: const EdgeInsets.all(8),
                          ),
                        );
                      })
                  : Container(),
            ),
            SizedBox(height: 100),
            FloatingActionButton(
                heroTag: null,
                onPressed: () {
                  if (CompanyName != '' &&
                      RegionName != '' &&
                      ComReTheater != '') {
                    debugPrint('bookmark insert');
                    debugPrint(
                        CompanyName + '/' + RegionName + '/' + ComReTheater);
                    provider.insertData(Bookmark(
                      varNum,
                      CompanyName,
                      RegionName,
                      ComReTheater,
                    ));
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (builder) => HomePageUi()));
                  } else {
                    AlertDialog(
                      title: Text('Error'),
                    );
                  }
                }),
          ]),
        )));
  }
}
