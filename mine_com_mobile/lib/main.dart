import 'package:flutter/material.dart';
import 'view/auth/login_screen.dart';
import 'view/auth/register_screen.dart';
import 'view/main/home_screen.dart';
import 'view/profile/profile_fragment.dart';
import 'view/servers/server_list_fragment.dart';
import 'view/settings/settings_fragment.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Auth Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
        ),
      ),
      home: const LoginScreen(),
      routes: {
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/home': (context) => const HomeScreen(),
        '/profile': (context) => const ProfileFragment(),
        '/servers': (context) => const ServerListWrapper(),
        '/settings': (context) => const SettingsFragment(),
      },
      initialRoute: '/login',
    );
  }
}
