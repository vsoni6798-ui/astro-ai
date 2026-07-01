import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/user_provider.dart';
import '../data/zodiac_data.dart';
import '../widgets/star_background.dart';
import '../theme/app_theme.dart';

/// Simplified natal chart view.
///
/// PRODUCTION NOTE: A true natal chart needs birth TIME and LOCATION (not
/// just date) to calculate rising sign, houses, and precise planetary
/// positions — this requires an ephemeris calculation (e.g. the Swiss
/// Ephemeris library) or a third-party astrology API. This screen shows a
/// simplified sun-sign-based breakdown ("Big Three" placeholders) and is a
/// good place to wire in a real ephemeris service later.
class BirthChartScreen extends StatelessWidget {
  const BirthChartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>();
    final sunSign = user.zodiacSign;

    // Simplified placeholder logic for moon/rising until a real ephemeris
    // is wired in — offsets the sun sign around the wheel deterministically
    // based on birth date so it's stable, not random on every view.
    final seed = user.birthDate?.day ?? 1;
    final moonSign = ZodiacData.signs[(ZodiacData.signs.indexOf(sunSign) + seed) % 12];
    final risingSign = ZodiacData.signs[(ZodiacData.signs.indexOf(sunSign) + seed * 2) % 12];

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
                  const Text('Your Birth Chart',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 10),
              Center(
                child: SizedBox(
                  width: 220,
                  height: 220,
                  child: CustomPaint(
                    painter: _WheelPainter(),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(sunSign.symbol,
                              style: TextStyle(fontSize: 44, color: sunSign.primaryColor)),
                          Text(sunSign.name,
                              style: const TextStyle(fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              const Text('Your Big Three', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              const SizedBox(height: 12),
              _placementCard('☀️ Sun Sign', sunSign.name,
                  'Your core identity, ego, and how you shine. This is your primary zodiac sign, based on your birth date.'),
              _placementCard('🌙 Moon Sign', moonSign.name,
                  'Your emotional inner world — how you process feelings and what makes you feel secure.'),
              _placementCard('⬆️ Rising Sign', risingSign.name,
                  'The mask you show the world first — your instinctive reactions and outward style.'),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppTheme.midnight,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.info_outline, color: AppTheme.starGold, size: 20),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'For a fully precise chart, add your birth time and location in Edit Profile. Moon and Rising signs shown here are simplified estimates.',
                        style: TextStyle(fontSize: 12, color: Colors.white.withOpacity(0.7)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _placementCard(String label, String signName, String description) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.midnight,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
              const Spacer(),
              Text(signName, style: const TextStyle(color: AppTheme.starGold, fontWeight: FontWeight.w600)),
            ],
          ),
          const SizedBox(height: 6),
          Text(description, style: TextStyle(fontSize: 12.5, color: Colors.white.withOpacity(0.7), height: 1.4)),
        ],
      ),
    );
  }
}

/// Draws a simple two-ring zodiac wheel with 12 spokes as a visual backdrop
/// for the Sun/Moon/Rising summary above.
class _WheelPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    final outerRing = Paint()
      ..color = AppTheme.mysticPurple.withOpacity(0.4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    final innerRing = Paint()
      ..color = AppTheme.mysticPurple.withOpacity(0.25)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    final spokePaint = Paint()
      ..color = AppTheme.mysticPurple.withOpacity(0.2)
      ..strokeWidth = 1;

    canvas.drawCircle(center, radius, outerRing);
    canvas.drawCircle(center, radius * 0.75, innerRing);

    for (int i = 0; i < 12; i++) {
      final angle = (i * 30) * math.pi / 180;
      final dx = center.dx + radius * math.cos(angle);
      final dy = center.dy + radius * math.sin(angle);
      canvas.drawLine(center, Offset(dx, dy), spokePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
