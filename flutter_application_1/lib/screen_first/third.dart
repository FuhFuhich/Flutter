import 'package:flutter/material.dart';
import 'fourth.dart';

class ThirdFragment extends StatelessWidget {
  const ThirdFragment({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Fragment 3')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Text inside Column - Fragment 3'),
            ElevatedButton(
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const FourthFragment())),
              child: const Text('Go to Fragment 4'),
            ),
          ],
        ),
      ),
    );
  }
}
