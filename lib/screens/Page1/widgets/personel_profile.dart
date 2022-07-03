import 'package:flutter/material.dart';
import 'package:movie/screens/loginService/login_success_page/widgets/book_mark.dart';

class book_mark extends StatelessWidget {
  //const book_mark({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);
    final width = data.size.width;
    final height = data.size.height;
    return Column(
      children: [
        RawMaterialButton(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.star_border_outlined,
                color: Color(0xFFFDBF30),
                size: height * 0.03,
              ),
              Container(
                alignment: Alignment.center,
                //decoration
                child: Text(
                  '즐겨찾기',
                  style: TextStyle(
                    fontSize: height * 0.02,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          ),
          onPressed: () => {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => BookMark()))
          },
        ),
      ],
    );
  }
}
