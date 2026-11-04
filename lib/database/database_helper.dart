import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;
  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('money.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }
}

Future _createDB(Database db, int version) async {
  await db.execute(
    'CREATE TABLE icon (id_icon TEXT PRIMARY KEY, nama_icon TEXT NOT NULL UNIQUE, is_active INTEGER NOT NULL DEFAULT 1 CHECK (is_active IN (0, 1)))',
  );
  await db.execute(
    'CREATE TABLE rekening (id_rekening TEXT PRIMARY KEY, nama_rekening TEXT NOT NULL UNIQUE, saldo INTEGER NOT NULL DEFAULT 0 ,is_active INTEGER NOT NULL DEFAULT 1 CHECK (is_active IN (0, 1)))',
  );
}
