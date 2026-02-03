import 'dart:convert';

import 'package:flutter/services.dart';

/// Single campus schedule: weekday and weekend lines.
class ShuttleCampus {
  final String id;
  final List<String> weekday;
  final List<String> weekend;

  ShuttleCampus({
    required this.id,
    required this.weekday,
    required this.weekend,
  });
}

class ShuttleRepository {
  static const _assetPath = 'assets/data/shuttle_schedule.json';

  static Future<List<ShuttleCampus>> load() async {
    try {
      final str = await rootBundle.loadString(_assetPath);
      final map = json.decode(str) as Map<String, dynamic>;
      final list = map['campuses'] as List<dynamic>;
      return list.map((e) {
        final m = e as Map<String, dynamic>;
        return ShuttleCampus(
          id: m['id'] as String,
          weekday: (m['weekday'] as List<dynamic>).cast<String>(),
          weekend: (m['weekend'] as List<dynamic>).cast<String>(),
        );
      }).toList();
    } catch (e) {
      return [];
    }
  }
}
