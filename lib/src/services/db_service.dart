import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/submission.dart';

class DbService {
  Database? _db;

  Future<void> init() async {
    final dbPath = await getDatabasesPath();
    _db = await openDatabase(
      join(dbPath, 'loan_utilization.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE submissions(id TEXT PRIMARY KEY, localPath TEXT, lat REAL, lng REAL, timestamp TEXT, status TEXT)',
        );
      },
      version: 1,
    );
  }

  Future<void> insertSubmission(Submission submission) async {
    await _db!.insert('submissions', submission.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Submission>> getSubmissions() async {
    final maps = await _db!.query('submissions');
    return List.generate(maps.length, (i) => Submission.fromJson(maps[i]));
  }

  Future<void> updateStatus(String id, String status) async {
    await _db!.update('submissions', {'status': status},
        where: 'id = ?', whereArgs: [id]);
  }
}
