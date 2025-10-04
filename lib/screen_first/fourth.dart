import 'package:flutter/material.dart';
import 'fifth.dart';

class FourthFragment extends StatefulWidget {
  const FourthFragment({super.key});

  @override
  State<FourthFragment> createState() => _FourthFragmentState();
}

class _FourthFragmentState extends State<FourthFragment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Fragment 4')),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Row in Fragment 4'),
            const SizedBox(width: 20),
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const FifthFragment()),
              ),
              child: const Text('Go to Fragment 5'),
            ),
          ],
        ),
      ),
    );
  }
}
