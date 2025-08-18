import 'package:dotenv/dotenv.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/core/constants.dart';
import 'package:portfolio/core/routes.dart';
import 'package:portfolio/services/supabase_service.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'controllers/project_controller.dart';
import 'controllers/auth_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  DotEnv().load();
  await initializeSupabase();
  runApp(const MyApp());
}

Future<void> initializeSupabase () async {
  try {
  final supabaseUrl = Constants.supabaseUrl;
  final supabaseKey = DotEnv().getOrElse('SUPABASE_KEY', () => '');
  await Supabase.initialize(url: supabaseUrl, anonKey: supabaseKey);

  } catch (e) {
    print('Error initializing Supabase: $e');
  }
 
}


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final AuthController _authController;
  late final ProjectController _projectController;
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    final supabaseKey = DotEnv().getOrElse('SUPABASE_KEY', () => ''); 
    final supabaseService = SupabaseService(supabaseKey: supabaseKey);
    _authController = AuthController();
    _router = createRouter(_authController);
    _projectController = ProjectController(supabaseService: supabaseService );
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
          color: sunnyYellow,
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

    final lightPirateTheme = ThemeData(
      primaryColor: parchmentBeige,
      scaffoldBackgroundColor: Colors.white,
      colorScheme: ColorScheme.light(
        primary: parchmentBeige,
        secondary: Colors.green.shade800,
        background: Colors.white,
        surface: Colors.white,
        onPrimary: deepOceanBlue,
        onSecondary: deepOceanBlue,
        onBackground: deepOceanBlue,
        onSurface: deepOceanBlue,
        error: fieryRed,
      ),
      textTheme: TextTheme(
        displayLarge: GoogleFonts.merriweather(
            fontSize: 52, fontWeight: FontWeight.bold, color: deepOceanBlue),
        headlineMedium: GoogleFonts.merriweather(
            fontSize: 28, fontWeight: FontWeight.bold, color: deepOceanBlue),
        bodyLarge: GoogleFonts.merriweather(
            fontSize: 16, color: deepOceanBlue.withOpacity(0.8), height: 1.6),
        bodyMedium: GoogleFonts.merriweather(
            fontSize: 14, color: deepOceanBlue.withOpacity(0.8)),
        labelLarge: GoogleFonts.merriweather(
            fontSize: 18, fontWeight: FontWeight.bold, color: parchmentBeige),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        // fillColor: Colors.white.withOpacity(0.7),
        hintStyle:
            GoogleFonts.merriweather(color: deepOceanBlue.withOpacity(0.6)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: deepOceanBlue, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.green.shade700, width: 2.5),
        ),
        labelStyle: GoogleFonts.merriweather(
          fontSize: 16,
          color: Colors.green.shade700,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: deepOceanBlue,
          backgroundColor: parchmentBeige,
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          textStyle: GoogleFonts.merriweather(
              fontSize: 16, fontWeight: FontWeight.bold, color: deepOceanBlue),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
            side: BorderSide(color: deepOceanBlue, width: 2),
          ),
        ),
      ),
    );

    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: _authController),
        ChangeNotifierProvider(create: (_) => _projectController..fetchProjects()),
      ],
      child: MaterialApp.router(
        title: "Eyuel's Portfolio",
        theme: lightPirateTheme,
        debugShowCheckedModeBanner: false,
        routerConfig: _router,
      ),
    );
  }
}


