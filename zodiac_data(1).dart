import 'package:flutter/material.dart';
import '../models/zodiac_sign.dart';

/// All 12 zodiac signs with their date ranges, traits, and theme colors.
/// Year in start/end dates is a placeholder (2000) — only month/day matter.
class ZodiacData {
  static const List<ZodiacSign> signs = [
    ZodiacSign(
      name: 'Aries',
      symbol: '♈',
      startDate: DateTime(2000, 3, 21),
      endDate: DateTime(2000, 4, 19),
      element: Element.fire,
      rulingPlanet: 'Mars',
      traits: ['Bold', 'Energetic', 'Competitive', 'Impulsive'],
      description:
          'Aries is the first sign of the zodiac, known for its pioneering spirit, courage, and drive. Ruled by Mars, Aries individuals are natural leaders who love a challenge.',
      primaryColor: Color(0xFFE53935),
      secondaryColor: Color(0xFFFFCDD2),
    ),
    ZodiacSign(
      name: 'Taurus',
      symbol: '♉',
      startDate: DateTime(2000, 4, 20),
      endDate: DateTime(2000, 5, 20),
      element: Element.earth,
      rulingPlanet: 'Venus',
      traits: ['Reliable', 'Patient', 'Practical', 'Stubborn'],
      description:
          'Taurus is grounded, sensual, and deeply connected to comfort and stability. Ruled by Venus, Taureans value loyalty, beauty, and the finer things in life.',
      primaryColor: Color(0xFF43A047),
      secondaryColor: Color(0xFFC8E6C9),
    ),
    ZodiacSign(
      name: 'Gemini',
      symbol: '♊',
      startDate: DateTime(2000, 5, 21),
      endDate: DateTime(2000, 6, 20),
      element: Element.air,
      rulingPlanet: 'Mercury',
      traits: ['Curious', 'Witty', 'Adaptable', 'Restless'],
      description:
          'Gemini is the communicator of the zodiac — quick-witted, curious, and endlessly adaptable. Ruled by Mercury, Geminis thrive on ideas, conversation, and variety.',
      primaryColor: Color(0xFFFDD835),
      secondaryColor: Color(0xFFFFF9C4),
    ),
    ZodiacSign(
      name: 'Cancer',
      symbol: '♋',
      startDate: DateTime(2000, 6, 21),
      endDate: DateTime(2000, 7, 22),
      element: Element.water,
      rulingPlanet: 'Moon',
      traits: ['Nurturing', 'Intuitive', 'Loyal', 'Moody'],
      description:
          'Cancer is deeply emotional and intuitive, ruled by the Moon. Known for their nurturing nature, Cancers protect the people and things they love with fierce loyalty.',
      primaryColor: Color(0xFF7986CB),
      secondaryColor: Color(0xFFC5CAE9),
    ),
    ZodiacSign(
      name: 'Leo',
      symbol: '♌',
      startDate: DateTime(2000, 7, 23),
      endDate: DateTime(2000, 8, 22),
      element: Element.fire,
      rulingPlanet: 'Sun',
      traits: ['Confident', 'Generous', 'Dramatic', 'Proud'],
      description:
          'Leo radiates warmth and charisma, ruled by the Sun itself. Natural performers and leaders, Leos love to inspire others and be celebrated for their generosity.',
      primaryColor: Color(0xFFFB8C00),
      secondaryColor: Color(0xFFFFE0B2),
    ),
    ZodiacSign(
      name: 'Virgo',
      symbol: '♍',
      startDate: DateTime(2000, 8, 23),
      endDate: DateTime(2000, 9, 22),
      element: Element.earth,
      rulingPlanet: 'Mercury',
      traits: ['Analytical', 'Detail-oriented', 'Modest', 'Critical'],
      description:
          'Virgo is precise, practical, and deeply committed to improvement. Ruled by Mercury, Virgos bring clarity and care to everything they touch.',
      primaryColor: Color(0xFF8D6E63),
      secondaryColor: Color(0xFFD7CCC8),
    ),
    ZodiacSign(
      name: 'Libra',
      symbol: '♎',
      startDate: DateTime(2000, 9, 23),
      endDate: DateTime(2000, 10, 22),
      element: Element.air,
      rulingPlanet: 'Venus',
      traits: ['Diplomatic', 'Charming', 'Fair-minded', 'Indecisive'],
      description:
          'Libra seeks harmony, balance, and beauty in all things. Ruled by Venus, Libras are natural diplomats with a strong sense of fairness and partnership.',
      primaryColor: Color(0xFFEC407A),
      secondaryColor: Color(0xFFF8BBD0),
    ),
    ZodiacSign(
      name: 'Scorpio',
      symbol: '♏',
      startDate: DateTime(2000, 10, 23),
      endDate: DateTime(2000, 11, 21),
      element: Element.water,
      rulingPlanet: 'Pluto',
      traits: ['Intense', 'Passionate', 'Resourceful', 'Secretive'],
      description:
          'Scorpio is magnetic, intense, and fiercely loyal. Ruled by Pluto, Scorpios are drawn to depth, transformation, and truth beneath the surface.',
      primaryColor: Color(0xFF6A1B9A),
      secondaryColor: Color(0xFFE1BEE7),
    ),
    ZodiacSign(
      name: 'Sagittarius',
      symbol: '♐',
      startDate: DateTime(2000, 11, 22),
      endDate: DateTime(2000, 12, 21),
      element: Element.fire,
      rulingPlanet: 'Jupiter',
      traits: ['Adventurous', 'Optimistic', 'Honest', 'Restless'],
      description:
          'Sagittarius is the explorer of the zodiac, always chasing new horizons. Ruled by Jupiter, Sagittarians are optimistic, philosophical, and refreshingly honest.',
      primaryColor: Color(0xFF5E35B1),
      secondaryColor: Color(0xFFD1C4E9),
    ),
    ZodiacSign(
      name: 'Capricorn',
      symbol: '♑',
      startDate: DateTime(2000, 12, 22),
      endDate: DateTime(2000, 12, 31),
      element: Element.earth,
      rulingPlanet: 'Saturn',
      traits: ['Disciplined', 'Ambitious', 'Patient', 'Reserved'],
      description:
          'Capricorn is disciplined, ambitious, and built for the long climb. Ruled by Saturn, Capricorns value structure, achievement, and quiet perseverance.',
      primaryColor: Color(0xFF37474F),
      secondaryColor: Color(0xFFCFD8DC),
    ),
    ZodiacSign(
      name: 'Aquarius',
      symbol: '♒',
      startDate: DateTime(2000, 1, 20),
      endDate: DateTime(2000, 2, 18),
      element: Element.air,
      rulingPlanet: 'Uranus',
      traits: ['Independent', 'Inventive', 'Humanitarian', 'Aloof'],
      description:
          'Aquarius is the visionary of the zodiac — independent, inventive, and driven by big ideas. Ruled by Uranus, Aquarians march to their own beat.',
      primaryColor: Color(0xFF00ACC1),
      secondaryColor: Color(0xFFB2EBF2),
    ),
    ZodiacSign(
      name: 'Pisces',
      symbol: '♓',
      startDate: DateTime(2000, 2, 19),
      endDate: DateTime(2000, 3, 20),
      element: Element.water,
      rulingPlanet: 'Neptune',
      traits: ['Compassionate', 'Artistic', 'Intuitive', 'Escapist'],
      description:
          'Pisces is the dreamer of the zodiac, deeply empathetic and imaginative. Ruled by Neptune, Pisceans move fluidly between the real and the imagined.',
      primaryColor: Color(0xFF26A69A),
      secondaryColor: Color(0xFFB2DFDB),
    ),
  ];

  /// Handles Capricorn's date range wrap-around (Dec 22 - Jan 19).
  static ZodiacSign fromBirthDate(DateTime birthDate) {
    final m = birthDate.month;
    final d = birthDate.day;

    if ((m == 12 && d >= 22) || (m == 1 && d <= 19)) {
      return signs.firstWhere((s) => s.name == 'Capricorn');
    }

    for (final sign in signs) {
      if (sign.name == 'Capricorn') continue;
      final startOk = m > sign.startDate.month ||
          (m == sign.startDate.month && d >= sign.startDate.day);
      final endOk = m < sign.endDate.month ||
          (m == sign.endDate.month && d <= sign.endDate.day);
      if (sign.startDate.month == sign.endDate.month) {
        if (m == sign.startDate.month && d >= sign.startDate.day && d <= sign.endDate.day) {
          return sign;
        }
      } else if (startOk && endOk) {
        return sign;
      }
    }
    // Fallback (shouldn't happen)
    return signs.first;
  }

  static ZodiacSign byName(String name) =>
      signs.firstWhere((s) => s.name.toLowerCase() == name.toLowerCase());
}
