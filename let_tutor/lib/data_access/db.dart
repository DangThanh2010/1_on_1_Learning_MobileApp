import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DB{
  static final DB _db = DB._internal();
  DB._internal();
  static DB get instance => _db;

  Database? database;
  final databaseName = "lettutor.db";

  Future open(String databaseName) async{
    database = await openDatabase(join(await getDatabasesPath(), databaseName), version: 1,
      onCreate: (Database db, int version) async{
        await db.execute("create table Tutor(id integer primary key, avatar text, name text, nation text, isFavourite integer, introduction text, education text, experience text, interests text, profession text)");
        await db.execute("create table Booking(id integer primary key, idTutor integer, start text, end text, isCancel integer, isFeedbacked integer)");
        await db.execute("create table Comment(id integer primary key, idTutor integer, star integer, comment text, dateTime text)");
      });
  }

  Future insert(String tableName, dynamic item) async{
    await open(databaseName);
    await database?.insert(tableName, item);
    await close();
  }

  Future<List<Map<String, dynamic>>?> getTable(String tableName) async{
    await open(databaseName);
    List<Map<String, dynamic>>? result = await database?.query(tableName);
    await close();

    return result;
  }

  Future delete(String tableName, String? where, List<Object?>? whereArgs) async{
    await open(databaseName);
    await database?.delete(tableName, where: where, whereArgs: whereArgs);
    await close();
  }

  Future update(String tableName, dynamic item, String? where, List<Object?>? whereArgs) async{
    await open(databaseName);
    await database?.update(tableName, item, where: where, whereArgs: whereArgs);
    await close();
  }

  Future close() async{
    database?.close();
  }
}