import 'package:flutter/material.dart';
import 'package:flutter_fly_connect/generated/l10n.dart';
import 'package:flutter_fly_connect/pages/index/index_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(
        useMaterial3: true,
      ).copyWith(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue)),
      themeMode: ThemeMode.light,
      localizationsDelegates: const [
        S.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      home: const IndexPage(),
    );
  }
}
