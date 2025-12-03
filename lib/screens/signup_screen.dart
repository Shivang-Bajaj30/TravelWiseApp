import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/auth_text_field.dart';
import '../widgets/primary_button.dart';
import '../widgets/screen_background.dart';
import '../widgets/glass_container.dart';
import '../widgets/social_login_options.dart';
import 'login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  static const String routeName = '/signup';

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool agreeTerms = false;
  bool showPassword = false;
  bool showConfirmPassword = false;

  void _togglePasswordVisibility() {
    setState(() => showPassword = !showPassword);
  }

  void _toggleConfirmPasswordVisibility() {
    setState(() => showConfirmPassword = !showConfirmPassword);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: ScreenBackground(
        imageUrl: 'lib/images/signup.jpg',
        child: SafeArea(
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 1),
                  Center(
                    child: GlassContainer(
                      padding: const EdgeInsets.all(25),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Create Account',
                              style: Theme.of(context).textTheme.headlineSmall
                                  ?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              'Sign up to start your AI-crafted journeys.',
                              style: Theme.of(context).textTheme.bodyLarge
                                  ?.copyWith(color: Colors.white70),
                            ),
                            const SizedBox(height: 24),
                            const AuthTextField(
                              hint: 'Full Name',
                              icon: Icons.person_outline_rounded,
                            ),
                            const SizedBox(height: 14),
                            const AuthTextField(
                              hint: 'Email Address',
                              icon: Icons.mail_outline_rounded,
                              keyboardType: TextInputType.emailAddress,
                            ),
                            const SizedBox(height: 14),
                            const AuthTextField(
                              hint: 'Phone Number',
                              icon: Icons.phone_outlined,
                              keyboardType: TextInputType.phone,
                            ),
                            const SizedBox(height: 14),
                            AuthTextField(
                              hint: 'Password',
                              icon: Icons.lock_outline_rounded,
                              obscureText: !showPassword,
                              suffixIcon: IconButton(
                                icon: Icon(
                                  showPassword
                                      ? Icons.visibility_rounded
                                      : Icons.visibility_off_rounded,
                                  color: Colors.white70,
                                ),
                                onPressed: () => setState(
                                  () => showPassword = !showPassword,
                                ),
                              ),
                            ),
                            const SizedBox(height: 14),
                            AuthTextField(
                              hint: 'Confirm Password',
                              icon: Icons.lock_outline,
                              obscureText: !showConfirmPassword,
                              suffixIcon: IconButton(
                                icon: Icon(
                                  showConfirmPassword
                                      ? Icons.visibility_rounded
                                      : Icons.visibility_off_rounded,
                                  color: Colors.white70,
                                ),
                                onPressed: () => setState(
                                  () => showConfirmPassword =
                                      !showConfirmPassword,
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                Checkbox(
                                  value: agreeTerms,
                                  activeColor: AppColors.accent,
                                  onChanged: (value) => setState(
                                    () => agreeTerms = value ?? false,
                                  ),
                                ),
                                Expanded(
                                  child: RichText(
                                    text: const TextSpan(
                                      text: 'I agree to the ',
                                      style: TextStyle(color: Colors.white70),
                                      children: [
                                        TextSpan(
                                          text: 'Terms & Conditions',
                                          style: TextStyle(
                                            color: AppColors.accent,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            SizedBox(
                              width: double.infinity,
                              child: PrimaryButton(
                                label: 'Sign Up',
                                onPressed: agreeTerms
                                    ? () {
                                        Navigator.pushReplacementNamed(
                                          context,
                                          '/home',
                                        );
                                      }
                                    : null,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Center(
                              child: Text(
                                'OR SIGN UP WITH',
                                style: TextStyle(
                                  color: Colors.white70,
                                  letterSpacing: 1,
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            SocialLoginOptions(
                              onGoogleTap: () {},
                              onFacebookTap: () {},
                            ),
                            const SizedBox(height: 24),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Already have an account? ',
                                  style: TextStyle(color: Colors.white70),
                                ),
                                GestureDetector(
                                  onTap: () => Navigator.pushReplacementNamed(
                                    context,
                                    LoginScreen.routeName,
                                  ),
                                  child: const Text(
                                    'Login',
                                    style: TextStyle(
                                      color: AppColors.accent,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
