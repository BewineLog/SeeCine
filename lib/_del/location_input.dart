import 'package:flutter/material.dart';
import 'package:movie/component/variable.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({Key? key}) : super(key: key);

  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  TextEditingController controller = TextEditingController();
  FocusNode focusNode = FocusNode();

  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
            padding: const EdgeInsets.all(6.0),
            child: GestureDetector(
                onTap: () => {FocusScope.of(context).unfocus()},
                /*해당 칸에 입력 후, 다른 곳을 터치하면 키보드 사라짐*/
                child: TextField(
                  cursorColor: Colors.black.withOpacity(0.8),
                  //keyboardType: TextInputType.streetAddress,
                  decoration: InputDecoration(
                    labelText: "현재 위치 입력",
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon:
                        const Icon(Icons.map_outlined, color: Colors.grey),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.all(Radius.circular(6))),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.all(Radius.circular(6))),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.all(Radius.circular(6))),
                  ),
                  onChanged: (text) => {
                    location =
                        text, //user input location value 가 variable 폴더 안에 있는 location 변수에 저장됨.
                  },
                ))));
  }
}
