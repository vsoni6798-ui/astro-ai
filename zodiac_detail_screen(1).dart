import 'package:flutter/material.dart';
import '../models/zodiac_sign.dart';
import '../widgets/star_background.dart';
import '../theme/app_theme.dart';

class ZodiacDetailScreen extends StatelessWidget {
  final ZodiacSign sign;
  const ZodiacDetailScreen({super.key, required this.sign});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StarBackground(
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
              Center(
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: sign.primaryColor.withOpacity(0.25),
                    border: Border.all(color: sign.primaryColor, width: 2),
                  ),
                  child: Center(
                    child: Text(sign.symbol,
                        style: TextStyle(fontSize: 46, color: sign.primaryColor)),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: Text(sign.name,
                    style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
              ),
              Center(
                child: Text(sign.dateRangeLabel,
                    style: const TextStyle(color: Colors.white60)),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(child: _infoChip('Element', sign.elementLabel)),
                  const SizedBox(width: 10),
                  Expanded(child: _infoChip('Ruling Planet', sign.rulingPlanet)),
                ],
              ),
              const SizedBox(height: 20),
              const Text('Personality', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
              const SizedBox(height: 10),
              Text(sign.description,
                  style: TextStyle(color: Colors.white.withOpacity(0.85), height: 1.6)),
              const SizedBox(height: 20),
              const Text('Key Traits', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: sign.traits
                    .map((t) => Chip(
                          label: Text(t),
                          backgroundColor: sign.primaryColor.withOpacity(0.2),
                          side: BorderSide.none,
                        ))
                    .toList(),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoChip(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
      decoration: BoxDecoration(
        color: AppTheme.midnight,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          Text(label, style: const TextStyle(fontSize: 11, color: Colors.white54)),
          const SizedBox(height: 4),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
