import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Beneficiary Dashboard")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/capture');
              },
              child: const Text("Capture Submission"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/submissions');
              },
              child: const Text("View Submissions"),
            ),
          ],
        ),
      ),
    );
  }
}
