import 'package:flutter/material.dart';
import 'package:movie/screens/Page1/widgets/grey_grid.dart';

class option_view extends StatefulWidget {
  option_view({Key? key, required this.OptionList, required this.selectedValue})
      : super(key: key);

  final List OptionList;
  String selectedValue;

  @override
  _option_viewState createState() => _option_viewState();
}

class _option_viewState extends State<option_view> {
  //final _OptionList = ['영화가 우선', '장소가 우선', '시간이 우선'];

  @override
  Widget build(BuildContext context) {
    return Stack(
      //Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: DropdownButton(
                  value: widget.selectedValue,
                  items: widget.OptionList.map(
                    (value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Text(value),
                      );
                    },
                  ).toList(),
                  onChanged: (value) => {
                    setState(() {
                      widget.selectedValue = value.toString();
                    })
                  },
                ),
              ),
            ),
            //SizedBox(height: 15),
            grey_grid(),
          ],
        )
      ],
      // ), //Option!
    );
  }
}
