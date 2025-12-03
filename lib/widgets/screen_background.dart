import 'package:flutter/material.dart';
// import '../theme/app_colors.dart';

class ScreenBackground extends StatelessWidget {
  final String imageUrl;
  final Widget child;
  final List<Color>? gradientColors;
  final double overlayOpacity;

  const ScreenBackground({
    super.key,
    required this.imageUrl,
    required this.child,
    this.gradientColors,
    this.overlayOpacity = 0.45,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            imageUrl,
            fit: BoxFit.cover,
            color: Colors.black.withValues(alpha: overlayOpacity),
            colorBlendMode: BlendMode.darken,
          ),
        ),
        Positioned.fill(child: Container()),
        child,
      ],
    );
  }
}
