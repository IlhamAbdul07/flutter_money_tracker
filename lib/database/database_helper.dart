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
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
      onConfigure: _configureDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute(
      'CREATE TABLE icon (id_icon TEXT PRIMARY KEY, nama_icon TEXT NOT NULL UNIQUE, is_active INTEGER NOT NULL DEFAULT 1 CHECK (is_active IN (0, 1)))',
    );
    await db.execute('''
      CREATE TABLE rekening (
      id_rekening TEXT PRIMARY KEY, 
      nama_rekening TEXT NOT NULL UNIQUE, 
      saldo INTEGER NOT NULL DEFAULT 0 ,
      is_active INTEGER NOT NULL DEFAULT 1 CHECK (is_active IN (0, 1)))
      ''');
    await db.execute('''
      CREATE TABLE jenis_pengeluaran (
        id_jenis_pengeluaran TEXT PRIMARY KEY,
        jenis_pengeluaran TEXT NOT NULL UNIQUE,
        id_icon TEXT NOT NULL,
        is_active INTEGER NOT NULL DEFAULT 1 CHECK (is_active IN (0, 1)),
        FOREIGN KEY (id_icon) REFERENCES icon (id_icon) ON DELETE RESTRICT
      )''');
    await db.execute('''
      CREATE TABLE jenis_pemasukan (
        id_jenis_pemasukan TEXT PRIMARY KEY,
        jenis_pemasukan TEXT NOT NULL UNIQUE,
        id_icon TEXT NOT NULL,
        is_active INTEGER NOT NULL DEFAULT 1 CHECK (is_active IN (0, 1)),
        FOREIGN KEY (id_icon) REFERENCES icon (id_icon) ON DELETE RESTRICT
      )''');
    await db.execute('''
      CREATE TABLE tujuan_pengeluaran (
        id_tujuan TEXT PRIMARY KEY,
        id_jenis_pengeluaran TEXT NOT NULL,
        tujuan_pengeluaran TEXT NOT NULL,
        is_active INTEGER NOT NULL DEFAULT 1 CHECK (is_active IN (0, 1)),
        FOREIGN KEY (id_jenis_pengeluaran) REFERENCES jenis_pengeluaran (id_jenis_pengeluaran) ON DELETE RESTRICT
      )''');
    await db.execute('''
      CREATE TABLE sumber_pemasukan (
        id_sumber TEXT PRIMARY KEY,
        id_jenis_pemasukan TEXT NOT NULL,
        sumber_pemasukan TEXT NOT NULL,
        is_active INTEGER NOT NULL DEFAULT 1 CHECK (is_active IN (0, 1)),
        FOREIGN KEY (id_jenis_pemasukan) REFERENCES jenis_pemasukan (id_jenis_pemasukan) ON DELETE RESTRICT
      )''');
  }

  Future _configureDB(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }
}
