import 'dart:async';
import 'package:flutter/material.dart';
import 'package:movie/component/variable.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper_bm {
  var _db;

  Future<Database> get database async {
    if (_db != null) {
      return _db;
    }
    _db = openDatabase(
      join(await getDatabasesPath(), 'bookmarkInfo.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE bookmark(id INTEGER PRIMARY KEY, company TEXT, region TEXT, theater TEXT)",
        );
      },
      version: 51,
    );
    return _db;
  }

  Future<void> insertData(Bookmark bookmark) async {
    final Database db = await database;

    await db.insert('bookmark', bookmark.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    varNum++;
    debugPrint('db insert');
  }

  getData(int id) async {
    final db = await database;
    var res = await db.query("bookmark", where: "id = ?", whereArgs: [id]);

    return res.isNotEmpty
        ? res.first['company'].toString() + res.first['theater'].toString()
        : null;
  } //특정 데이터 찾는 함수로

  Future<List<Bookmark>> getAllData() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('bookmark');
    debugPrint('db get all data');

    return List.generate(maps.length, (i) {
      varNum = maps[i]['id'] + 1;
      debugPrint('!!varNum:' + varNum.toString());
      return Bookmark(
        maps[i]['id'],
        maps[i]['company'],
        maps[i]['region'],
        maps[i]['theater'],
      );
    });
  }

  Future<void> updateData(Bookmark bookmark) async {
    final db = await database;

    await db.update('bookmark', bookmark.toMap(),
        where: "id = ?", whereArgs: [bookmark.id]);
  }

  Future<void> deleteData(int id) async {
    final db = await database;
    await db.rawDelete('DELETE FROM bookmark WHERE id = ?', [id]);
    varNum--;
    print('delete');
    printAllData();
  }

  Future<void> deleteAll() async {
    final db = await database;
    await db.rawDelete('DELETE FROM bookmark');
  }

  Future<void> printAllData() async {
    final Database db = await database;
    await db.query('bookmark').then((value) => value.forEach((element) {
          element.forEach((key, value) {
            print('$key: $value\n');
          });
        }));
  }
}

class Bookmark {
  final int id;

  String company; // lotte , CGV , Mega
  String region; // 대한민국 8도 지역
  String theater; // 세부 지역

  Bookmark(
    this.id,
    this.company,
    this.region,
    this.theater,
  );
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'company': company,
      'region': region,
      'theater': theater,
    };
  }

  // 각 dog 정보를 보기 쉽도록 print 문을 사용하여 toString을 구현하세요.

  @override
  String toString() {
    return 'Bookmark{id:$id, company:$company, region:$region, theater:$theater,}';
  }
}
