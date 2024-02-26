import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class PatientDatabaseHelper {
  static Database? _database;
  static final PatientDatabaseHelper instance = PatientDatabaseHelper._();

  PatientDatabaseHelper._();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'patient.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE patients(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            username TEXT,
            email TEXT,
            name TEXT,
            contact TEXT,
            address TEXT,
            gender TEXT,
            password TEXT,
            allergies TEXT,
            date_of_birth TEXT
          )
        ''');
      },
    );
  }

  Future<int> insertPatient(Map<String, dynamic> patient) async {
    Database db = await database;
    return await db.insert('patients', patient);
  }

  Future<Map<String, dynamic>?> getPatientByUsername(String username) async {
    Database db = await database;
    List<Map<String, dynamic>> result = await db.query(
      'patients',
      where: 'username = ?',
      whereArgs: [username],
    );
    return result.isNotEmpty ? result.first : null;
  }


  // Read (Get) all patients
  Future<List<Map<String, dynamic>>> getAllPatients() async {
    Database db = await database;
    return await db.query('patients');
  }


  // Update a patient
  Future<int> updatePatient(Map<String, dynamic> patient) async {
    Database db = await database;
    return await db.update(
      'patients',
      patient,
      where: 'id = ?',
      whereArgs: [patient['id']],
    );
  }

  // Delete a patient
  Future<int> deletePatient(int id) async {
    Database db = await database;
    return await db.delete(
      'patients',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
