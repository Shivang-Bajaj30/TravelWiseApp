Theme_CONTROLLER.dart

```dart
import 'package:flutter/material.dart';

/// Simple global theme controller to switch between dark and light premium themes.
class ThemeController extends ChangeNotifier {
  bool isLight = true;

  void toggle() {
    isLight = !isLight;
    notifyListeners();
  }

  ThemeMode get themeMode {
    return isLight ? ThemeMode.light : ThemeMode.dark;
  }
}

final ThemeController themeController = ThemeController();
```

app_colors.dart

```dart
import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Premium dark palette (current)
  static const Color primary = Color(0xFFEE3054); // deep crimson
  static const Color secondary = Color(0xFFFF6B6B); // soft coral red
  static const Color accent = Color(0xFFFF9F68); // warm amber-red accent

  // Surfaces
  static const Color dark = Color(0xFF07040A); // near‑black background
  static const Color light = Color(0xFFFFF8F8); // soft off‑white

  // Dark theme text colors
  static const Color darkTextPrimary = Color(0xFFFFFFFF); // white text
  static const Color darkTextSecondary = Color(0xFFAAAAAA); // gray text

  // Dark theme surfaces
  static const Color darkCardBackground = Color(0xFF1E1E1E); // dark card
  static const Color darkAppBar = Color(0xFF121212); // dark app bar

  // White‑forward light theme palette (option 4)
  static const Color lightPrimary = Color(0xFFE50914);
  static const Color lightSecondary = Color(0xFFFF6D6D);
  static const Color lightAccent = Color(0xFF2D3142); // slate
  static const Color lightBackground = Color(0xFFFFF5F5);
  static const Color lightCard = Color(0xFFFFFFFF);
  static const Color lightTextPrimary = Color(0xFF111111);
  static const Color lightTextSecondary = Color(0xFF777777);

  // Light theme surfaces
  static const Color lightAppBar = Color(0xFFFFFFFF); // white app bar
  static const Color lightDivider = Color(0xFFEEEEEE); // light divider

  // Semantic colors (work for both themes)
  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFF44336);
  static const Color warning = Color(0xFFFFC107);
  static const Color info = Color(0xFF2196F3);

  // Disable/inactive states
  static const Color disabled = Color(0xFFBDBDBD);
}
```

main.dart
```dart
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
    final isLight = themeController.isLight;
    return MaterialApp(
      title: 'TravelWise',
      debugShowCheckedModeBanner: false,
      theme: isLight ? _buildLightTheme() : _buildDarkTheme(),
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
        bodyColor: AppColors.darkTextPrimary,
        displayColor: AppColors.darkTextPrimary,
      ),
    );

    return base.copyWith(
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.dark,
        elevation: 0,
        foregroundColor: Colors.white,
        centerTitle: false,
      ),
      cardTheme: CardThemeData(
        color: AppColors.darkCardBackground,
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
      switchTheme: SwitchThemeData(
        thumbColor: const WidgetStatePropertyAll(AppColors.primary),
        trackColor: WidgetStatePropertyAll(
          AppColors.primary.withValues(alpha: 0.3),
        ),
      ),
      iconTheme: const IconThemeData(color: Colors.white),
      inputDecorationTheme: base.inputDecorationTheme.copyWith(
        hintStyle: TextStyle(color: Colors.white.withValues(alpha: .6)),
        filled: true,
        fillColor: AppColors.darkCardBackground,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(color: AppColors.primary),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.4),
        ),
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
      scaffoldBackgroundColor: AppColors.lightBackground,
      canvasColor: AppColors.lightBackground,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.lightAppBar,
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
      switchTheme: SwitchThemeData(
        thumbColor: const WidgetStatePropertyAll(AppColors.lightPrimary),
        trackColor: WidgetStatePropertyAll(
          AppColors.lightPrimary.withValues(alpha: 0.3),
        ),
      ),
      iconTheme: const IconThemeData(color: AppColors.lightAccent),
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
```

home_screen.dart

