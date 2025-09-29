// lib/src/services/auth_service.dart
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Simple AuthService for development/testing that fakes OTP sending/verification.
///
/// - `requestOtp` simulates sending an OTP (no real SMS is sent).
/// - `verifyOtp` returns true only when the provided OTP matches [_testOtp].
///
/// Toggle [kBypassOtp] to accept any OTP (handy when you don't want to type the test code).
///
/// WARNING: This file contains a deliberate insecure bypass. Remove or replace it
/// before building/testing with real users or releasing the app.
const bool kBypassOtp = false; // set true to accept any OTP (DEV ONLY)
const String _testOtp =
    '123456'; // OTP to enter on the emulator/device for tests

abstract class IAuthService {
  /// Simulate requesting an OTP for [phone].
  Future<void> requestOtp(String phone);

  /// Simulate verifying an OTP.
  /// Returns `true` when verification succeeds.
  Future<bool> verifyOtp(String phone, String otp);
}

class AuthService implements IAuthService {
  AuthService();

  /// Simulate network latency
  Future<void> _fakeNetworkDelay() async {
    await Future.delayed(const Duration(milliseconds: 600));
  }

  /// Simulate sending the OTP. In a real app this should call an SMS API.
  @override
  Future<void> requestOtp(String phone) async {
    await _fakeNetworkDelay();

    // In a real implementation you'd call your backend here.
    // We print the test OTP to the console to make testing easy.
    if (kDebugMode) {
      // Prints to the debug console so you can copy/paste during development.
      // On a physical device, check the logs (flutter run) to see this.
      // Do NOT rely on this in production.
      debugPrint('*** [DEV] Mock OTP for $phone: $_testOtp ***');
    }
  }

  /// Simulate verifying the OTP.
  ///
  /// - If [kBypassOtp] is true, any OTP is accepted (dev-only).
  /// - Otherwise only [_testOtp] is accepted.
  @override
  Future<bool> verifyOtp(String phone, String otp) async {
    await _fakeNetworkDelay();

    if (kBypassOtp) return true;
    return otp == _testOtp;
  }
}

/// Riverpod provider for AuthService.
///
/// Replace/override this provider in tests or production with a real implementation.
final authServiceProvider = Provider<IAuthService>((ref) {
  return AuthService();
});
