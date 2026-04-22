import 'package:flutter/material.dart';
import 'package:graduation_project/Core/TextStyles/TextStyles.dart';

class VideoContainer extends StatelessWidget {
  const VideoContainer({super.key, this.mediaUrl});

  final String? mediaUrl;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 250 / 150,
      child: Container(
        width: 250,
        height: 150,
        margin: EdgeInsets.symmetric(horizontal: 40),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Color(0xffEAEAFA),
        ),
        child: _buildContent(),
      ),
    );
  }

  Widget _buildContent() {
    if (mediaUrl != null && mediaUrl!.isNotEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.network(
          mediaUrl!,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Center(
              child: CircularProgressIndicator(
                color: Color(0xffADADEB),
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                    : null,
              ),
            );
          },
          errorBuilder: (_, __, ___) => _placeholder(),
        ),
      );
    }
    return _placeholder();
  }

  Widget _placeholder() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(size: 42, Icons.image_outlined, color: Color(0xffADADEB)),
        SizedBox(height: 10),
        Text("No media", style: Textstyles.bold13),
      ],
    );
  }
}
