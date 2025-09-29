import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../src/state/providers.dart' hide authServiceProvider;
import '../../../src/services/auth_service.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _phoneController = TextEditingController();
  final _otpController = TextEditingController();
  bool _otpSent = false;
  UserRole? _selectedRole;

  @override
  Widget build(BuildContext context) {
    final auth = ref.read(authServiceProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Role selection
            const Text("Select Role"),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: UserRole.values.map((role) {
                return Expanded(
                  child: ListTile(
                    title: Text(
                      role == UserRole.beneficiary ? "User" : "Officer",
                    ),
                    leading: Radio<UserRole>(
                      value: role,
                      groupValue: _selectedRole,
                      onChanged: (UserRole? value) {
                        setState(() {
                          _selectedRole = value;
                        });
                      },
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),

            // Phone number input
            TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(labelText: "Phone Number"),
            ),

            // OTP input (only shown after sending OTP)
            if (_otpSent)
              TextField(
                controller: _otpController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: "Enter OTP"),
              ),

            const SizedBox(height: 20),

            // Button to request or verify OTP
            ElevatedButton(
              onPressed: () async {
                if (_selectedRole == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Please select a role")),
                  );
                  return;
                }

                if (!_otpSent) {
                  await auth.requestOtp(_phoneController.text, _selectedRole!);
                  if (!mounted) return;
                  setState(() => _otpSent = true);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("OTP sent (check logs for hardcoded OTP)"),
                    ),
                  );
                } else {
                  final success = await auth.verifyOtp(
                    _phoneController.text,
                    _otpController.text,
                  );
                  if (!mounted) return;
                  if (success) {
                    // Navigate based on role
                    if (_selectedRole == UserRole.beneficiary) {
                      Navigator.pushReplacementNamed(context, '/capture');
                    } else {
                      Navigator.pushReplacementNamed(context, '/officer');
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Invalid OTP")),
                    );
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
