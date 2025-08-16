import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/routes.dart';
import 'package:provider/provider.dart';
import 'controllers/project_controller.dart';
import 'controllers/auth_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final AuthController _authController;
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    _authController = AuthController();
    _router = createRouter(_authController);
  }

  @override
  Widget build(BuildContext context) {
    // Color palette inspired by One Piece
    const Color parchmentBeige = Color(0xFFF5EEDC);
    const Color deepOceanBlue = Color(0xFF0D1B2A);
    Color sunnyYellow = Colors.green.shade900;
    const Color fieryRed = Color(0xFFD32F2F);

    final darkPirateTheme = ThemeData(
      primaryColor: deepOceanBlue,
      scaffoldBackgroundColor: Colors.black,
      colorScheme: ColorScheme.dark(
        primary: deepOceanBlue,
        secondary: Color.fromARGB(255, 17, 59, 20).withOpacity(0.4),
        background: Colors.black,
        surface: deepOceanBlue, // For cards and surfaces
        onPrimary: parchmentBeige,
        onSecondary: Colors.black,
        onBackground: parchmentBeige,
        onSurface: parchmentBeige,
        error: fieryRed,
      ),
      textTheme: TextTheme(
        displayLarge: GoogleFonts.merriweather(
            fontSize: 52, fontWeight: FontWeight.bold, color: parchmentBeige),
        headlineMedium: GoogleFonts.merriweather(
            fontSize: 28, fontWeight: FontWeight.bold, color: parchmentBeige),
        bodyLarge: GoogleFonts.merriweather(
            fontSize: 16, color: parchmentBeige.withOpacity(0.8), height: 1.6),
        bodyMedium: GoogleFonts.merriweather(
            fontSize: 14, color: parchmentBeige.withOpacity(0.8)),
        labelLarge: GoogleFonts.merriweather(
            fontSize: 18, fontWeight: FontWeight.bold, color: deepOceanBlue),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.black.withOpacity(0.5),
        hintStyle:
            GoogleFonts.merriweather(color: parchmentBeige.withOpacity(0.6)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: parchmentBeige, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: sunnyYellow, width: 2.5),
        ),
        labelStyle: GoogleFonts.merriweather(
          fontSize: 16,
          color:  sunnyYellow,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: parchmentBeige,
          backgroundColor: sunnyYellow,
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          textStyle: GoogleFonts.merriweather(
              fontSize: 16, fontWeight: FontWeight.bold, color: parchmentBeige),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
            side: const BorderSide(color: deepOceanBlue, width: 2),
          ),
        ),
      ),
    );

    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: _authController),
        ChangeNotifierProvider(create: (_) => ProjectController()),
      ],
      child: MaterialApp.router(
        title: "Eyuel's Portfolio",
        theme: darkPirateTheme,
        debugShowCheckedModeBanner: false,
        routerConfig: _router,
      ),
    );
  }
}
