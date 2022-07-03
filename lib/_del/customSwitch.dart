import 'package:flutter/material.dart';

class CustomSwitch extends StatefulWidget {
  CustomSwitch(
      {Key? key, required this.optionlist, required this.selectedValue})
      : super(key: key);

  final List optionlist;
  String selectedValue;
  @override
  _CustomSwitchState createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // give the tab bar a height [can change hheight to preferred height]
            Container(
              height: 45,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(
                  25.0,
                ),
              ),
              child: TabBar(
                controller: _tabController,
                // give the indicator a decoration (color and border radius)
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    25.0,
                  ),
                  color: Colors.green,
                ),
                labelColor: Colors.white,
                unselectedLabelColor: Colors.black,
                tabs: [
                  Tab(
                    text: '장소가 중요해!',
                  ),
                  Tab(
                    text: '시간이 중요해!',
                  ),
                ],
              ),
            ),
            // tab bar view here
            // Expanded(
            // child: TabBarView(
            //   controller: _tabController,
            //   children: [
            //     // first tab bar view widget
            //     Center(
            //       child: Text(
            //         'Place Bid',
            //         style: TextStyle(
            //           fontSize: 25,
            //           fontWeight: FontWeight.w600,
            //         ),
            //       ),
            //     ),
            //     // second tab bar view widget
            //     Center(
            //       child: Text(
            //         'Buy Now',
            //         style: TextStyle(
            //           fontSize: 25,
            //           fontWeight: FontWeight.w600,
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
            // ),
          ],
        ),
      ),
    );
  }
}
