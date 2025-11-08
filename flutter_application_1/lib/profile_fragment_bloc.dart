import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Cubit для управления индексом аватара
class UserDataCubit extends Cubit<int> {
  final List<String> imageUrls;

  UserDataCubit({required this.imageUrls}) : super(0);

  void changeImage() {
    emit((state + 1) % imageUrls.length);
  }
}

class ProfileFragment extends StatelessWidget {
  final String name;
  final String email;

  const ProfileFragment({super.key, required this.name, required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF141414),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const ProfileAvatarWidget(),
              const SizedBox(height: 16),
              Text(
                name,
                style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                email,
                style: const TextStyle(color: Color(0xFFBBBBBB)),
              ),
              const SizedBox(height: 32),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF222222),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFF404040)),
                ),
                child: ListTile(
                  leading: const Icon(Icons.info_outline, color: Color(0xFF00E676)),
                  title: const Text('Информация профиля', style: TextStyle(color: Colors.white)),
                  subtitle: const Text('Статистика, серверы, активность',
                      style: TextStyle(color: Color(0xFFBBBBBB))),
                  onTap: () {},
                ),
              ),
              const SizedBox(height: 20),
              const LogoutButtonWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

// Аватарка подписывается на Cubit
class ProfileAvatarWidget extends StatelessWidget {
  const ProfileAvatarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<UserDataCubit>();

    return CircleAvatar(
      radius: 50,
      backgroundColor: const Color(0xFF00E676),
      child: ClipOval(
        child: CachedNetworkImage(
          imageUrl: cubit.imageUrls[cubit.state],
          width: 100,
          height: 100,
          fit: BoxFit.cover,
          placeholder: (context, url) => const CircularProgressIndicator(color: Colors.white),
          errorWidget: (context, url, error) => const Icon(Icons.person, size: 60, color: Colors.white),
        ),
      ),
    );
  }
}

// Кнопка для смены аватара (выхода из аккаунта)
class LogoutButtonWidget extends StatelessWidget {
  const LogoutButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<UserDataCubit>();

    return Container(
      width: double.infinity,
      height: 48,
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFF00E676), Color(0xFF00C853)]),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ElevatedButton(
        onPressed: cubit.changeImage,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        child: const Text(
          'Выйти из аккаунта',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
