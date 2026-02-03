import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/locale_provider.dart';
import 'core/theme/app_theme.dart';
import 'l10n/app_localizations.dart';
import 'pages/home_page.dart';

class AuProflutApp extends StatelessWidget {
  const AuProflutApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LocaleProvider(),
      child: Consumer<LocaleProvider>(
        builder: (context, localeProvider, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Altınbaş Okul Rehberi',
            locale: localeProvider.locale,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            theme: AppTheme.light,
            home: const HomePage(),
          );
        },
      ),
    );
  }
}
