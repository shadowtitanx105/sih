import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/auth_service.dart';
import '../services/db_service.dart';
import '../services/camera_service.dart';
import '../services/sync_service.dart';

// Auth provider
final authServiceProvider = Provider<AuthService>((ref) => AuthService());

// DB provider
final dbServiceProvider = Provider<DbService>((ref) {
  final db = DbService();
  db.init();
  return db;
});

// Camera provider
final cameraServiceProvider = Provider<CameraService>((ref) => CameraService());

// Sync provider
final syncServiceProvider = Provider<SyncService>((ref) {
  final db = ref.read(dbServiceProvider);
  return SyncService(db);
});
