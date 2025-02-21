// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';
// import 'model/list.dart';

// class DatabaseManager {
//   const DatabaseManager._();

//   static const _databaseName = 'lists.db';
//   static const _databaseVersion = 1;
//   static const DatabaseManager instance = DatabaseManager._();
//   static const table = 'lists';

//   static Database? _database;

//   Future<Database> get database async {
//     if (_database != null) {
//       return _database!;
//     }
//     _database = await _initDatabase();
//     return _database!;
//   }

//   Future<Database> _initDatabase() async {
//     final database = openDatabase(
//       join(await getDatabasesPath(), _databaseName),
//       onCreate: (db, version) {
//         return db.execute(
//           '''
//           CREATE TABLE $table (
//             id TEXT PRIMARY KEY, 
//             title TEXT, 
//             modelName TEXT, 
//             seller TEXT, 
//             price REAL, 
//             timestamp INTEGER, 
//             userId TEXT, 
           
//           )
//           ''',
//         );
//       },
//       version: _databaseVersion,
//     );
//     return database;
//   }

//   Future<void> insertList(MyList list) async {
//     final db = await database;
//     await db.insert(
//       table,
//       list.toMap(),
//       conflictAlgorithm: ConflictAlgorithm.replace,
//     );
//   }

//   Future<void> updateList(MyList list) async {
//     final db = await database;
//     await db.update(
//       table,
//       list.toMap(),
//       where: 'id = ? AND userId = ?',
//       whereArgs: [list.id, list.userId],
//     );
//   }

//   Future<void> deleteList(String id, String userId) async {
//     final db = await database;
//     await db.delete(
//       table,
//       where: 'id = ? AND userId = ?',
//       whereArgs: [id, userId],
//     );
//   }

//   Future<List<MyList>> getLists(String userId) async {
//     final db = await database;
//     final List<Map<String, dynamic>> maps = await db.query(
//       table,
//       where: 'userId = ?',
//       whereArgs: [userId],
//     );
//     return List.generate(maps.length, (i) {
//       return MyList.fromMap(maps[i]);
//     });
//   }
// }