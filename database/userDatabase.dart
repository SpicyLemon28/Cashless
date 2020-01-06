import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

import '../models/user.dart';

class DatabaseHelper {

	static DatabaseHelper _databaseHelper;    // Singleton DatabaseHelper
	static Database _database;                // Singleton Database

	String tblUsers = 'users';

	DatabaseHelper._createInstance(); // Named constructor to create instance of DatabaseHelper

	factory DatabaseHelper() {
		if (_databaseHelper == null) {
			_databaseHelper = DatabaseHelper._createInstance(); // This is executed only once, singleton object
		}
		return _databaseHelper;
	}

	Future<Database> get database async {
		if (_database == null) {
			_database = await initializeDatabase();
		}
		return _database;
	}

	Future<Database> initializeDatabase() async {
		// Get the directory path for both Android and iOS to store database.
		Directory directory = await getApplicationDocumentsDirectory();
		String path = directory.path + 'cashless.db';
		// Open/create the database at a given path
		var dbCashless = await openDatabase(path, version: 1, onCreate: _createDb);
		return dbCashless;
	}

	void _createDb(Database db, int newVersion) async {
		await db.execute(
			'CREATE TABLE $tblUsers ('
			'  id INTEGER PRIMARY KEY AUTOINCREMENT,'
			'  name 			TEXT,'
			'  email 			TEXT,'
			'  phone 			TEXT,'
			'  studentId	TEXT,'
			'  password 	TEXT,'
			'  pin 				TEXT,'
			'  date 			TEXT'
			')'
		);
	}

	// Insert Operation: Insert a User object to database
	Future<int> insertUser(User user) async {
		Database db = await this.database;
		var result = await db.insert(tblUsers, user.toMap());
		return result;
	}

	// Update Operation: Update a User object and save it to database
	Future<int> updateUser(User user) async {
		var db = await this.database;
		var result = await db.update(tblUsers, user.toMap(), where: 'id = ?', whereArgs: [user.id]);
		return result;
	}

	// Get number of User objects in database
	Future<int> getCount() async {
		Database db = await this.database;
		List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT (*) from $tblUsers');
		int result = Sqflite.firstIntValue(x);
		return result;
	}

}
