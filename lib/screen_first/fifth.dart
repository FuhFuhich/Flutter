import 'package:flutter/material.dart';
import '../main.dart';

class FifthFragment extends StatelessWidget {
  const FifthFragment({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Fragment 5')),
      body: Center(
        child: Container(
          color: Colors.deepPurple[100],
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Container with Padding and SizedBox - Fragment 5'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const FirstFragment()),
                    (route) => false),
                child: const Text('Back to Fragment 1'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
