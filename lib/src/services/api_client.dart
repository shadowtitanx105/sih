import 'package:dio/dio.dart';

class ApiClient {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: "https://your-backend-url.com", // replace with ngrok/backend
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
  ));

  Future<Response> uploadSubmission(Map<String, dynamic> data, String filePath) async {
    final formData = FormData.fromMap({
      ...data,
      'file': await MultipartFile.fromFile(filePath),
    });

    return await _dio.post("/api/submissions", data: formData);
  }

  Future<Response> requestOtp(String phone) async {
    return await _dio.post("/auth/request-otp", data: {"phone": phone});
  }

  Future<Response> verifyOtp(String phone, String otp) async {
    return await _dio.post("/auth/verify-otp", data: {"phone": phone, "otp": otp});
  }
}
