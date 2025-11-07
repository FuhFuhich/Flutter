import 'package:flutter/material.dart';

class RouteHorizontalServerNavigation extends StatelessWidget {
  final int serverNumber;
  const RouteHorizontalServerNavigation({super.key, this.serverNumber = 1});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF141414),
      appBar: AppBar(
        backgroundColor: const Color(0xFF222222),
        title: Text('Сервер $serverNumber'),
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Text(
          'Сервер$serverNumber',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      floatingActionButton: serverNumber < 5
          ? FloatingActionButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => RouteHorizontalServerNavigation(
                    serverNumber: serverNumber + 1,
                  ),
                ));
              },
              backgroundColor: const Color(0xFF00E676),
              child: const Icon(Icons.arrow_forward, color: Colors.white),
            )
          : FloatingActionButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              backgroundColor: const Color(0xFF2196F3),
              child: const Icon(Icons.home, color: Colors.white),
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

class ServerScreen extends StatelessWidget {
  final int serverNumber;
  const ServerScreen({super.key, required this.serverNumber});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Сервер$serverNumber',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 32,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class VerticalServerScreen extends StatelessWidget {
  final int serverNumber;
  final VoidCallback? onNext;
  final VoidCallback? onFinish;

  const VerticalServerScreen(
      {super.key, required this.serverNumber, this.onNext, this.onFinish});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF141414),
      appBar: AppBar(
        backgroundColor: const Color(0xFF222222),
        title: Text('Сервер $serverNumber'),
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Сервер$serverNumber',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Делегат навигации',
              style: TextStyle(
                color: Color(0xFFBBBBBB),
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: serverNumber < 5
          ? FloatingActionButton(
              onPressed: onNext,
              backgroundColor: const Color(0xFF00E676),
              child: const Icon(Icons.arrow_downward, color: Colors.white),
            )
          : FloatingActionButton(
              onPressed: onFinish,
              backgroundColor: const Color(0xFF2196F3),
              child: const Icon(Icons.home, color: Colors.white),
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

class VerticalNavigationDelegate extends StatefulWidget {
  final int start;
  const VerticalNavigationDelegate({super.key, required this.start});

  @override
  State<VerticalNavigationDelegate> createState() =>
      _VerticalNavigationDelegateState();
}

class _VerticalNavigationDelegateState extends State<VerticalNavigationDelegate> {
  int page = 1;

  void nextPage() {
    setState(() {
      page += 1;
    });
  }

  void finish() {
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    return VerticalServerScreen(
      serverNumber: page,
      onNext: page < 5 ? nextPage : null,
      onFinish: page == 5 ? finish : null,
    );
  }
}
