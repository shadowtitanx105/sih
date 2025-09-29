import 'db_service.dart';
import 'api_client.dart';

class SyncService {
  final DbService _dbService;
  final ApiClient _apiClient = ApiClient();

  SyncService(this._dbService);

  Future<void> syncPending() async {
    final submissions = await _dbService.getSubmissions();
    for (final s in submissions.where((x) => x.status == 'pending')) {
      try {
        final resp = await _apiClient.uploadSubmission(s.toJson(), s.localPath);
        if (resp.statusCode == 200) {
          await _dbService.updateStatus(s.id, 'uploaded');
        }
      } catch (e) {
        // Leave as pending for retry
      }
    }
  }
}
