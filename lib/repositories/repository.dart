import 'package:flutter/cupertino.dart';
import 'package:nudger/repositories/database_connection.dart';
import 'package:sqflite/sqflite.dart';

class Repository {
  DatabaseConnection? _databaseConnection;

  Repository() {
    _databaseConnection = DatabaseConnection();
  }

  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _databaseConnection?.setDatabase();
    return _database;
  }

  //insert the data in the table
  insertData(table, data) async {
    var connection = await database; //initialises the database
    return await connection?.insert(table, data);
  }

  //read the data from the table
  readData(table) async {
    var connection = await database;
    return await connection?.query(table);
  }

  //read the data from the table by Id
  readDataById(table, itemId) async {
    var connection = await database;
    return await connection?.query(table, where: 'id=?', whereArgs: [itemId]);
  }

  //update the data from the table
  updateData(table, data) async {
    var connection = await database;
    return await connection
        ?.update(table, data, where: 'id=?', whereArgs: [data['id']]);
  }

  //delete the data from the table
  deleteData(table, itemId) async {
    var connection = await database;
    return await connection?.rawDelete("DELETE FROM $table WHERE id = $itemId");
  }
}
