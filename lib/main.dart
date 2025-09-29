import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'src/ui/screens/login_screen.dart';
import 'src/ui/screens/capture_screen.dart';
import 'src/ui/screens/submissions_list.dart';

void main() {
  runApp(const ProviderScope(child: LoanUtilApp()));
}

class LoanUtilApp extends StatelessWidget {
  const LoanUtilApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Loan Utilization App',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        '/capture': (context) => const CaptureScreen(),
        '/submissions': (context) => SubmissionsListScreen(submissions: []), // Pass empty list initially
      },
    );
  }
}
