// lib/src/ui/screens/main_page.dart
import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Main Page")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(child: Text("Welcome! Overview here.")),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, '/capture'),
            child: const Text("Go to Capture"),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, '/submissions'),
            child: const Text("View Submissions"),
          ),
        ],
      ),
    );
  }
}
