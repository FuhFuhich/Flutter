import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class UserDataProvider extends InheritedWidget {
  final String name;
  final String email;
  final List<String> imageUrls;
  final int currentImageIndex;
  final VoidCallback onImageChange;

  const UserDataProvider({
    required this.name,
    required this.email,
    required this.imageUrls,
    required this.currentImageIndex,
    required this.onImageChange,
    required super.child, 
  });

  static UserDataProvider of(BuildContext context) {
    final result = context.dependOnInheritedWidgetOfExactType<UserDataProvider>();
    assert(result != null, 'No UserDataProvider found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(UserDataProvider oldWidget) {
    return oldWidget.currentImageIndex != currentImageIndex ||
        oldWidget.name != name ||
        oldWidget.email != email;
  }
}

class ProfileFragmentInherited extends StatefulWidget {
  const ProfileFragmentInherited({super.key});

  @override
  State<ProfileFragmentInherited> createState() =>
      _ProfileFragmentInheritedState();
}

class _ProfileFragmentInheritedState extends State<ProfileFragmentInherited> {
  final List<String> _imageUrls = [
    'https://fastly.picsum.photos/id/1054/200/200.jpg?hmac=7qtHUdgOyKxMVpcUELySqbknGm7xI76LbA9CE0uag_o',
    'https://fastly.picsum.photos/id/1002/200/200.jpg?hmac=Tf8HIQ9ThNr5_OQwJQuQXmZ4JysJ2pdFOx0bjdHTc-g',
    'https://fastly.picsum.photos/id/937/200/200.jpg?hmac=8ePB28CQ2kANO2nsqXZ4GA-tQ6YTCG1MgZBnDsimIdQ',
    'https://fastly.picsum.photos/id/842/200/200.jpg?hmac=RW9iEgAYLKwoinQWSz_zrZHyOwmVEgqvoZTPebkRGMM',
    'https://fastly.picsum.photos/id/1009/200/200.jpg?hmac=2D10SFaYliFjzL4jp_ZjLmZ1_2jaJw89CntiJGjdlGE',
  ];

  int _currentImageIndex = 0;

  void _changeImage() {
    setState(() {
      _currentImageIndex = (_currentImageIndex + 1) % _imageUrls.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return UserDataProvider(
      name: 'Имя пользователя',
      email: 'email@example.com',
      imageUrls: _imageUrls,
      currentImageIndex: _currentImageIndex,
      onImageChange: _changeImage,
      child: Scaffold(
        backgroundColor: const Color(0xFF141414),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const _ProfileAvatarWidget(),
                const SizedBox(height: 16),
                const _ProfileNameWidget(),
                const SizedBox(height: 8),
                const _ProfileEmailWidget(),
                const SizedBox(height: 32),
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF222222),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFF404040)),
                  ),
                  child: ListTile(
                    leading: const Icon(Icons.info_outline,
                        color: Color(0xFF00E676)),
                    title: const Text(
                      'Информация профиля',
                      style: TextStyle(color: Colors.white),
                    ),
                    subtitle: const Text('Статистика, серверы, активность',
                        style: TextStyle(color: Color(0xFFBBBBBB))),
                    onTap: () {},
                  ),
                ),
                const SizedBox(height: 20),
                const _LogoutButtonWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ProfileAvatarWidget extends StatelessWidget {
  const _ProfileAvatarWidget();

  @override
  Widget build(BuildContext context) {
    final provider = UserDataProvider.of(context);
    return CircleAvatar(
      radius: 50,
      backgroundColor: const Color(0xFF00E676),
      child: ClipOval(
        child: CachedNetworkImage(
          imageUrl: provider.imageUrls[provider.currentImageIndex],
          width: 100,
          height: 100,
          fit: BoxFit.cover,
          placeholder: (context, url) => const CircularProgressIndicator(
            color: Colors.white,
          ),
          errorWidget: (context, url, error) => const Icon(
            Icons.person,
            size: 60,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class _ProfileNameWidget extends StatelessWidget {
  const _ProfileNameWidget();

  @override
  Widget build(BuildContext context) {
    final provider = UserDataProvider.of(context);
    return Text(
      provider.name,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class _ProfileEmailWidget extends StatelessWidget {
  const _ProfileEmailWidget();

  @override
  Widget build(BuildContext context) {
    final provider = UserDataProvider.of(context);
    return Text(
      provider.email,
      style: const TextStyle(color: Color(0xFFBBBBBB)),
    );
  }
}

class _LogoutButtonWidget extends StatelessWidget {
  const _LogoutButtonWidget();

  @override
  Widget build(BuildContext context) {
    final provider = UserDataProvider.of(context);
    return Container(
      width: double.infinity,
      height: 48,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF00E676), Color(0xFF00C853)],
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ElevatedButton(
        onPressed: provider.onImageChange,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Text(
          'Выйти из аккаунта',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
