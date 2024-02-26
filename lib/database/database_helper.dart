import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Database? _database;
  static final DatabaseHelper instance = DatabaseHelper._();

  DatabaseHelper._();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), 'patient_database.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE appointments (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            appointment_title TEXT,
            appointment_date TEXT,
            appointment_complete INTEGER
          )
        ''');
        await db.execute('''
          CREATE TABLE lab_reports (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            appointment_id INTEGER,
            report_name TEXT,
            date TEXT,
            result TEXT,
            FOREIGN KEY (appointment_id) REFERENCES appointments (id)
          )
        ''');
        await db.execute('''
          CREATE TABLE lab_tests (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            appointment_id INTEGER,
            test_name TEXT,
            date TEXT,
            result TEXT,
            FOREIGN KEY (appointment_id) REFERENCES appointments (id)
          )
        ''');
        await db.execute('''
          CREATE TABLE prescriptions (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            appointment_id INTEGER,
            medicine_name TEXT,
            dosage TEXT,
            date TEXT,
            FOREIGN KEY (appointment_id) REFERENCES appointments (id)
          )
        ''');
      },
    );
  }

  Future<int> insertAppointment(Map<String, dynamic> appointment) async {
    Database db = await database;
    return await db.insert('appointments', appointment);
  }

  Future<List<Map<String, dynamic>>> getAppointments() async {
    Database db = await database;
    return await db.query('appointments');
  }

  Future<int> insertLabReport(Map<String, dynamic> labReport) async {
    Database db = await database;
    return await db.insert('lab_reports', labReport);
  }

  Future<List<Map<String, dynamic>>> getLabReports(int appointmentId) async {
    Database db = await database;
    return await db.query('lab_reports', where: 'appointment_id = ?', whereArgs: [appointmentId]);
  }

  Future<List<Map<String, dynamic>>> getLabTests(int appointmentId) async {
    Database db = await database;
    return await db.query('lab_tests', where: 'appointment_id = ?', whereArgs: [appointmentId]);
  }

  Future<List<Map<String, dynamic>>> getPrescriptions(int appointmentId) async {
    Database db = await database;
    return await db.query('prescriptions', where: 'appointment_id = ?', whereArgs: [appointmentId]);

// Similar methods for lab_tests, prescriptions
}}
