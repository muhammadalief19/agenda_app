import 'package:agenda_app/model/note_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class NoteDatabase {
  static final NoteDatabase instance = NoteDatabase._init();

  NoteDatabase._init();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB("note.db");
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    final sql = '''
    CREATE TABLE $tableNote(
      ${NoteFields.id} INTEGER PRIMARY KEY AUTOINCREMENT,
      ${NoteFields.agendaCode} VARCHAR(255) NOT NULL,
      ${NoteFields.name} TEXT NOT NULL,
      ${NoteFields.date} DATE NOT NULL,
      ${NoteFields.time} TIME NOT NULL,
      ${NoteFields.deskripsi} TEXT NOT NULL,
      ${NoteFields.createdAt} TEXT NOT NULL
    )
    ''';

    await db.execute(sql);
  }

  Future<Note> create(Note note) async {
    final db = await instance.database;
    final id = await db.insert(tableNote, note.toJson());
    return note.copy(id: id);
  }

  Future<List<Note>> getAllNotes() async {
    final db = await instance.database;
    final results = await db.query(tableNote);

    return results.map((json) => Note.fromJson(json)).toList();
  }

  Future<Note> getNoteBycode(String code) async {
    final db = await instance.database;
    final result = await db.query(tableNote,
        where: '${NoteFields.agendaCode} = ?', whereArgs: [code]);
    if (result.isNotEmpty) {
      return Note.fromJson(result.first);
    } else {
      throw Exception('ID $code not found');
    }
  }

  Future<int> deleteNoteById(int id) async {
    final db = await instance.database;
    return await db
        .delete(tableNote, where: '${NoteFields.id} = ?', whereArgs: [id]);
  }

  Future<int> updateNoteById(Note note) async {
    final db = await instance.database;
    return await db.update(tableNote, note.toJson(),
        where: '${NoteFields.id} = ?', whereArgs: [note.id]);
  }
}
