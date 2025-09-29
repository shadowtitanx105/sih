import 'package:flutter/material.dart';

class OfficerScreen extends StatelessWidget {
  const OfficerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Officer Dashboard")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [Text("Officer-specific features go here")],
        ),
      ),
    );
  }
}
