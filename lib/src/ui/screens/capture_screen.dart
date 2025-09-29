import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../src/services/location_service.dart';
import '../../../src/models/submission.dart';
import '../../../src/state/providers.dart';

class CaptureScreen extends ConsumerStatefulWidget {
  const CaptureScreen({super.key});

  @override
  ConsumerState<CaptureScreen> createState() => _CaptureScreenState();
}

class _CaptureScreenState extends ConsumerState<CaptureScreen> {
  CameraController? _controller;
  bool _isReady = false;

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  Future<void> _initCamera() async {
    final cameras = await availableCameras();
    final cameraService = ref.read(cameraServiceProvider);
    await cameraService.init(cameras.first);
    if (!mounted) return;
    setState(() {
      _controller = cameraService.controller;
      _isReady = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final db = ref.read(dbServiceProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Capture Submission")),
      body: _isReady
          ? Column(
              children: [
                Expanded(child: CameraPreview(_controller!)),
                ElevatedButton(
                  onPressed: () async {
                    final filePath = await ref
                        .read(cameraServiceProvider)
                        .takePicture();

                    final pos = await LocationService().getCurrentLocation();
                    if (pos == null) {
                      if (!mounted) return; // ✅ moved up
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Failed to get location")),
                      );
                      return;
                    }

                    final submission = Submission(
                      localPath: filePath,
                      lat: pos.latitude,
                      lng: pos.longitude,

                      timestamp: DateTime.now(),
                    );
                    await db.insertSubmission(submission);

                    if (!mounted) return; // ✅ moved up
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Submission saved locally")),
                    );
                    Navigator.pushNamed(context, '/submissions');
                  },
                  child: const Text("Capture & Save"),
                ),
              ],
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
