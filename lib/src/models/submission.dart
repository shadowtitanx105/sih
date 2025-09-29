import 'package:uuid/uuid.dart';

class Submission {
  final String id;
  final String localPath; // local file path of photo/video
  final double lat;
  final double lng;
  final DateTime timestamp;
  String status; // pending, uploading, uploaded, rejected

  Submission({
    String? id,
    required this.localPath,
    required this.lat,
    required this.lng,
    required this.timestamp,
    this.status = 'pending',
  }) : id = id ?? const Uuid().v4();

  Map<String, dynamic> toJson() => {
        'id': id,
        'localPath': localPath,
        'lat': lat,
        'lng': lng,
        'timestamp': timestamp.toIso8601String(),
        'status': status,
      };

  factory Submission.fromJson(Map<String, dynamic> json) {
    return Submission(
      id: json['id'],
      localPath: json['localPath'],
      lat: json['lat'],
      lng: json['lng'],
      timestamp: DateTime.parse(json['timestamp']),
      status: json['status'],
    );
  }
}
