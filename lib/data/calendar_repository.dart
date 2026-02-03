import 'dart:convert';

import 'package:flutter/services.dart';

/// Academic event (semester, exam, holiday).
class CalendarEvent {
  final String type;
  final DateTime date;
  final String titleTr;
  final String titleEn;

  CalendarEvent({
    required this.type,
    required this.date,
    required this.titleTr,
    required this.titleEn,
  });

  String title(bool isTurkish) => isTurkish ? titleTr : titleEn;
}

class CalendarRepository {
  static const _assetPath = 'assets/data/academic_calendar.json';

  static Future<List<CalendarEvent>> load() async {
    try {
      final str = await rootBundle.loadString(_assetPath);
      final map = json.decode(str) as Map<String, dynamic>;
      final list = map['events'] as List<dynamic>;
      return list.map((e) {
        final m = e as Map<String, dynamic>;
        final dateStr = m['date'] as String;
        return CalendarEvent(
          type: m['type'] as String,
          date: DateTime.parse(dateStr),
          titleTr: m['titleTr'] as String,
          titleEn: m['titleEn'] as String,
        );
      }).toList()
        ..sort((a, b) => a.date.compareTo(b.date));
    } catch (e) {
      return [];
    }
  }
}
