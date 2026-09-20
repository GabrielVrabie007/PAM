import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Meniul hamburger din Figma: trei linii de 10 / 18 / 18 px, grosime 2.
class MenuIcon extends StatelessWidget {
  const MenuIcon({super.key});

  @override
  Widget build(BuildContext context) {
    Widget line(double width) => Container(
          width: width,
          height: 2,
          decoration: BoxDecoration(
            color: AppColors.textDark,
            borderRadius: BorderRadius.circular(2),
          ),
        );

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [line(10), const SizedBox(height: 6), line(18), const SizedBox(height: 7), line(18)],
    );
  }
}

/// Clopotelul cu bulina roz de notificare.
class BellIcon extends StatelessWidget {
  const BellIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 26,
      height: 26,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          const Positioned(
            left: 1,
            top: 2,
            child: Icon(Icons.notifications_none, size: 24, color: Colors.black),
          ),
          Positioned(
            right: 1,
            top: 1,
            child: Container(
              width: 7,
              height: 7,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.notificationDot,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
