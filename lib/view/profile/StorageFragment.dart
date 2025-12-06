import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class NetworkFragment extends StatefulWidget {
  const NetworkFragment({super.key});

  @override
  State<NetworkFragment> createState() => _NetworkFragmentState();
}

class _NetworkFragmentState extends State<NetworkFragment> {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: 'https://jsonplaceholder.typicode.com',
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 5),
    headers: {'Content-Type': 'application/json', 'Accept': 'application/json'},
  ));

  String usersData = 'Загрузить пользователей';
  String postsData = 'Загрузить посты';
  String albumsData = 'Загрузить альбомы';
  String todosData = 'Загрузить задачи';
  String photosData = 'Загрузить фото';

  Future<void> _loadUsers() async {
    try {
      final response = await _dio.get('/users');
      setState(() {
        usersData = 'Пользователей: ${response.data.length}';
      });
    } catch (e) {
      setState(() {
        usersData = 'Ошибка загрузки пользователей';
      });
    }
  }

  Future<void> _loadPosts() async {
    try {
      final response = await _dio.get('https://jsonplaceholder.typicode.com/posts');
      setState(() {
        postsData = 'Постов: ${response.data.length}';
      });
    } catch (e) {
      setState(() {
        postsData = 'Ошибка загрузки постов';
      });
    }
  }

  Future<void> _loadAlbums() async {
    try {
      final response = await _dio.get('/albums');
      setState(() {
        albumsData = 'Альбомов: ${response.data.length}';
      });
    } catch (e) {
      setState(() {
        albumsData = 'Ошибка загрузки альбомов';
      });
    }
  }

  Future<void> _loadTodos() async {
    try {
      final response = await _dio.get('/todos');
      setState(() {
        todosData = 'Задач: ${response.data.length}';
      });
    } catch (e) {
      setState(() {
        todosData = 'Ошибка загрузки задач';
      });
    }
  }

  Future<void> _loadPhotos() async {
    try {
      final response = await _dio.get('https://jsonplaceholder.typicode.com/photos?_limit=5');
      setState(() {
        photosData = 'Фото загружено: ${response.data.length} шт.';
      });
    } catch (e) {
      setState(() {
        photosData = 'Ошибка загрузки фото';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF141414),
      appBar: AppBar(
        backgroundColor: const Color(0xFF141414),
        title: const Text('Сетевые запросы', style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildRequestCard('Пользователи (JSONPlaceholder)', usersData, _loadUsers),
                const SizedBox(height: 16),
                _buildRequestCard('Посты (JSONPlaceholder)', postsData, _loadPosts),
                const SizedBox(height: 16),
                _buildRequestCard('Альбомы (JSONPlaceholder)', albumsData, _loadAlbums),
                const SizedBox(height: 16),
                _buildRequestCard('Задачи (JSONPlaceholder)', todosData, _loadTodos),
                const SizedBox(height: 16),
                _buildRequestCard('Фото (JSONPlaceholder)', photosData, _loadPhotos),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRequestCard(String title, String data, VoidCallback onLoad) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF00E676), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(color: Color(0xFF00E676), fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 8),
          Text(
            data,
            style: const TextStyle(color: Colors.white, fontSize: 14),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onLoad,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF00E676),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: const Text(
                'Выполнить запрос',
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
