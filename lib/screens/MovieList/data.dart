import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:http/http.dart' as http;
import 'package:movie/component/movieRankingInfo.dart';

part 'data.g.dart';

@JsonSerializable()
class data {
  final String rank; //순위
  final String openDt; //개봉일자
  final String movieNm; //영화이름
  final String audiAcc; //누적관객수
  final String audiCnt; //일관객수

  data(this.rank, this.openDt, this.movieNm, this.audiAcc, this.audiCnt);

  factory data.fromJson(Map<String, dynamic> json) => _$dataFromJson(json);
  Map<String, dynamic> toJson() => _$dataToJson(this);
}

String getToday() {
  DateTime now = DateTime.now().subtract(Duration(days: 1));
  DateFormat dateFormat = DateFormat("yyyyMMdd");
  String today = dateFormat.format(now);

  return today;
}

Future<ReturnData> fetchData() async {
  String today = getToday();
  String key = 'key=' + 'cb6a1468b7f2a1f4e4f6f975042372f2'.toString();
  String targetDt = '&targetDt=$today';
  String url =
      'http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?' +
          key +
          targetDt +
          '&multiMovieYn=N';
  http.Response response = await http.get(Uri.parse(url));
  //List<data> returnData = [];
  ReturnData Rank = ReturnData();
  try {
    final jsonData = response.body;
    final json = jsonDecode(jsonData)["boxOfficeResult"]["dailyBoxOfficeList"];
    for (int i = 0; i < json.length; i++) {
      //print(data.fromJson(json[i]).movieNm);
      Rank.RankData.add(data.fromJson(json[i]));
    }
  } catch (err) {
    throw Exception('$err');
  }

  try {
    String gradeUrl =
        'https://search.daum.net/search?w=tot&DA=YZR&t__nil_searchbox=btn&sug=&sugo=&sq=&o=&q=%ED%98%84%EC%9E%AC%EC%83%81%EC%98%81%EC%98%81%ED%99%94';

    final nvr_response = await http.get(Uri.parse(gradeUrl));
    var nameL = [];
    var gradeL = [];

    for (var name in parse(nvr_response.body)
        .getElementsByClassName("fn_tit txt_ellip")) {
      debugPrint(name.text.toString());
      nameL.add(name.text.toString());
    }

    for (var grade_val
        in parse(nvr_response.body).getElementsByClassName("rate")) {
      debugPrint(grade_val.text.toString());
      debugPrint('-----');
      gradeL.add(grade_val.text.toString());
    }
    debugPrint(nameL.length.toString() + ' ' + gradeL.length.toString());
    debugPrint('!@!@!@!@!@!@');
    for (var i = 0; i < nameL.length; i++) {
      var tName = nameL[i].toString().replaceAll(' ', '');
      debugPrint('tName:' + tName);
      Rank.grade[nameL[i].toString()] = gradeL[i].toString();
      debugPrint(nameL[i].toString() + ':' + Rank.grade[nameL[i].toString()]);
    }
  } catch (err) {
    throw Exception('$err');
  }
  return Rank;
}

class ReturnData {
  List<data> RankData = [];
  var grade = {};
}
