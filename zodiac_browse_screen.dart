import 'package:flutter/material.dart';
import '../data/zodiac_data.dart';
import '../widgets/star_background.dart';
import '../widgets/zodiac_card.dart';
import 'zodiac_detail_screen.dart';

class ZodiacBrowseScreen extends StatelessWidget {
  const ZodiacBrowseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StarBackground(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(20, 16, 20, 8),
                child: Text(
                  'Explore the Zodiac',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Tap a sign to see its traits, element, and personality.',
                  style: TextStyle(color: Colors.white70, fontSize: 13),
                ),
              ),
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(20),
                  itemCount: ZodiacData.signs.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 14,
                    crossAxisSpacing: 14,
                    childAspectRatio: 0.85,
                  ),
                  itemBuilder: (context, i) {
                    final sign = ZodiacData.signs[i];
                    return ZodiacCard(
                      sign: sign,
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => ZodiacDetailScreen(sign: sign),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
