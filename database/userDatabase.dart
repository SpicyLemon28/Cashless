import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../models/User.dart';

class UserDatabase {

  static UserDatabase _userDatabase;
  static Database _database;

  String userTable = 'userTable',
         userId = 'userId',
         studId = 'studentId',
         pin    = 'pin', 
         token  = 'token', 
         phone  = 'phone',
         name = 'name',
         email = 'email',
         password = 'password',
         date = 'date';
  
  UserDatabase._createInstance();

  factory UserDatabase() {

    if (_userDatabase == null) {
      _userDatabase = UserDatabase._createInstance();
    }
    return _userDatabase;
  }

  Future<Database> get database async {

    if(_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {

    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'user.db';

    var usersDatabase = await openDatabase(path, version: 1, onCreate: _createDb);
    return usersDatabase;
  }

  void _createDb(Database db, int newVersion) async {

    await db.execute('CREATE TABLE $userTable($userId INTEGER PRIMARY KEY AUTOINCREMENT, $studId INTEGER, '
				'$pin INTEGER, $token INTEGER, $phone INTEGER, $name TEXT, $email TEXT, $password TEXT)');
  }
  
  Future<List<Map<String, dynamic>>> getUserMapList() async {
		Database db = await this.database;

    var result = await db.query(userTable, orderBy: '$userId DESC');
		return result;
  }

  Future<int> insertUser(User user) async {
		Database db = await this.database;
		var result = await db.insert(userTable, user.toMap());
		return result;
  }

  Future<int> updateUser(User user) async {
		var db = await this.database;
		var result = await db.update(userTable, user.toMap(), where: '$userId = ?', whereArgs: [user.userId]);
		return result;
	}

  Future<int> deleteUser(int userId) async {
		var db = await this.database;
		int result = await db.rawDelete('DELETE FROM $userTable WHERE $userId = $userId');
		return result;
	}

  Future<int> getCount() async {
		Database db = await this.database;
		List<Map<String, dynamic>> x = await db.rawQuery('SELECT * FROM $userTable WHERE $phone = $phone');
		int result = Sqflite.firstIntValue(x);
		return result;
	}

  Future<List<User>> getUser() async {

		var userMapList = await getUserMapList(); 
		int count = userMapList.length;         

		List<User> user = List<User>();
		
		for (int i = 0; i < count; i++) {
			user.add(User.fromDb(userMapList[i]));
		}
    return user;
  } 
}