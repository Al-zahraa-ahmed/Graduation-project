import 'package:flutter/material.dart';
import 'package:graduation_project/Core/TextStyles/TextStyles.dart';

class ProfileContainer extends StatelessWidget {
  const ProfileContainer({
    super.key,
    this.username,
    required this.email,
    this.imgUrl,
  });
  final String? username, email, imgUrl;

  bool get _hasNetworkImg =>
      imgUrl != null &&
      imgUrl!.isNotEmpty &&
      !imgUrl!.contains('default-user');

  Widget _avatar() {
    const double diameter = 60;
    const asset = AssetImage("Assets/images/Ellipse 4.png");
    if (!_hasNetworkImg) {
      return const CircleAvatar(radius: 30, backgroundImage: asset);
    }
    return ClipOval(
      child: SizedBox(
        width: diameter,
        height: diameter,
        child: Image.network(
          imgUrl!,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, progress) {
            if (progress == null) return child;
            return const CircleAvatar(radius: 30, backgroundImage: asset);
          },
          errorBuilder: (context, error, stack) => Image.asset(
            'Assets/images/Ellipse 4.png',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 102,
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          _avatar(),
          const SizedBox(width: 16),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(username ?? "usename", style: Textstyles.medium20),
              const SizedBox(height: 4),
              Text(
                email!,
                style: Textstyles.regular13.copyWith(
                  color: const Color(0xff999999),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
