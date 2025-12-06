import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageFragment extends StatefulWidget {
  const StorageFragment({super.key});

  @override
  State<StorageFragment> createState() => _StorageFragmentState();
}

class _StorageFragmentState extends State<StorageFragment> {
  String storage1 = 'Нет данных';
  String storage2 = 'Нет данных';
  late SharedPreferences prefs;
  final secureStorage = const FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    _initStorage();
  }

  Future<void> _initStorage() async {
    prefs = await SharedPreferences.getInstance();
    _loadData();
  }

  void _loadData() {
    setState(() {
      storage1 = prefs.getString('shared_pref_data') ?? 'Нет данных';
    });
    _loadSecureData();
  }

  Future<void> _loadSecureData() async {
    final data = await secureStorage.read(key: 'secure_data');
    setState(() {
      storage2 = data ?? 'Нет данных';
    });
  }

  Future<void> _saveToStorage1() async {
    final timestamp = DateTime.now().toIso8601String();
    await prefs.setString('shared_pref_data', 'SharedPreferences: $timestamp');
    _loadData();
  }

  Future<void> _saveToStorage2() async {
    final timestamp = DateTime.now().toIso8601String();
    await secureStorage.write(key: 'secure_data', value: 'FlutterSecureStorage: $timestamp');
    _loadSecureData();
  }

  Future<void> _clearStorage1() async {
    await prefs.remove('shared_pref_data');
    _loadData();
  }

  Future<void> _clearStorage2() async {
    await secureStorage.delete(key: 'secure_data');
    _loadSecureData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF141414),
      appBar: AppBar(
        backgroundColor: const Color(0xFF141414),
        title: const Text('Локальное хранилище', style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'SharedPreferences:',
                style: const TextStyle(color: Color(0xFF00E676), fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                storage1,
                style: const TextStyle(color: Colors.white, fontSize: 14),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: _saveToStorage1,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00E676),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: const Text(
                  'Сохранить в SharedPreferences',
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 12),
                ),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: _clearStorage1,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFBBBBBB),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: const Text(
                  'Очистить SharedPreferences',
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 12),
                ),
              ),
              const SizedBox(height: 32),
              Text(
                'FlutterSecureStorage:',
                style: const TextStyle(color: Color(0xFF00E676), fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                storage2,
                style: const TextStyle(color: Colors.white, fontSize: 14),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: _saveToStorage2,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00E676),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: const Text(
                  'Сохранить в SecureStorage',
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 12),
                ),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: _clearStorage2,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFBBBBBB),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: const Text(
                  'Очистить SecureStorage',
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
