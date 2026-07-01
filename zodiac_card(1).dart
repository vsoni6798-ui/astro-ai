import 'package:flutter/material.dart';
import '../models/zodiac_sign.dart';

class ZodiacCard extends StatelessWidget {
  final ZodiacSign sign;
  final VoidCallback onTap;
  final bool selected;

  const ZodiacCard({
    super.key,
    required this.sign,
    required this.onTap,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 8),
        decoration: BoxDecoration(
          color: sign.primaryColor.withOpacity(selected ? 0.35 : 0.15),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: selected ? sign.primaryColor : Colors.transparent,
            width: 2,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(sign.symbol, style: TextStyle(fontSize: 32, color: sign.primaryColor)),
            const SizedBox(height: 6),
            Text(
              sign.name,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
            ),
            Text(
              sign.dateRangeLabel,
              style: TextStyle(fontSize: 10, color: Colors.white.withOpacity(0.6)),
            ),
          ],
        ),
      ),
    );
  }
}
