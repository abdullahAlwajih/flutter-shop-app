import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:super_repository/super_repository.dart';

import 'core/routes/app_pages.dart';
import 'core/services/app_services.dart';
import 'core/styles/app_themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppServices.initServices();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Shop App',
      debugShowCheckedModeBanner: false,
      navigatorKey: SuperRepository.navigatorKey,
      theme: AppThemes.lightThemeData,
      // darkTheme: AppThemes.darkThemeData,
      themeMode: ThemeMode.light,
      locale: Locale(Platform.localeName.substring(0, 2)),
      fallbackLocale: const Locale('ar'),
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: const [
        ...AppLocalizations.localizationsDelegates,
        ...SuperLocalizations.localizationsDelegates
      ],
      initialRoute: AppPages.initial,
      getPages: AppPages.pages,
    );
  }
}
