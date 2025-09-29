import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'src/ui/screens/login_screen.dart';
import 'src/ui/screens/main_screen.dart';
import 'src/ui/screens/capture_screen.dart';
import 'src/ui/screens/officer_screen.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Loan Utility App',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/main': (context) => const MainScreen(),
        '/capture': (context) => const CaptureScreen(),
        '/officer': (context) => const OfficerScreen(),
      },
    );
  }
}
