import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie/DB/userBookmark.dart';
import 'package:movie/component/variable.dart';
import 'package:movie/screens/Page1/widgets/home_service.dart';
import 'package:movie/screens/Page3/ShowList.dart';

class MultiSwitch extends StatefulWidget {
  const MultiSwitch({
    Key? key,
    // required this.id,
  }) : super(key: key);
  // final int id;
  @override
  _MultiSwitchState createState() => _MultiSwitchState();
}

class _MultiSwitchState extends State<MultiSwitch> {
  bool val = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: customSwitch(val, context),
    );
  }
}

Widget customSwitch(bool val, BuildContext context) {
  var size = MediaQuery.of(context).size;
  var height = size.height;
  var width = size.width;

  Future<List<Bookmark>> variable = provider.getAllData();

  return Padding(
      padding: const EdgeInsets.only(top: 10, left: 16, right: 16),
      child: FutureBuilder<List<Bookmark>>(
          future: variable,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, int index) => Card(
                    child: ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          icon: Icon(
                            Icons.cancel_outlined,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            provider.deleteData(snapshot.data![index].id);
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => HomePageUi()));
                          }),
                      Text(snapshot.data![index].company.toString() +
                          snapshot.data![index].theater.toString()),
                      IconButton(
                          icon: Icon(
                            Icons.arrow_right_sharp,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            debugPrint('MvLst passing data:' +
                                snapshot.data![index].company.toString() +
                                snapshot.data![index].theater.toString());
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (builder) => ShowPage(
                                    // MvLstT: [
                                    //     snapshot.data![index].company.toString() +
                                    //         snapshot.data![index].theater
                                    //             .toString()
                                    //   ]
                                    ))); //Listtile로 바꾸면 어떤가?
                          }),
                    ],
                  ),
                )),
              );
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            } else {
              return Platform.isAndroid
                  ? CircularProgressIndicator()
                  : CupertinoActivityIndicator();
            }
          }));
}
