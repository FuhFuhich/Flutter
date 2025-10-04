import 'package:flutter/material.dart';
import 'third.dart';

class SecondFragment extends StatelessWidget {
  const SecondFragment({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Fragment 2')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Fragment 2 using Column'),
          ElevatedButton(
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ThirdFragment())),
            child: const Text('Go to Fragment 3'),
          ),
        ],
      ),
    );
  }
}
