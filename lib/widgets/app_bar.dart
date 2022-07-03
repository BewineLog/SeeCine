import 'package:flutter/material.dart';
import 'package:movie/screens/Page1/widgets/home_service.dart';

class CustomAppBar extends StatelessWidget {
  //const CustomAppBar({ Key? key }) : super(key: key);
  IconData leftIcon = Icons.arrow_left_outlined;
  IconData rightIcon = Icons.home_outlined;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
        bottom: 15,
        left: 25,
        right: 25,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: _buildIcon(leftIcon),
          ),
          GestureDetector(
            onTap: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => HomePageUi())),
            child: _buildIcon(rightIcon),
          )
        ],
      ),
    );
  }

  Widget _buildIcon(IconData icon) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          border: Border.all(
            color: Colors.black,
          )),
      child: Icon(icon),
    );
  }
}
