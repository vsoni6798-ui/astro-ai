import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// Wraps a screen body in the app's signature deep-space gradient.
class StarBackground extends StatelessWidget {
  final Widget child;
  const StarBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: AppTheme.backgroundGradient),
      child: child,
    );
  }
}
