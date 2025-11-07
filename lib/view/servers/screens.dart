import 'package:flutter/material.dart';

class PageHorizontalServerNavigation extends StatefulWidget {
  const PageHorizontalServerNavigation({super.key});

  @override
  State<PageHorizontalServerNavigation> createState() =>
      _PageHorizontalServerNavigationState();
}

class _PageHorizontalServerNavigationState
    extends State<PageHorizontalServerNavigation> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF141414),
      appBar: AppBar(
        backgroundColor: const Color(0xFF222222),
        title: Text('Сервер ${_currentPage + 1}'),
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentPage = index;
          });
        },
        children: const [
          ServerScreen(serverNumber: 1),
          ServerScreen(serverNumber: 2),
          ServerScreen(serverNumber: 3),
          ServerScreen(serverNumber: 4),
          ServerScreen(serverNumber: 5),
        ],
      ),
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
