import 'dart:io';
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

class CameraService {
  late CameraController _controller;

  Future<void> init(CameraDescription description) async {
    _controller = CameraController(description, ResolutionPreset.high);
    await _controller.initialize();
  }

  CameraController get controller => _controller;

  Future<String> takePicture() async {
    final image = await _controller.takePicture();
    final dir = await getApplicationDocumentsDirectory();
    final newPath = "${dir.path}/${const Uuid().v4()}.jpg";
    await File(image.path).copy(newPath);
    return newPath;
  }

  void dispose() {
    _controller.dispose();
  }
}
