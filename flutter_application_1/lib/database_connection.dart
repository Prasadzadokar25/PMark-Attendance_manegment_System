import 'dart:developer';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

dynamic database;

class NewUser {
  final String userName;
  final String password;
  final String contact;
  NewUser(
      {required this.userName, required this.password, required this.contact});
  Map<String, dynamic> userMap() {
    return {
      'userName': userName,
      'password': password,
      'contact': contact,
    };
  }
}

// initialise database
Future<Database> databaseint() async {
  final database = openDatabase(
    join(await getDatabasesPath(), "todolist8.db"),
    version: 1,
    onCreate: (db, version) {
      db.execute('''CREATE TABLE currentUser(
                    id INTEGER PRIMARY KEY AUTOINCREMENT,
                    userName TEXT,
                    password TEXT
                )''');
    },
  );
  return database;
}

// information class [ sarv app chi information assess karanyat madat karel]
class UserInfo {
  static UserInfo obj = UserInfo();
  // ignore: prefer_typing_uninitialized_variables
  var database;
  String userName = "";

  // ignore: prefer_typing_uninitialized_variables
  var user;
// To return the single obbject of the class(single tan desine patten)
// if we create a new object each time database not get initialise for that object and we get null database error
  static UserInfo getObject() {
    return obj;
  }

  // return database object
  Future<void> getDatabase() async {
    database = await databaseint();
  }

  // add new user in database
  Future<void> insertNewUser(NewUser nu) async {
    await getDatabase();
    final localDB = await database;
    localDB.insert(
      'users',
      nu.userMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> removeCurrentUser() async {
    final localDB = await database;
    localDB.delete(
      'currentUser',
    );
  }

  Future<void> insertCurrentUser(String currentUser, String password) async {
    await getDatabase();
    final localDB = await database;
    user = await getCurrentUser();
    await removeCurrentUser();
    if (user.isEmpty) {
      localDB.insert(
        'currentUser',
        {"userName": currentUser, "password": password},
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } else {
      localDB.update(
        'currentUser',
        {"userName": currentUser, "password": password},
        where: "id = ?",
        whereArgs: [1],
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      user = await getCurrentUser();
    }
  }

  Future<List> getCurrentUser() async {
    await getDatabase();
    final localDB = await database;
    List<Map<String, dynamic>> mapEntry = await localDB.query("currentUser");

    List currentUserList = mapEntry;
    log("pppppppppppppppppppppp");
    print(currentUserList);
    return currentUserList;
  }
}
