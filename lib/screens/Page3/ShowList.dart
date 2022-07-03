import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie/DB/alarm.dart';
import 'package:movie/DB/recommendBm.dart';
import 'package:movie/component/notifications.dart';
import 'package:movie/component/variable.dart';
import 'package:movie/screens/search_screen/widgets/crawler(input).dart';

import 'dart:developer' as dvr;

class ShowPage extends StatefulWidget {
  ShowPage({
    Key? key,
  }) : super(key: key);

  // List<String> MvLstT;
  @override
  State<ShowPage> createState() => _ShowPageState();
}

class _ShowPageState extends State<ShowPage> {
  // String theater1 = '메가박스 강남',
  //     theater2 = 'CGV 강남',
  //     theater3 = '롯데시네마 도곡'; //Mv Name
  var prov;
  List<MvTime> flst = [];
  List<String> MvName = [];
  List<String> totDat = [];
  List<String> selecDat = [];

  String _selectedName = '';
  int _clear = 0;
  int _selectedOne = 0;
  int _selectedTwo = 0;
  int _length = 0;

  //tmp
  List<String> MvLstT = ['메가박스강남', 'CGV평촌', '롯데시네마도곡'];
  List<String> MvLst = [];
  var distance = {};

  Timer? timer;
  var alarm_on = false;

  void _insertData() async {
    for (var j in recommend_data.keys) {
      await recomm_provider.insertData(
          Recommend(recID, j.toString(), recommend_data[j].toString()));
    }
  }

  @override
  void initState() {
    //tmpCode

    for (var i in MvLstT) {
      if (!i.contains('!')) {
        MvLst.add(i);
        distance[i] = '';
      } else {
        var passingData = i.split('!');
        passingData[0] = passingData[0].replaceAll(' ', '');
        if (passingData[0].contains('(')) {
          passingData[0] =
              passingData[0].substring(0, passingData[0].indexOf('('));
          debugPrint('!@@!!!' + passingData[0].toString());
        }

        if (!MvLst.contains(passingData[0])) {
          MvLst.add(passingData[0]);
        }
        distance[passingData[0].toString()] =
            passingData[1].toString() + 'Km'; // 현재 위치 ~ 영화관까지 거리 저장.
      }
    }

    NotificationService.init();
    // listenNotification();
    debugPrint('mvlstt:' + MvLstT.toString());
    _length = MvLst.length;
    debugPrint(MvLst.toString());
    debugPrint('_length:' + _length.toString());

    for (int i = 0; i < _length; i++) {
      String str = MvLst[i];
      if (recommend_data.containsKey(str)) {
        recommend_data[str] += 1;
      } else {
        recommend_data[str] = 1;
      }
    } // 호출 횟수 count -> 향후 즐겨찾기에서 추천할 영화관 선정하기 위함.

    _insertData(); //호출 횟수 반영 후 DB에 데이터 삽입.

    for (int i = 0; i < _length; i++) {
      prov = Crawler_input(MvLst[i]); //영화관 명을 통해 상영데이터 crawling
      prov.getData().then((value) {
        setState(() {
          _clear++;
          debugPrint('clear :' + _clear.toString());
        });
        for (final val in value) {
          if (val.movieNm.toString() != '') {
            flst.add(val); // 기존 코드
          }
        }
        if (_clear == _length) {
          for (var v in flst) {
            if (v.selectedDate.toString() == selectDt.toString() &&
                !MvName.contains(v.movieNm)) {
              debugPrint('MvName:' + v.movieNm.toString());
              MvName.add(v.movieNm);
            }
          }
          debugPrint('before');
          totDat = _getData(MvName[0].toString());
          _selectedName = MvName[0].toString();
          debugPrint('After');
        }
      });
    }
  }

  List<String> _getData(String name) {
    List<String> t = [];
    for (final i in flst) {
      if (i.movieNm.toString().contains(name) && i.selectedDate == selectDt) {
        var screen = '';

        for (final j in i.Info) {
          if (j.contains('관') || j.contains('관 ') || j.contains('샤')) {
            screen = j;
          } else {
            t.add(i.theaterNm.toString() +
                ' ' +
                screen.toString() +
                ' ' +
                j.toString() +
                ' ' +
                distance[i.theaterNm]); // + i.Url[j].toString();

            // debugPrint('show list t add string : ' +
            //     i.selectedDate.toString() +
            //     ' ' +
            //     i.movieNm.toString() +
            //     ' ' +
            //     i.theaterNm.toString() +
            //     ' ' +
            //     screen.toString() +
            //     ' ' +
            //     j.toString() +
            //     '!');
          }
        }
      }
    }
    debugPrint('error point?');
    if (notificationVal[name] == null ||
        notificationVal[name]!.isEmpty ||
        notificationVal[name]![selectDt] == null) {
      notificationVal[name] = {selectDt: List.generate(100, (index) => 0)};
    }
    if (notificationId[name] == null ||
        notificationId[name]!.isEmpty ||
        notificationId[name]![selectDt] == null) {
      notificationId[name] = {selectDt: List.generate(100, (index) => 0)};
    }
    // _notificationVal[name] = List.generate(t.length, (index) => 0);
    // _notificationId[name] = List.generate(t.length, (index) => 0);

    debugPrint('123:' + notificationId[MvName[0]].toString());

    if (t.length > 1) {
      t.sort((a, b) =>
          (a.trim().split(' ')[2].compareTo(b.trim().split(' ')[2]) != 0)
              ? (a.trim().split(' ')[2].compareTo(b.trim().split(' ')[2]))
              : (a.trim().split(' ').last.compareTo(b.trim().split(' ').last)));
    } // 시간 기준 sorting 코드

    debugPrint('return t');
    return t;
  }

