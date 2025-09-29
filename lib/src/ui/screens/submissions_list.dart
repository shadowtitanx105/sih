import 'dart:io';
import 'package:flutter/material.dart';
import '../../models/submission.dart';

class SubmissionsListScreen extends StatelessWidget {
  final List<Submission> submissions;

  const SubmissionsListScreen({super.key, required this.submissions});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Submissions"),
      ),
      body: submissions.isEmpty
          ? const Center(
              child: Text("No submissions yet."),
            )
          : ListView.builder(
              itemCount: submissions.length,
              itemBuilder: (context, index) {
                final sub = submissions[index];
                return Card(
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    leading: sub.localPath.isNotEmpty
                        ? Image.file(
                            File(sub.localPath),
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          )
                        : const Icon(Icons.image_not_supported),
                    title: Text("Submission ${sub.id.substring(0, 6)}"),
                    subtitle: Text(
                      "Lat: ${sub.lat}, Lng: ${sub.lng}\nStatus: ${sub.status}",
                    ),
                  ),
                );
              },
            ),
    );
  }
}
