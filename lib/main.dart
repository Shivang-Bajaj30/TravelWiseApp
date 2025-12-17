import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/welcome_screen.dart';
import 'screens/itinerary_form_screen.dart';
import 'theme/app_colors.dart';
import 'theme/theme_controller.dart';

void main() {
  runApp(
    AnimatedBuilder(
      animation: themeController,
      builder: (context, _) => const TravelWiseApp(),
    ),
  );
}

class TravelWiseApp extends StatelessWidget {
  const TravelWiseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      key: ValueKey(themeController.isLight),
      title: 'TravelWise',
      debugShowCheckedModeBanner: false,
      theme: _buildDarkTheme(),
      initialRoute: WelcomeScreen.routeName,
      routes: {
        WelcomeScreen.routeName: (context) => const WelcomeScreen(),
        LoginScreen.routeName: (context) => const LoginScreen(),
        SignupScreen.routeName: (context) => const SignupScreen(),
        HomeScreen.routeName: (context) => const HomeScreen(),
        ItineraryFormScreen.routeName: (context) => const ItineraryFormScreen(),
      },
    );
  }

  ThemeData _buildDarkTheme() {
    final base = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        brightness: Brightness.dark,
      ),
      scaffoldBackgroundColor: AppColors.dark,
      canvasColor: AppColors.dark,
      textTheme: GoogleFonts.poppinsTextTheme().apply(
        bodyColor: Colors.white,
        displayColor: Colors.white,
      ),
    );

    return base.copyWith(
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.white,
        centerTitle: false,
      ),
      cardTheme: CardThemeData(
        color: Colors.white.withValues(alpha: .03),
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 8,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.dark,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: Colors.white70,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.secondary,
          textStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      ),
      inputDecorationTheme: base.inputDecorationTheme.copyWith(
        hintStyle: TextStyle(color: Colors.white.withValues(alpha: .6)),
      ),
    );
  }

  ThemeData _buildLightTheme() {
    final base = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.lightPrimary,
        brightness: Brightness.light,
      ),
      scaffoldBackgroundColor: AppColors.lightBackground,
      canvasColor: AppColors.lightBackground,
      textTheme: GoogleFonts.poppinsTextTheme().apply(
        bodyColor: AppColors.lightTextPrimary,
        displayColor: AppColors.lightTextPrimary,
      ),
    );

    return base.copyWith(
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: AppColors.lightAccent,
        centerTitle: false,
      ),
      cardTheme: CardThemeData(
        color: AppColors.lightCard,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        shadowColor: Colors.black12,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.lightPrimary,
        foregroundColor: Colors.white,
        elevation: 8,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.lightCard,
        selectedItemColor: AppColors.lightPrimary,
        unselectedItemColor: AppColors.lightTextSecondary,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.lightSecondary,
          textStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      ),
      inputDecorationTheme: base.inputDecorationTheme.copyWith(
        hintStyle: const TextStyle(color: AppColors.lightTextSecondary),
        filled: true,
        fillColor: AppColors.lightCard,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(color: AppColors.lightAccent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(
            color: AppColors.lightPrimary,
            width: 1.4,
          ),
        ),
      ),
    );
  }
}