  @override
  Widget build(BuildContext context) {
    final mqsize = MediaQuery.of(context);
    final width = mqsize.size.width;
    final height = mqsize.size.height;
    return Scaffold(
        appBar: AppBar(title: Text('Show Page')),
        body: (_clear == _length)
            ? Column(children: [
                Container(
                    height: height * 0.05,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: MvName.length,
                        itemBuilder: (context, index) {
                          return TextButton(
                              child: Text(MvName[index]),
                              onPressed: () {
                                setState(() {
                                  _selectedOne = index;
                                  _selectedTwo = 0; //_cnt;
                                  selectDt = todayDt;
                                  totDat =
                                      _getData(MvName[_selectedOne].toString());

                                  if (_selectedOne != 0) {
                                    notificationId[MvName[_selectedOne]] = {
                                      selectDt: List.generate(
                                          totDat.length, (index) => 0)
                                    };
                                  }
                                  _selectedName = MvName[_selectedOne];
                                });
                              });
                        })),
                (_selectedOne > -1)
                    ? Container(
                        height: height * 0.05,
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: totDt.length,
                            itemBuilder: (context, index2) {
                              return TextButton(
                                child: (todayDt == totDt[index2])
                                    ? Text(totDt[index2].split('-')[2] + '(오늘)')
                                    : Text(totDt[index2].split('-')[2]),
                                onPressed: () {
                                  setState(() {
                                    debugPrint('index:' + index2.toString());
                                    debugPrint('totDt length:' +
                                        totDt.length.toString());
                                    _selectedTwo = index2;
                                    debugPrint('set select dt');
                                    selectDt = totDt[index2];
                                    debugPrint(
                                        'selectDt:' + selectDt.toString());
                                    totDat = _getData(
                                        MvName[_selectedOne].toString());
                                    debugPrint('after totDat');
                                  });
                                },
                              );
                            }))
                    : Container(),
                (_selectedTwo > -1 &&
                        notificationVal[MvName[_selectedOne]] != null)
                    // &&
                    // _notificationVal[MvName[_selectedOne]][selectDt] !=
                    //     null)
                    ? Container(
                        height: height * 0.5,
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: totDat.length,
                            itemBuilder: (context, index3) {
                              int time = int.parse(totDat[index3]
                                      .split(' ')[2]
                                      .split(':')[0]) +
                                  int.parse(totDat[index3]
                                      .split(' ')[2]
                                      .split(':')[1]);
                              // var t = totDat[index3].split('\n');

                              return Container(
                                width: width * 0.01,
                                height: height * 0.05,
                                child: TextButton.icon(
                                  // onPressed: () {},
                                  onPressed: () {
                                    setState(() {
                                      notificationVal[_selectedName]![
                                          selectDt]![time]++;

                                      alarm_provider.insertData(Alarm(
                                          notificationId[_selectedName]![
                                              selectDt]![time],
                                          _selectedName,
                                          selectDt,
                                          time.toString(),
                                          notificationVal[_selectedName]![
                                                  selectDt]![time]
                                              .toString()));

                                      if (notificationVal[_selectedName]![
                                                  selectDt]![time] %
                                              2 ==
                                          0) {
                                        NotificationService.cancelNotification(
                                            notificationId[_selectedName]![
                                                selectDt]![time]);
                                      } else {
                                        notificationId[_selectedName]![
                                                selectDt]![time] =
                                            DateTime.now().millisecond +
                                                index3 +
                                                totDat[index3].length;
                                        NotificationService
                                            .showScheduledNotification(
                                                id: notificationId[
                                                        _selectedName]![
                                                    selectDt]![time],
                                                title: 'Title',
                                                body: '${totDat[index3]}',
                                                payload: 'payload',
                                                scheduleDate: DateTime.now()
                                                    .add(Duration(seconds: 3)));
                                      }
                                    });
                                  },

                                  icon: (notificationVal[_selectedName]![
                                                  selectDt]![time] %
                                              2 ==
                                          0)
                                      ? Icon(Icons.notifications_none)
                                      : Icon(Icons.notifications_active),
                                  label: Text(totDat[
                                      index3]), // t[0] + ~ + t[3]  // t[4]는 url이니까 dynamic link에 주소로 ㄱㄱ
                                  style: TextButton.styleFrom(
                                      alignment: Alignment.centerLeft),
                                ),
                              );
                            }))
                    : Container(),
              ])
            : Center(
                child: Platform.isAndroid
                    ? CircularProgressIndicator()
                    : CupertinoActivityIndicator(),
              ));
  }
}
