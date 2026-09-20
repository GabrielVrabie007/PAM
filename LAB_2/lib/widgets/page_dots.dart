import 'package:flutter/material.dart';

/// Indicatorul de pagina din Figma: cerc conturat cu punct plin pentru pagina
/// curenta, doua puncte mici pentru restul.
class PageDots extends StatelessWidget {
  final Color color;

  const PageDots({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 11,
          height: 11,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: color),
          ),
          child: _dot(6),
        ),
        const SizedBox(width: 10),
        _dot(5),
        const SizedBox(width: 11),
        _dot(5),
      ],
    );
  }

  Widget _dot(double size) => Container(
        width: size,
        height: size,
        decoration: BoxDecoration(shape: BoxShape.circle, color: color),
      );
}
