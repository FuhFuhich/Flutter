import 'package:flutter/material.dart';

class HorizontalServerNavigation extends StatefulWidget {
  const HorizontalServerNavigation({super.key});

  @override
  State<HorizontalServerNavigation> createState() =>
      _HorizontalServerNavigationState();
}

class _HorizontalServerNavigationState extends State<HorizontalServerNavigation> {
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
      floatingActionButton: _currentPage < 4
          ? FloatingActionButton(
              onPressed: () {
                _pageController.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
              backgroundColor: const Color(0xFF00E676),
              child: const Icon(Icons.arrow_forward, color: Colors.white),
            )
          : FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, '/vertical/1');
              },
              backgroundColor: const Color(0xFFFF9800),
              child: const Icon(Icons.grid_view, color: Colors.white),
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
  const VerticalServerScreen({super.key, required this.serverNumber});

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
              'Вертикальная маршрутизированная навигация',
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
              onPressed: () {
                Navigator.pushNamed(context, '/vertical/${serverNumber + 1}');
              },
              backgroundColor: const Color(0xFF00E676),
              child: const Icon(Icons.arrow_downward, color: Colors.white),
            )
          : FloatingActionButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/home',
                  (route) => false,
                );
              },
              backgroundColor: const Color(0xFF2196F3),
              child: const Icon(Icons.home, color: Colors.white),
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

Route<dynamic>? generateRoutes(RouteSettings settings) {
  switch (settings.name) {
    case '/vertical/1':
      return MaterialPageRoute(
        builder: (_) => const VerticalServerScreen(serverNumber: 1),
      );
    case '/vertical/2':
      return MaterialPageRoute(
        builder: (_) => const VerticalServerScreen(serverNumber: 2),
      );
    case '/vertical/3':
      return MaterialPageRoute(
        builder: (_) => const VerticalServerScreen(serverNumber: 3),
      );
    case '/vertical/4':
      return MaterialPageRoute(
        builder: (_) => const VerticalServerScreen(serverNumber: 4),
      );
    case '/vertical/5':
      return MaterialPageRoute(
        builder: (_) => const VerticalServerScreen(serverNumber: 5),
      );
    default:
      return null;
  }
}
 