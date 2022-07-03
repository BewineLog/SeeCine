import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

const String tableName = 'rankingInfo';

class DBHelper_ri {
  var _db;

  Future<Database> get database async {
    if (_db != null) {
      return _db;
    }
    _db = openDatabase(
      join(await getDatabasesPath(), 'ranking.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE data(id INTEGER PRIMARY KEY, rank TEXT, openDt TEXT, movieNm TEXT, audiAcc TEXT, audiCnt TEXT)",
        );
      },
      version: 1,
    );
    return _db;
  }

  Future<void> insertData(Data data) async {
    final Database db = await database;

    await db.insert('data', data.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Data>> data() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('data');

    return List.generate(maps.length, (i) {
      return Data(
        maps[i]['id'],
        maps[i]['rank'],
        maps[i]['openDt'],
        maps[i]['movieNm'],
        maps[i]['audiAcc'],
        maps[i]['audiCnt'],
      );
    });
  }

  Future<void> updateData(Data data) async {
    final db = await database;

    await db
        .update('data', data.toMap(), where: "id = ?", whereArgs: [data.id]);
  }

  Future<void> deleteData(int id) async {
    final db = await database;
    await db.delete('data', where: "id = ?", whereArgs: [id]);
  }
}

class Data {
  final int id;
  final String rank;
  final String openDt;
  final String movieNm;
  final String audiAcc;
  final String audiCnt;

  Data(this.id, this.rank, this.openDt, this.movieNm, this.audiAcc,
      this.audiCnt);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'rank': rank,
      'openDt': openDt,
      'movieNm': movieNm,
      'audiAcc': audiAcc,
      'audiCnt': audiCnt,
    };
  }

  // 각 dog 정보를 보기 쉽도록 print 문을 사용하여 toString을 구현하세요
  @override
  String toString() {
    return 'Data{id: $id, rank: $rank, openDt: $openDt, movieNm:$movieNm, audiAcc:$audiAcc, audiCnt: $audiCnt}';
  }
}
