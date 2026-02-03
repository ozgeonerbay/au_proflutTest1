import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/locale_provider.dart';
import '../data/calendar_repository.dart';
import '../l10n/app_localizations.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  List<CalendarEvent> _events = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final list = await CalendarRepository.load();
    if (mounted) {
      setState(() {
        _events = list;
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final isTurkish = context.watch<LocaleProvider>().isTurkish;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.calendar),
        backgroundColor: Colors.orange.shade700,
        foregroundColor: Colors.white,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.orange.shade50, Colors.white],
          ),
        ),
        child: _loading
            ? const Center(child: CircularProgressIndicator())
            : _events.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.calendar_today, size: 64, color: Colors.orange.shade300),
                        const SizedBox(height: 16),
                        Text(l10n.emptyCalendar, style: TextStyle(fontSize: 16, color: Colors.orange.shade700)),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: _events.length,
                    itemBuilder: (context, index) {
                      final e = _events[index];
                      final isPast = e.date.isBefore(DateTime.now());
                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        elevation: 2,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: _typeColor(e.type).withValues(alpha: 0.2),
                            child: Icon(_typeIcon(e.type), color: _typeColor(e.type)),
                          ),
                          title: Text(e.title(isTurkish), style: const TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Text(
                            '${e.date.day}/${e.date.month}/${e.date.year}',
                            style: TextStyle(color: isPast ? Colors.grey : null),
                          ),
                        ),
                      );
                    },
                  ),
      ),
    );
  }

  Color _typeColor(String type) {
    switch (type) {
      case 'semester_start':
      case 'semester_end':
        return Colors.blue;
      case 'exam_week':
        return Colors.red;
      case 'holiday':
        return Colors.green;
      default:
        return Colors.orange;
    }
  }

  IconData _typeIcon(String type) {
    switch (type) {
      case 'semester_start':
      case 'semester_end':
        return Icons.school;
      case 'exam_week':
        return Icons.quiz;
      case 'holiday':
        return Icons.celebration;
      default:
        return Icons.event;
    }
  }
}
