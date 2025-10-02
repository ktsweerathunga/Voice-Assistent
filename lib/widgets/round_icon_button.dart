import 'package:flutter/material.dart';
import 'package:voice_assistent/color_palete.dart';

class RoundIconButton extends StatelessWidget {
  final VoidCallback onTap;
  final List<Color> gradient;
  final IconData icon;

  const RoundIconButton({
    super.key,
    required this.onTap,
    required this.gradient,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: gradient),
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: gradient.first.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Icon(
          icon,
          color: ColorPalette.whiteColor,
          size: 24,
        ),
      ),
    );
  }
}