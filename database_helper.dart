import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('user.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT,
        password TEXT,
        name TEXT,
        nim TEXT,
        kelas TEXT
      )
    ''');
  }

  Future<int> insertUser(Map<String, dynamic> data) async {
    final db = await instance.database;
    return db.insert('users', data);
  }

  Future<Map<String, dynamic>?> login(
      String username, String password) async {
    final db = await instance.database;

    final result = await db.query(
      'users',
      where: 'username=? AND password=?',
      whereArgs: [username, password],
    );

    if (result.isNotEmpty) return result.first;
    return null;
  }
  Future<bool> verifyPassword(int id, String password) async {
  final db = await database;

  final res = await db.query(
    'users',
    where: 'id = ? AND password = ?',
    whereArgs: [id, password],
  );

  return res.isNotEmpty;
}

  Future<int> updateUser(int id, Map<String, dynamic> data) async {
  final db = await database;

  return db.update(
    'users',
    data,
    where: 'id = ?',
    whereArgs: [id],
  );
}
}