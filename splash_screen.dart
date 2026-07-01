import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/user_provider.dart';
import '../widgets/star_background.dart';
import '../theme/app_theme.dart';
import 'onboarding_screen.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _bootstrap();
  }

  Future<void> _bootstrap() async {
    final userProvider = context.read<UserProvider>();
    await userProvider.load();
    await Future.delayed(const Duration(milliseconds: 900));
    if (!mounted) return;

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) =>
            userProvider.hasProfile ? const HomeScreen() : const OnboardingScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StarBackground(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('🔮', style: TextStyle(fontSize: 64)),
              const SizedBox(height: 16),
              Text(
                'Astrology & Horoscope',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: Colors.white.withOpacity(0.95),
                ),
              ),
              const SizedBox(height: 24),
              const CircularProgressIndicator(color: AppTheme.starGold),
            ],
          ),
        ),
      ),
    );
  }
}
