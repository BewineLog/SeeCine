import 'package:flutter/material.dart';
import 'package:movie/screens/MovieList/movieList.dart';

class Upper_TeamName extends StatelessWidget {
  const Upper_TeamName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);
    final width = data.size.width;
    final height = data.size.height;
    return Container(
        margin: EdgeInsets.only(top: height * 0.06),
        alignment: Alignment.center,
        child: Row(children: [
          Padding(
            padding: EdgeInsets.only(left: 0),
            child: Text(
              'TeamName!', // 어떻게 처리하지?
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
              padding: EdgeInsets.only(left: width * 0.5),
              child: TextButton(
                child: Text('Ranking'),
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (builder) => movieList()));
                },
              ))
        ]));
  }
}
