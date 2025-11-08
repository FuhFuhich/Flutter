import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

class UserDataService extends ChangeNotifier {
  final List<String> imageUrls;
  int _currentImageIndex = 0;

  UserDataService({required this.imageUrls});

  int get currentImageIndex => _currentImageIndex;

  void changeImage() {
    _currentImageIndex = (_currentImageIndex + 1) % imageUrls.length;
    notifyListeners();
  }
}

class ProfileFragmentGetIt extends StatefulWidget {
  const ProfileFragmentGetIt({super.key});

  @override
  State<ProfileFragmentGetIt> createState() => _ProfileFragmentGetItState();
}

class _ProfileFragmentGetItState extends State<ProfileFragmentGetIt> {
  final List<String> _imageUrls = [
    'https://fastly.picsum.photos/id/1054/200/200.jpg?hmac=7qtHUdgOyKxMVpcUELySqbknGm7xI76LbA9CE0uag_o',
    'https://fastly.picsum.photos/id/1002/200/200.jpg?hmac=Tf8HIQ9ThNr5_OQwJQuQXmZ4JysJ2pdFOx0bjdHTc-g',
    'https://fastly.picsum.photos/id/937/200/200.jpg?hmac=8ePB28CQ2kANO2nsqXZ4GA-tQ6YTCG1MgZBnDsimIdQ',
    'https://fastly.picsum.photos/id/842/200/200.jpg?hmac=RW9iEgAYLKwoinQWSz_zrZHyOwmVEgqvoZTPebkRGMM',
    'https://fastly.picsum.photos/id/1009/200/200.jpg?hmac=2D10SFaYliFjzL4jp_ZjLmZ1_2jaJw89CntiJGjdlGE',
  ];

  late UserDataService _userDataService;

  @override
  void initState() {
    super.initState();
    // Register UserDataService in GetIt if not already registered
    if (!getIt.isRegistered<UserDataService>()) {
      _userDataService = UserDataService(imageUrls: _imageUrls);
      getIt.registerSingleton<UserDataService>(_userDataService);
    } else {
      _userDataService = getIt.get<UserDataService>();
    }
  }

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
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class _ProfileAvatarWidget extends StatefulWidget {
  const _ProfileAvatarWidget();

  @override
  State<_ProfileAvatarWidget> createState() => _ProfileAvatarWidgetState();
}

class _ProfileAvatarWidgetState extends State<_ProfileAvatarWidget> {
  late UserDataService _userDataService;

  @override
  void initState() {
    super.initState();
    _userDataService = getIt.get<UserDataService>();
    _userDataService.addListener(_onUserDataChanged);
  }

  void _onUserDataChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 50,
      backgroundColor: const Color(0xFF00E676),
      child: ClipOval(
        child: CachedNetworkImage(
          imageUrl:
              _userDataService.imageUrls[_userDataService.currentImageIndex],
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

  @override
  void dispose() {
    _userDataService.removeListener(_onUserDataChanged);
    super.dispose();
  }
}

class _ProfileNameWidget extends StatelessWidget {
  const _ProfileNameWidget();

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Имя пользователя',
      style: TextStyle(
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
    return const Text(
      'email@example.com',
      style: TextStyle(color: Color(0xFFBBBBBB)),
    );
  }
}

class _LogoutButtonWidget extends StatelessWidget {
  const _LogoutButtonWidget();

  @override
  Widget build(BuildContext context) {
    final userDataService = getIt.get<UserDataService>();
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
        onPressed: userDataService.changeImage,
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
