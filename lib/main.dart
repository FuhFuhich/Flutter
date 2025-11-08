import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'profile_fragment_bloc.dart';

class UserData {
  final String name;
  final String email;
  final List<String> imageUrls;

  UserData({
    required this.name,
    required this.email,
    required this.imageUrls,
  });
}

void main() {
  final userData = UserData(
    name: 'Имя пользователя',
    email: 'email@example.com',
    imageUrls: [
      'https://fastly.picsum.photos/id/1054/200/200.jpg?hmac=7qtHUdgOyKxMVpcUELySqbknGm7xI76LbA9CE0uag_o',
      'https://fastly.picsum.photos/id/1002/200/200.jpg?hmac=Tf8HIQ9ThNr5_OQwJQuQXmZ4JysJ2pdFOx0bjdHTc-g',
      'https://fastly.picsum.photos/id/937/200/200.jpg?hmac=8ePB28CQ2kANO2nsqXZ4GA-tQ6YTCG1MgZBnDsimIdQ',
      'https://fastly.picsum.photos/id/842/200/200.jpg?hmac=RW9iEgAYLKwoinQWSz_zrZHyOwmVEgqvoZTPebkRGMM',
      'https://fastly.picsum.photos/id/1009/200/200.jpg?hmac=2D10SFaYliFjzL4jp_ZjLmZ1_2jaJw89CntiJGjdlGE',
    ],
  );

  runApp(MyApp(userData: userData));
}

class MyApp extends StatelessWidget {
  final UserData userData;

  const MyApp({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Auth Demo with Bloc',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
        inputDecorationTheme: const InputDecorationTheme(border: OutlineInputBorder()),
      ),
      home: BlocProvider(
        create: (_) => UserDataCubit(imageUrls: userData.imageUrls),
        child: ProfileFragment(
          name: userData.name,
          email: userData.email,
        ),
      ),
    );
  }
}

