import 'package:couldai_user_app/home_page.dart';
import 'package:couldai_user_app/scanner_page.dart';
import 'package:couldai_user_app/analysis_result_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BacBo AI Analyzer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color(0xFF00E676), // Neon Green
        scaffoldBackgroundColor: const Color(0xFF121212),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF00E676),
          secondary: Color(0xFF2979FF), // Blue for Player
          tertiary: Color(0xFFFF1744), // Red for Banker
          surface: Color(0xFF1E1E1E),
        ),
        textTheme: GoogleFonts.orbitronTextTheme(
          Theme.of(context).textTheme.apply(
            bodyColor: Colors.white,
            displayColor: Colors.white,
          ),
        ),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/scanner': (context) => const ScannerPage(),
        '/result': (context) => const AnalysisResultPage(),
      },
    );
  }
}
