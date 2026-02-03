import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/locale_provider.dart';
import '../l10n/app_localizations.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final localeProvider = context.watch<LocaleProvider>();

    return Scaffold(
      appBar: AppBar(title: Text(l10n.selectLanguage)),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.language),
            title: Text(l10n.turkish),
            trailing: localeProvider.isTurkish ? const Icon(Icons.check, color: Colors.green) : null,
            onTap: () {
              localeProvider.setLocale(const Locale('tr'));
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.language),
            title: Text(l10n.english),
            trailing: !localeProvider.isTurkish ? const Icon(Icons.check, color: Colors.green) : null,
            onTap: () {
              localeProvider.setLocale(const Locale('en'));
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
