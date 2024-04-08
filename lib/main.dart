import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:http/http.dart' as http;
import 'flutter_flow/flutter_flow_theme.dart';
import 'flutter_flow/flutter_flow_util.dart';
import 'index.dart';
import 'oeuvres_louvres/oeuvres_louvres_widget.dart';
import 'package:flutter/services.dart' show rootBundle;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await FlutterFlowTheme.initialize();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<MyApp> createState() => _MyAppState();

  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!;
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = FlutterFlowTheme.themeMode;

  void setThemeMode(ThemeMode mode) => setState(() {
        _themeMode = mode;
        FlutterFlowTheme.saveThemeMode(mode);
      });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'dashArt',
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en', '')],
      theme: ThemeData(
        brightness: Brightness.light,
        useMaterial3: false,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: false,
      ),
      themeMode: _themeMode,
      home: HomePageWidget(),
      navigatorObservers: [routeObserver],
    );
  }
}
Future<Map<String, String>> loadJsonImageLouvres() async {
  final response = await http.get(
      Uri.parse('http://localhost:3000/image-links-louvres'));

  if (response.statusCode == 200) {
    final jsonData = response.body;
    final List<dynamic> imagesData = json.decode(jsonData);

    // Créer un Map pour stocker les titres et les liens
    Map<String, String> imagesMap = {};

    // Parcourir les données JSON et ajouter les titres et les liens au Map
    imagesData.forEach((image) {
      String titre = image['titre'];
      String lien = image['lien'];
      imagesMap[titre] = lien;
    });

    return imagesMap;
  } else {
    throw Exception('Failed to load ImageLinksLouvres.json');
  }
}

Future<Map<String, String>> loadJsonImageGuimet() async {
  final response = await http.get(
      Uri.parse('http://localhost:3000/image-links-guimet'));

  if (response.statusCode == 200) {
    final jsonData = response.body;
    final List<dynamic> imagesData = json.decode(jsonData);

    // Créer un Map pour stocker les titres et les liens
    Map<String, String> imagesMap = {};

    // Parcourir les données JSON et ajouter les titres et les liens au Map
    imagesData.forEach((image) {
      String titre = image['titre'];
      String lien = image['lien'];
      imagesMap[titre] = lien;
    });

    return imagesMap;
  } else {
    throw Exception('Failed to load ImageLinksGuimet.json');
  }
}