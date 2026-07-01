import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'services/user_provider.dart';
import 'services/notification_service.dart';
import 'theme/app_theme.dart';
import 'screens/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.init();
  runApp(const AstrologyApp());
}

class AstrologyApp extends StatelessWidget {
  const AstrologyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UserProvider(),
      child: MaterialApp(
        title: 'Astrology & Horoscope',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.darkTheme,
        home: const SplashScreen(),
      ),
    );
  }
}
