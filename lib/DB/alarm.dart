import 'package:flutter/material.dart';
import 'package:movie/component/variable.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AlarmDB {
  var _db;

  Future<Database> get database async {
    if (_db != null) {
      return _db;
    }

    _db = openDatabase(
      join(await getDatabasesPath(), 'alarmVal.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE alarm(id INTEGER PRIMARY KEY, name TEXT, date TEXT, time TEXT, value TEXT)",
        );
      },
      version: 51,
    );
    return _db;
  }

  Future<void> insertData(Alarm rec) async {
    final Database db = await database;

    await db.insert('alarm', rec.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    alarmID += 1;
  }

  Future<void> updateData(Alarm rec) async {
    final db = await database;

    await db
        .update('alarm', rec.toMap(), where: "id = ?", whereArgs: [alarmID]);
  }

  Future<List<Alarm>> getAllData() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('alarm');

    return List.generate(maps.length, (index) {
      alarmID = maps[index]['id'] + 1;

      return Alarm(maps[index]['id'], maps[index]['name'], maps[index]['date'],
          maps[index]['time'], maps[index]['value']);
    });
  }

  Future<void> deleteAll() async {
    final db = await database;
    await db.rawDelete('DELETE FROM alarm');
    alarmID = 1;
  }
}

class Alarm {
  final int id;

  final String name;
  final String date;
  final String time;
  final String value;

  Alarm(this.id, this.name, this.date, this.time, this.value);

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'date': date, 'time': time, 'value': value};
  }

  @override
  String toString() {
    return 'Alarm{id:$id, name:$name, date:$date, time:$time, value:$value}';
  }
}
