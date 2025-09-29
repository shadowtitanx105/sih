import 'package:geolocator/geolocator.dart';

class LocationService {
  Future<Position?> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return null; // location services are off
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return null; // user denied permissions
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return null; // cannot request permissions anymore
    }

    // ✅ Correct way: use LocationSettings instead of desiredAccuracy
    return await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
      ),
    );
  }
}
