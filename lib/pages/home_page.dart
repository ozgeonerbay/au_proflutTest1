import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../widgets/nav_card.dart';
import 'menu_page.dart';
import 'shuttle_page.dart';
import 'office_page.dart';
import 'calendar_page.dart';
import 'settings_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'assets/logo.png',
              height: 32,
              width: 32,
              errorBuilder: (_, __, ___) => const Icon(Icons.school),
            ),
            const SizedBox(width: 12),
            Text(l10n.appTitle),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.language),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const SettingsPage()),
            ),
            tooltip: l10n.selectLanguage,
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.red.shade50, Colors.white],
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            NavCard(
              title: l10n.menu,
              subtitle: l10n.menuSubtitle,
              icon: Icons.restaurant_menu,
              color: Colors.red,
              page: const MenuPage(),
            ),
            NavCard(
              title: l10n.shuttle,
              subtitle: l10n.shuttleSubtitle,
              icon: Icons.directions_bus,
              color: Colors.blue,
              page: const ShuttlePage(),
            ),
            NavCard(
              title: l10n.lecturers,
              subtitle: l10n.lecturersSubtitle,
              icon: Icons.work,
              color: Colors.green,
              page: const OfficePage(),
            ),
            NavCard(
              title: l10n.calendar,
              subtitle: l10n.calendarSubtitle,
              icon: Icons.calendar_month,
              color: Colors.orange,
              page: const CalendarPage(),
            ),
          ],
        ),
      ),
    );
  }
}
