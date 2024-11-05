// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:mycar/pages/home_laboratorio.dart';
import 'package:mycar/providers/hrayto_provider.dart';
import 'package:mycar/providers/url_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

const String titleApp = 'Laboratorio';
const Color colorTheme = Color.fromARGB(255, 22, 21, 105);
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UrlProvider()),
        ChangeNotifierProvider(create: (context) => HRaytoProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    /*  if (Platform.isWindows) {
      DesktopWindow.setWindowSize(const Size(600, 900));
    } */
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: titleApp,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: colorTheme),
        useMaterial3: true,
      ),
      home: const Homemycar(
        title: titleApp,
      ),
      localizationsDelegates: const [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('es'),
        Locale('en'), // English
      ],
    );
  }
}
