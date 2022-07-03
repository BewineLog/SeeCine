import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movie/DB/alarm.dart';
import 'package:movie/DB/recommendBm.dart';
import 'package:movie/DB/userBookmark.dart';
import 'package:movie/component/variable.dart';
import 'package:movie/screens/Page1/widgets/home_service.dart';
import 'package:timezone/data/latest.dart' as tz;
// import 'package:timezone/timezone.dart' as tz;

void main() async {
  FutureBuilder.debugRethrowError = true;

  // Crawler crawl_provider = Crawler_input();
  //crawl_provider.getData(); // if 2page movie name input 날리면 날리기.

  WidgetsFlutterBinding.ensureInitialized();
  //fetchData(); //Ranking Data Fetch 후 DB 저장
  provider = DBHelper_bm();
  provider.database;

  recomm_provider = recommend_bm();
  // recomm_provider.deleteAll();
  recomm_provider.database;
  recommend_future = await recomm_provider.getAllData();
  // Future.delayed(Duration(seconds: 3));
  todayDt = DateFormat('yyyy-MM-dd').format(DateTime.now());
  nowTm = DateFormat('HH:mm').format(DateTime.now());
  selectDt = todayDt;
  debugPrint('today: ' + todayDt);
  debugPrint('nowTm:' + nowTm);
  debugPrint('Bookmark');
  tz.initializeTimeZones();

  alarm_provider = AlarmDB();
  alarm_provider.deleteAll();
  alarm_provider.database;
  alarm_future = await alarm_provider.getAllData();
  alarm_provider.deleteAll();

  // devId = await _getID();
  // num_provider = DBHelper_num();
  // num_provider.database;
  // num_provider.insertData(Value(devId.toString(), varNum));
  //num_provider.insertData(Value(dbId, varNum));

  //provider.deleteAll();

  // NotificationService().initNotification();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Seecine',
      home: HomePageUi(),
    );
  }
}
