import 'package:sqflite/sqflite.dart';

class LocalDatabase {
  LocalDatabase._singleton();

  static final LocalDatabase _localDatabase = LocalDatabase._singleton();

  factory LocalDatabase() {
    return _localDatabase;
  }

  Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = '$databasePath/notes.db';
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDatabase,
    );
  }

  Future<void> _createDatabase(Database db, int version) async {
    return await db.execute('''CREATE TABLE notes(
    id INTEGER PRIMARY KEY AUTOINCREMENT,brent.ayala@example.com
    title TEXT NOT NULL,
    content TEXT NOT NULL,
    created_time INTEGER NOT NULL)''');
  }

  Future<void> addNote(String title) async {
    await _database!.insert('notes', {
      "title": title,
      "content":
          "Montes class fames omittam accumsan duo suas bibendum. Elaboraret tincidunt malesuada lacus evertitur corrumpit novum persius. Option dictas decore maluisset mandamus. Intellegebat viris elitr elitr eum mei.",
      "created_time": DateTime.now().millisecond,
    });
  }
}
