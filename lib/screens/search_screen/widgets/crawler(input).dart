import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:html/parser.dart';
import 'package:movie/component/variable.dart';

class Crawler_input {
  String theaterName;
  Crawler_input(this.theaterName);

  String urlBody =
      'https://m.search.naver.com/p/csearch/content/qapirender.nhn?&_callback=window.__jindo2_callback._7777_0&where=nexearch&pkid=38&key=TheaterScheduleListApi&q=%EC%98%81%ED%99%94%EA%B4%80&u1=';
  late String url = urlBody + u1Code[theaterName].toString();

  List<String> va = [];
  late List<MvTime> Ldata = [];

  var nt = DateTime.now().toString().split(' ')[1].split(':')[0].toString() +
      ':' +
      DateTime.now().toString().split(' ')[1].split(':')[1].toString();

  Future<List<MvTime>> getData() async {
    try {
      final response = await http.get(Uri.parse(url), headers: {
        "Content-Type": "text/plain",
      });

      Future.delayed(Duration(seconds: 3));
      var a = response.body.replaceRange(0, response.body.indexOf('(') + 1, "");

      var b = a
          .replaceRange(a.lastIndexOf(');'), a.lastIndexOf(');') + 2, "")
          .replaceAll("\'", "\"");
      // debugPrint("b:" + b.toString());

      var decoded = ExternalData.fromJson(json.decode(b));
      MvTime tmp = MvTime();
      for (var i in decoded.items) {
        // debugPrint('!@#!@#!@#!@#!@#' + i.html.toString());
        var body = parse(i.html);
        var body2 = parse(i.date);
        // debugPrint(body.text.toString());

        // debugPrint(
        //     "crawler i.date = " + body2.documentElement!.text.toString());

        // var data = body.documentElement!.text.split('관람가');

        if (int.parse(todayDt.split('-')[2]) + 4 <
                int.parse(
                    body2.documentElement!.text.toString().split('-')[2]) ||
            int.parse(todayDt.split('-')[1]) <
                int.parse(
                    body2.documentElement!.text.toString().split('-')[1])) {
          continue;
        } else if (!totDt.contains(body2.documentElement!.text.toString()) &&
            totDt.length <= 4 &&
            dt_check == 0) {
          debugPrint('totDt input = ' + body2.documentElement!.text.toString());
          totDt.add(body2.documentElement!.text.toString());
        }
        debugPrint("1:" + body2.documentElement!.text.toString());

        for (var k in i.html.split('\n')) {
          var j = parse(k).documentElement!.text.toString();

          if (j.isEmpty) {
            continue;
          }
          //  else {
          //   debugPrint("j:" + j);
          // }

          if (j.contains('관람가') || j.contains('관람불가')) {
            Ldata.add(tmp);
            tmp = MvTime();
            tmp.selectedDate = body2.documentElement!.text.toString();
            tmp.theaterNm = theaterName;
          }

          if (j.contains('관람가')) {
            tmp.movieNm = j.split('관람가')[1];
          } else if (j.contains('관람불가')) {
            tmp.movieNm = j.split('관람불가')[1];
          } else {
            if (!j.contains('관')) {
              tmp.Url[j] =
                  k.substring(k.indexOf("href=\"http") + 5, k.indexOf("data-"));
            } else {
              tmp.Info.add(j);
              continue;
            }

            if (tmp.selectedDate == todayDt &&
                ((int.parse(j.split(':')[0]) >
                        int.parse(nowTm.toString().split(':')[0])) ||
                    (int.parse(j.split(':')[0]) ==
                            int.parse(nowTm.toString().split(':')[0]) &&
                        (int.parse(j.split(':')[1]) >=
                            int.parse(nowTm.toString().split(':')[1]))))) {
              tmp.Info.add(j);
            } else if (tmp.selectedDate != todayDt) {
              tmp.Info.add(j);
            }
          }

          for (var abc in tmp.Url.keys) {
            debugPrint(abc + ':' + tmp.Url[abc].toString());
          }
        }
      }
      // debugPrint('dt_check = ' + dt_check.toString());
      dt_check++;
      Ldata.add(tmp);

      return Ldata;
    } catch (err) {
      debugPrint(err.toString());
      throw Exception(err);
    }
  }
}

class MvTime {
  String selectedDate = '';
  String theaterNm = '';
  String movieNm = '';
  List<String> Info = [];
  var Url = {};
}

class ExternalData {
  final String key;
  final List<InnerData> items;

  ExternalData({required this.key, required this.items});

  factory ExternalData.fromJson(Map<String, dynamic> json) {
    List<InnerData> item = [];
    if (json['items'] != null) {
      json['items'].forEach((v) {
        item.add(InnerData.fromJson(v));
      });
    }

    return ExternalData(
      key: json['key'],
      items: item,
    );
  }
}

class InnerData {
  final String date;
  final String html;

  InnerData({required this.date, required this.html});

  factory InnerData.fromJson(Map<String, dynamic> json) {
    return InnerData(
      date: json['date'],
      html: json['html'],
    );
  }
}
