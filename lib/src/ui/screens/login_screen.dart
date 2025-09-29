import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../src/state/providers.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _phoneController = TextEditingController();
  final _otpController = TextEditingController();
  bool _otpSent = false;

  @override
  Widget build(BuildContext context) {
    final auth = ref.read(authServiceProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _phoneController,
              decoration: const InputDecoration(labelText: "Phone Number"),
            ),
            if (_otpSent)
              TextField(
                controller: _otpController,
                decoration: const InputDecoration(labelText: "Enter OTP"),
              ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (!_otpSent) {
                  await auth.requestOtp(_phoneController.text);
                  if (!mounted) return;
                  setState(() => _otpSent = true);
                } else {
                  final success = await auth.verifyOtp(
                    _phoneController.text,
                    _otpController.text,
                  );

                  if (!mounted) {
                    return; // ✅ keep check right before using context
                  }

                  if (success) {
                    Navigator.pushReplacementNamed(context, '/capture');
                  }
                }
              },
              child: Text(_otpSent ? "Verify OTP" : "Request OTP"),
            ),
          ],
        ),
      ),
    );
  }
}
