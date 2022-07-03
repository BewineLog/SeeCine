import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie/component/movieRankingInfo.dart';
import 'package:movie/constants/colors.dart';

import 'data.dart';

class movieList extends StatefulWidget {
  const movieList({Key? key}) : super(key: key);

  @override
  State<movieList> createState() => _movieListState();
}

class _movieListState extends State<movieList> {
  //movieList({Key? key}) : super(key: key);
  //late Future<List<Data>> rankingData;
  @override
  void initState() {
    super.initState();
    // rankingData = DBHelper_ri().data(); // DB로만 Ranking Data 호출
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('MovieRanking')),
        backgroundColor: kBackgroundColor,
        body: Padding(
            padding: const EdgeInsets.all(5),
            child: FutureBuilder<ReturnData>(
              future: fetchData(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.RankData.length,
                    itemBuilder: (context, int index) => Card(
                      child: ListTile(
                          title: Text(
                        snapshot.data!.RankData[index].rank +
                            "/" +
                            snapshot.data!.RankData[index].movieNm +
                            "/" +
                            snapshot.data!.RankData[index].openDt +
                            "/" +
                            snapshot.data!.RankData[index].audiCnt +
                            "/" +
                            ((snapshot.data!.grade[snapshot.data!.RankData[index].movieNm.toString()] !=
                                    null)
                                ? snapshot.data!.grade[snapshot
                                    .data!.RankData[index].movieNm
                                    .toString()]
                                : (snapshot.data!.grade[snapshot
                                            .data!.RankData[index].movieNm
                                            .toString()
                                            .replaceAll(' ', '')] !=
                                        null)
                                    ? snapshot.data!.grade[snapshot
                                        .data!.RankData[index].movieNm
                                        .toString()
                                        .replaceAll(' ', '')]
                                    : ''),
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      )),
                    ),
                  );
                } else {
                  return Center(
                    child: Platform.isAndroid
                        ? CircularProgressIndicator()
                        : CupertinoActivityIndicator(),
                  );
                }
              },
            )));
  }
}
