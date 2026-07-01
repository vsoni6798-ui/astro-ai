import 'package:flutter/material.dart';

enum Element { fire, earth, air, water }

class ZodiacSign {
  final String name;
  final String symbol; // unicode glyph
  final DateTime startDate; // year is a dummy placeholder (2000)
  final DateTime endDate;
  final Element element;
  final String rulingPlanet;
  final List<String> traits;
  final String description;
  final Color primaryColor;
  final Color secondaryColor;

  const ZodiacSign({
    required this.name,
    required this.symbol,
    required this.startDate,
    required this.endDate,
    required this.element,
    required this.rulingPlanet,
    required this.traits,
    required this.description,
    required this.primaryColor,
    required this.secondaryColor,
  });

  String get elementLabel {
    switch (element) {
      case Element.fire:
        return 'Fire';
      case Element.earth:
        return 'Earth';
      case Element.air:
        return 'Air';
      case Element.water:
        return 'Water';
    }
  }

  String get dateRangeLabel {
    final fmt = (DateTime d) => '${_month(d.month)} ${d.day}';
    return '${fmt(startDate)} - ${fmt(endDate)}';
  }

  static String _month(int m) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return months[m - 1];
  }
}
