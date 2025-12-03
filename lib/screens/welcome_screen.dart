import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import '../widgets/primary_button.dart';
import '../widgets/screen_background.dart';
import 'login_screen.dart';
import 'signup_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  static const String routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        imageUrl: 'lib/images/welcome.jpeg',
        overlayOpacity: 0.35,
        gradientColors: const [
          Colors.transparent,
          Color(0x99000000),
          AppColors.dark,
        ],
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'TravelWise',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    letterSpacing: 1.4,
                  ),
                ),

                SizedBox(height: 200),
                Text(
                  'Explore the World,\nYour Way',
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'AI-crafted itineraries to uncover unforgettable journeys tailored to you.',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(color: Colors.white70),
                ),
                const SizedBox(height: 40),
                SizedBox(
                  width: double.infinity,
                  child: PrimaryButton(
                    label: 'Login',
                    onPressed: () =>
                        Navigator.pushNamed(context, LoginScreen.routeName),
                  ),
                ),
                const SizedBox(height: 14),
                SizedBox(
                  width: double.infinity,
                  child: PrimaryButton(
                    backgroundColor: const Color.fromARGB(198, 183, 183, 183),
                    label: 'Explore Now',
                    // filled: true,
                    onPressed: () =>
                        Navigator.pushNamed(context, SignupScreen.routeName),
                  ),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
