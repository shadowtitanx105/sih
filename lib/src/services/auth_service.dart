import 'dart:developer' as developer;
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authServiceProvider = Provider<AuthService>((ref) => AuthService());

enum UserRole { beneficiary, officer }

class AuthService {
  final Map<String, String> _otpStore = {};

  /// Requests an OTP for a given phone and role
  Future<void> requestOtp(String phone, UserRole role) async {
    // Hardcoded OTP for testing purposes
    const otp = '123456';
    _otpStore[phone] = otp;
    developer.log("Sending hardcoded OTP $otp to $phone for role $role");
    await Future.delayed(const Duration(seconds: 1));
  }

  /// Verifies OTP for a given phone
  Future<bool> verifyOtp(String phone, String otp) async {
    await Future.delayed(const Duration(seconds: 1));
    final success = _otpStore[phone] == otp;
    if (success) {
      developer.log("Login successful for $phone");
    } else {
      developer.log("Login failed for $phone");
    }
    return success;
  }
}
