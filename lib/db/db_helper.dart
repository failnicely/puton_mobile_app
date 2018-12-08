import 'dart:async';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:puton/db/model/user.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DBHelper {
  static Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();

    return _db;
  }

  //Creating a database with name test.dn in your directory
  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'test99.db');
    var theDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return theDb;
  }

  // Creating a table name User with fields
  void _onCreate(Database db, int version) async {
    // When creating the db, create the table
    await db.execute('CREATE TABLE ' +
        'User(' +
        '  id INTEGER PRIMARY KEY, ' +
        '  username TEXT, ' +
        '  balance TEXT, ' +
        '  raw TEXT' +
        ')');
    print('Created tables');
  }

  // Retrieving users from User Tables
  Future<List<User>> getUsers() async {
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery('SELECT * FROM User');
    List<User> users = list
        .map((u) => User(username: u['username'], balance: u['balance'], raw: u['raw']))
        .toList();

    print(users.length);
    return users;
  }

  void saveUser(User user) async {
    var dbClient = await db;
    await dbClient.transaction((txn) async {
      return await txn.rawInsert(
          'INSERT INTO User(username, balance, raw ) VALUES(' +
              '\'${user.username}\',' +
              '\'${user.balance}\',' +
              '\'${user.raw}\'' +
              ')');
    });
  }

  void clearUser() async {
    var dbClient = await db;
    await dbClient.transaction((txn) async {
      return await txn.rawDelete('DELETE FROM User');
    });
  }
}