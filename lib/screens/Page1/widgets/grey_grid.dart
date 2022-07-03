import 'package:flutter/material.dart';
import 'package:movie/constants/colors.dart';

class grey_grid extends StatelessWidget {
  //const grey_grid({Key? key, required this.edgeinsets}) : super(key: key);
  //final double edgeinsets;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        //margin: EdgeInsets.only(top: edgeinsets),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: kGridColor, width: 1.0),
          ),
        ),
      ),
    );
  }
}
