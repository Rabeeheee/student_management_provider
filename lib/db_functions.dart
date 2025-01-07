// ignore_for_file: depend_on_referenced_packages
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:student_management_provider/model/model.dart';


class DatabaseHelper {
  
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'students.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE students (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            grade TEXT,
            age TEXT,
            guardianName TEXT,
            guardianPhone TEXT,
            profileImage TEXT
          )
        ''');
      },
    );
  }

  Future<void> insertStudent(StudentModel student) async {
    final db = await database;
    await db.insert(
      'students',
      student.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<StudentModel>> fetchStudents() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('students');

    return List.generate(maps.length, (i) {
      return StudentModel.fromMap(maps[i]);
    });
  }

    Future<void> deleteStudent(int id) async {
    final db = await database;
    await db.delete(
      'students', 
      where: 'id = ?', 
      whereArgs: [id],
    );
  }
}
