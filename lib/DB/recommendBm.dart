import 'package:flutter/material.dart';
import 'package:movie/component/variable.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class recommend_bm {
  var _db;

  Future<Database> get database async {
    if (_db != null) {
      return _db;
    }

    _db = openDatabase(
      join(await getDatabasesPath(), 'recommendInfo.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE recommend(id INTEGER PRIMARY KEY, name TEXT, mvcount TEXT)",
        );
      },
      version: 51,
    );
    return _db;
  }

  Future<void> insertData(Recommend rec) async {
    final Database db = await database;

    await db.insert('recommend', rec.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    recID += 1;
    debugPrint('insert Data recID:' + recID.toString());
    debugPrint('insertData:' + rec.name + rec.mvcount);
  }

  Future<void> updateData(Recommend rec) async {
    final db = await database;

    await db
        .update('recommend', rec.toMap(), where: "id = ?", whereArgs: [rec.id]);
  }

  Future<List<Recommend>> getAllData() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('recommend');

    return List.generate(maps.length, (index) {
      recID = maps[index]['id'] + 1;

      return Recommend(
          maps[index]['id'], maps[index]['name'], maps[index]['mvcount']);
    });
  }

  Future<void> deleteAll() async {
    final db = await database;
    await db.rawDelete('DELETE FROM recommend');
    recID = 1;
  }
}

class Recommend {
  final int id;

  final String name; //theaterName
  final String mvcount; // theater call count

  Recommend(this.id, this.name, this.mvcount);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'mvcount': mvcount,
    };
  }

  @override
  String toString() {
    return 'Recommend{id:$id, name:$name, mvcount:$mvcount}';
  }
}
