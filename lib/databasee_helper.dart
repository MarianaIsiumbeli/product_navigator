// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';

// class DatabaseHelper {
//   static final DatabaseHelper _instance = DatabaseHelper._internal();
//   factory DatabaseHelper() => _instance;
//   DatabaseHelper._internal();

//   static Database? _database;

//   Future<Database> get database async {
//     if (_database != null) return _database!;
//     _database = await _initDatabase();
//     return _database!;
//   }

//   Future<Database> _initDatabase() async {
//     final dbPath = join(await getDatabasesPath(), 'product_lists.db');
//     return await openDatabase(
//       dbPath,
//       version: 1,
//       onCreate: (db, version) async {
//         await db.execute('''
//           CREATE TABLE lists(
//             id INTEGER PRIMARY KEY AUTOINCREMENT,
//             name TEXT
//           )
//         ''');
//         await db.execute('''
//           CREATE TABLE products(
//             id INTEGER PRIMARY KEY AUTOINCREMENT,
//             listId INTEGER,
//             name TEXT,
//             FOREIGN KEY (listId) REFERENCES lists(id)
//           )
//         ''');
//       },
//     );
//   }

//   Future<int> insertList(String name) async {
//     final db = await database;
//     return await db.insert('lists', {'name': name});
//   }

//   Future<int> insertProduct(int listId, String name) async {
//     final db = await database;
//     return await db.insert('products', {'listId': listId, 'name': name});
//   }

//   Future<List<Map<String, dynamic>>> getLists() async {
//     final db = await database;
//     return await db.query('lists');
//   }

//   Future<List<Map<String, dynamic>>> getProducts(int listId) async {
//     final db = await database;
//     return await db.query('products', where: 'listId = ?', whereArgs: [listId]);
//   }
// }
