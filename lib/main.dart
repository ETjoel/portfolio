
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'controllers/project_controller.dart';
import 'views/main_page.dart';
import 'views/project_detail_page.dart';
import 'views/admin_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Color palette inspired by One Piece
    const Color parchmentBeige = Color(0xFFF5EEDC);
    const Color deepOceanBlue = Color(0xFF0D1B2A);
    const Color sunnyYellow = Color(0xFFFFC107);
    const Color fieryRed = Color(0xFFD32F2F);

    final pirateTheme = ThemeData(
      primaryColor: deepOceanBlue,
      scaffoldBackgroundColor: parchmentBeige,
      colorScheme: const ColorScheme.light(
        primary: deepOceanBlue,
        secondary: sunnyYellow,
        background: parchmentBeige,
        surface: deepOceanBlue, // For cards and surfaces
        onPrimary: parchmentBeige,
        onSecondary: Colors.black,
        onBackground: Colors.black87,
        onSurface: parchmentBeige,
        error: fieryRed,
      ),
      textTheme: TextTheme(
        displayLarge: GoogleFonts.pirataOne(fontSize: 52, fontWeight: FontWeight.bold, color: deepOceanBlue),
        headlineMedium: GoogleFonts.uncialAntiqua(fontSize: 28, fontWeight: FontWeight.bold, color: deepOceanBlue),
        bodyLarge: GoogleFonts.merriweather(fontSize: 16, color: Colors.black87, height: 1.6),
        bodyMedium: GoogleFonts.merriweather(fontSize: 14, color: Colors.black87),
        labelLarge: GoogleFonts.pirataOne(fontSize: 18, fontWeight: FontWeight.bold, color: parchmentBeige),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white.withOpacity(0.8),
        hintStyle: GoogleFonts.merriweather(color: Colors.black54),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: deepOceanBlue, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: sunnyYellow, width: 2.5),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: deepOceanBlue,
          backgroundColor: sunnyYellow,
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          textStyle: GoogleFonts.pirataOne(fontSize: 20, fontWeight: FontWeight.bold),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
            side: const BorderSide(color: deepOceanBlue, width: 2),
          ),
        ),
      ),
    );

    return ChangeNotifierProvider(
      create: (context) => ProjectController(),
      child: MaterialApp(
        title: "Pirate's Portfolio",
        theme: pirateTheme,
        initialRoute: '/',
        debugShowCheckedModeBanner: false,
        onGenerateRoute: (settings) {
          if (settings.name == '/project') {
            final projectId = settings.arguments as String?;
            if (projectId != null) {
              return MaterialPageRoute(
                builder: (context) => ProjectDetailPage(projectId: projectId),
              );
            }
          }
          switch (settings.name) {
            case '/':
              return MaterialPageRoute(builder: (context) => const MainPage());
            case '/admin':
              return MaterialPageRoute(builder: (context) => const AdminPage());
            default:
              return MaterialPageRoute(builder: (context) => const MainPage());
          }
        },
      ),
    );
  }
}