```dart
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/theme_controller.dart';
import '../widgets/primary_button.dart';
import 'itinerary_form_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const String routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  // TODO: Replace with real user data once auth is wired.
  final String _username = 'Traveler';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        titleSpacing: 8,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome,',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: Theme.of(context).textTheme.bodySmall?.color,
              ),
            ),
            Text(
              _username,
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none_rounded),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: _buildBody(),
      floatingActionButton: null,
      floatingActionButtonLocation: null,
      bottomNavigationBar: SafeArea(
        top: false,
        bottom: true,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;
            final fabSize = 44.0;
            // Bar height
            final barHeight = 64.0;
            return SizedBox(
              height: barHeight, // only the nav bar's own height
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  // Nav bar background
                  Positioned.fill(
                    child: Container(
                      color:
                          Theme.of(
                            context,
                          ).bottomNavigationBarTheme.backgroundColor ??
                          Theme.of(context).scaffoldBackgroundColor,
                    ),
                  ),
                  // Navigation row
                  Positioned.fill(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: List.generate(
                        4,
                        (i) => Expanded(
                          child: _BottomItem(
                            icon: [
                              Icons.home_filled,
                              Icons.card_travel_rounded,
                              Icons.favorite,
                              Icons.person_outline_rounded,
                            ][i],
                            label: [
                              'Home',
                              'My Trips',
                              'Favorites',
                              'Profile',
                            ][i],
                            selected: _currentIndex == i,
                            onTap: () => setState(() => _currentIndex = i),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Floating FAB, half-overlapping above the nav bar
                  Positioned(
                    left: (width - fabSize) / 2,
                    bottom:
                        -fabSize / 2 +
                        65, // Half above bar, 8px for a bit more visual cushion
                    child: GestureDetector(
                      onTap: () => Navigator.pushNamed(
                        context,
                        ItineraryFormScreen.routeName,
                      ),
                      child: Container(
                        width: fabSize,
                        height: fabSize,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).brightness == Brightness.dark
                              ? AppColors.accent
                              : AppColors.lightPrimary,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black38,
                              blurRadius: 8,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.auto_awesome,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildBody() {
    if (_currentIndex == 0) {
      return SafeArea(
        child: Builder(
          builder: (context) => ListView(
            padding: EdgeInsets.fromLTRB(
              20,
              28,
              20,
              MediaQuery.of(context).padding.bottom + 56 + 12,
            ),
            children: [
              _buildSearchBar(),
              const SizedBox(height: 24),
              _SectionHeader(
                title: 'Trending Now',
                subtitle: 'Popular escapes this week',
              ),
              const SizedBox(height: 12),
              _HorizontalDestinations(
                chips: const ['Bali', 'Paris', 'Tokyo', 'Istanbul'],
              ),
              const SizedBox(height: 24),
              _SectionHeader(
                title: 'Budget Wise Picks',
                subtitle: 'Great trips for every wallet',
              ),
              const SizedBox(height: 12),
              _HorizontalCards(
                items: const [
                  ('Quick Getaways', 'Under \$300'),
                  ('Slow Travel', 'Under \$800'),
                  ('Family Friendly', 'Under \$1200'),
                ],
              ),
              const SizedBox(height: 24),
              _SectionHeader(
                title: 'Weekend Ideas',
                subtitle: 'Short, sweet and spontaneous',
              ),
              const SizedBox(height: 12),
              _HorizontalDestinations(
                chips: const [
                  'Beach',
                  'Mountains',
                  'City Lights',
                  'Road Trips',
                ],
              ),
              const SizedBox(height: 24),
              _SectionHeader(
                title: 'Curated For You',
                subtitle: 'Based on your recent interests',
              ),
              const SizedBox(height: 12),
              _RecommendationCard(),
            ],
          ),
        ),
      );
    } else if (_currentIndex == 3) {
      return const _ProfileTab();
    } else {
      // Simple placeholders for remaining tabs for now.
      final labels = ['Home', 'My Trips', 'Favorites', 'Profile'];
      return Center(
        child: Text(
          '${labels[_currentIndex]} coming soon',
          style: const TextStyle(color: Colors.white70, fontSize: 16),
        ),
      );
    }
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: .05),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white.withValues(alpha: .08)),
      ),
      child: Row(
        children: [
          Icon(Icons.search_rounded, color: Colors.white.withValues(alpha: .9)),
          const SizedBox(width: 10),
          const Expanded(
            child: Text(
              'Search destinations, themes, budgets...',
              style: TextStyle(color: Colors.white70, fontSize: 14),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Text(
              'AI Filter',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar() {
    return BottomAppBar(
      color: AppColors.dark,
      shape: const CircularNotchedRectangle(),
      notchMargin: 6,
      child: SizedBox(
        height: 64,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _BottomItem(
              icon: Icons.home_filled,
              label: 'Home',
              selected: _currentIndex == 0,
              onTap: () => setState(() => _currentIndex = 0),
            ),
            SizedBox(
              width: 107,
              child: _BottomItem(
                icon: Icons.card_travel_rounded,
                label: 'My Trips',
                selected: _currentIndex == 1,
                onTap: () => setState(() => _currentIndex = 1),
              ),
            ),
            _BottomItem(
              icon: Icons.favorite,
              label: 'Favorites',
              selected: _currentIndex == 2,
              onTap: () => setState(() => _currentIndex = 2),
            ),
            const SizedBox(width: 0, height: 20), // space for FABs
            _BottomItem(
              icon: Icons.person_outline_rounded,
              label: 'Profile',
              selected: _currentIndex == 3,
              onTap: () => setState(() => _currentIndex = 3),
            ),
          ],
        ),
      ),
    );
  }
}

class _BottomItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _BottomItem({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final color = selected
        ? (isDark ? AppColors.accent : AppColors.lightPrimary)
        : (isDark ? Colors.white70 : AppColors.lightTextSecondary);
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: color,
                fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final String subtitle;

  const _SectionHeader({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 2),
            Text(subtitle, style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
        TextButton(onPressed: () {}, child: const Text('View all')),
      ],
    );
  }
}

class _HorizontalDestinations extends StatelessWidget {
  final List<String> chips;

  const _HorizontalDestinations({required this.chips});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final label = chips[index];
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: .06),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white.withValues(alpha: .12)),
            ),
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(width: 10),
        itemCount: chips.length,
      ),
    );
  }
}

class _HorizontalCards extends StatelessWidget {
  final List<(String, String)> items;

  const _HorizontalCards({required this.items});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final (title, subtitle) = items[index];
          return Container(
            width: 200,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF1F2937), Color(0xFF111827)],
              ),
              border: Border.all(color: Colors.white.withValues(alpha: .1)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  subtitle,
                  style: const TextStyle(color: Colors.white70, fontSize: 12),
                ),
                const Spacer(),
                Row(
                  children: const [
                    Icon(
                      Icons.trending_up_rounded,
                      size: 18,
                      color: AppColors.accent,
                    ),
                    SizedBox(width: 6),
                    Text(
                      'Smart picks',
                      style: TextStyle(
                        color: AppColors.accent,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(width: 12),
        itemCount: items.length,
      ),
    );
  }
}

class _RecommendationCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient: const LinearGradient(
          colors: [AppColors.primary, AppColors.accent],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Not sure where to go next?',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Tell TravelWise what you like and let AI design your next escape.',
            style: TextStyle(color: Colors.white70, fontSize: 13),
          ),
          const SizedBox(height: 14),
          PrimaryButton(
            label: 'Start a new AI trip',
            onPressed: () {
              Navigator.pushNamed(context, ItineraryFormScreen.routeName);
            },
            filled: true,
          ),
        ],
      ),
    );
  }
}

class _ProfileTab extends StatelessWidget {
  const _ProfileTab();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Profile',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 20),
            _ProfileHeaderCard(),
            const SizedBox(height: 20),
            _ProfileOptionsCard(),
          ],
        ),
      ),
    );
  }
}

class _ProfileHeaderCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .4),
            blurRadius: 24,
            offset: const Offset(0, 16),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: Theme.of(context).brightness == Brightness.dark
                    ? [AppColors.primary, AppColors.accent]
                    : [AppColors.lightPrimary, AppColors.lightSecondary],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: const Center(
              child: Icon(Icons.person, color: Colors.white, size: 40),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Traveler',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'traveler@example.com',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileOptionsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final divider = Divider(
      height: 1,
      color: Colors.white.withValues(alpha: .06),
    );

    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: .03),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withValues(alpha: .06)),
      ),
      child: Column(
        children: [
          _ProfileRow(
            icon: Icons.edit_outlined,
            label: 'Edit Profile',
            onTap: () {},
          ),
          divider,
          _ProfileRow(
            icon: Icons.card_travel_outlined,
            label: 'My Bookings',
            onTap: () {},
          ),
          divider,
          _ProfileRow(
            icon: Icons.credit_card_outlined,
            label: 'Payment Methods',
            onTap: () {},
          ),
          divider,
          _ProfileRow(
            icon: Icons.settings_outlined,
            label: 'Settings',
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const _ThemeSettingsPage()),
              );
            },
          ),
          divider,
          _ProfileRow(
            icon: Icons.help_outline_rounded,
            label: 'Help & Support',
            onTap: () {},
          ),
          divider,
          _ProfileRow(
            icon: Icons.logout,
            label: 'Logout',
            onTap: () {},
            isDestructive: true,
          ),
        ],
      ),
    );
  }
}

class _ProfileRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isDestructive;

  const _ProfileRow({
    required this.icon,
    required this.label,
    required this.onTap,
    this.isDestructive = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final color = isDestructive
        ? Colors.redAccent
        : (isDark ? Colors.white : AppColors.lightTextPrimary);
    final textColor = isDestructive
        ? Colors.redAccent
        : Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : AppColors.lightTextPrimary;

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          children: [
            Icon(icon, color: color),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                label,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: textColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white.withValues(alpha: .6)
                  : AppColors.lightTextSecondary,
            ),
          ],
        ),
      ),
    );
  }
}

class _ThemeSettingsPage extends StatefulWidget {
  const _ThemeSettingsPage();

  @override
  State<_ThemeSettingsPage> createState() => _ThemeSettingsPageState();
}

class _ThemeSettingsPageState extends State<_ThemeSettingsPage> {
  @override
  void initState() {
    super.initState();
    themeController.addListener(_onThemeChanged);
  }

  @override
  void dispose() {
    themeController.removeListener(_onThemeChanged);
    super.dispose();
  }

  void _onThemeChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: themeController,
      builder: (context, child) {
        final isDark = !themeController.isLight;

        return Scaffold(
          appBar: AppBar(title: const Text('Appearance')),
          body: SafeArea(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
              children: [
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(
                    isDark ? Icons.dark_mode : Icons.light_mode,
                    color: Theme.of(context).iconTheme.color,
                  ),
                  title: const Text('Dark theme'),
                  subtitle: const Text(
                    'Toggle between dark and light experience',
                  ),
                  trailing: Switch(
                    value: isDark,
                    onChanged: (_) {
                      themeController.toggle();
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
```