import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class HoroscopeSectionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String content;
  final Color accentColor;

  const HoroscopeSectionCard({
    super.key,
    required this.icon,
    required this.title,
    required this.content,
    this.accentColor = AppTheme.mysticPurple,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppTheme.midnight,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: accentColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: accentColor, size: 18),
              ),
              const SizedBox(width: 10),
              Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            content,
            style: TextStyle(
              fontSize: 13.5,
              height: 1.5,
              color: Colors.white.withOpacity(0.85),
            ),
          ),
        ],
      ),
    );
  }
}
