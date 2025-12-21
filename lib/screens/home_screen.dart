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

  final String _username = 'Traveler';

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: themeController,
      builder: (context, child) {
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
          bottomNavigationBar: SafeArea(
            top: false,
            bottom: true,
            child: LayoutBuilder(
              builder: (context, constraints) {
                final width = constraints.maxWidth;
                final fabSize = 44.0;
                final barHeight = 64.0;
                final isDark = !themeController.isLight;

                return SizedBox(
                  height: barHeight,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Positioned.fill(
                        child: Container(
                          color: Theme.of(
                            context,
                          ).bottomNavigationBarTheme.backgroundColor,
                        ),
                      ),
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
                      Positioned(
                        left: (width - fabSize) / 2,
                        bottom: -fabSize / 2 + 65,
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
                              color: isDark
                                  ? AppColors.accent
                                  : AppColors.lightPrimary,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black38,
                                  blurRadius: 8,
                                  offset: const Offset(0, 3),
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
      },
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
              _buildSearchBar(context),
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
      final labels = ['Home', 'My Trips', 'Favorites', 'Profile'];
      return Center(
        child: Text(
          '${labels[_currentIndex]} coming soon',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      );
    }
  }

  Widget _buildSearchBar(BuildContext context) {
    final isDark = !themeController.isLight;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withValues(alpha: .05)
            : AppColors.lightCard,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: .08)
              : AppColors.lightAccent.withValues(alpha: .2),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.search_rounded,
            color: isDark
                ? Colors.white.withValues(alpha: .9)
                : AppColors.lightTextPrimary,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'Search destinations, themes, budgets...',
              style: TextStyle(
                color: isDark ? Colors.white70 : AppColors.lightTextSecondary,
                fontSize: 14,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: isDark ? AppColors.primary : AppColors.lightPrimary,
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
    final isDark = !themeController.isLight;
    return SizedBox(
      height: 42,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final label = chips[index];
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: isDark
                  ? Colors.white.withValues(alpha: .06)
                  : AppColors.lightCard,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isDark
                    ? Colors.white.withValues(alpha: .12)
                    : AppColors.lightAccent.withValues(alpha: .2),
              ),
            ),
            child: Text(
              label,
              style: TextStyle(
                color: isDark ? Colors.white : AppColors.lightTextPrimary,
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
    final isDark = !themeController.isLight;
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
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: isDark
                    ? [const Color(0xFF1F2937), const Color(0xFF111827)]
                    : [AppColors.lightCard, AppColors.lightBackground],
              ),
              border: Border.all(
                color: isDark
                    ? Colors.white.withValues(alpha: .1)
                    : AppColors.lightAccent.withValues(alpha: .1),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: isDark ? Colors.white : AppColors.lightTextPrimary,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: isDark
                        ? Colors.white70
                        : AppColors.lightTextSecondary,
                    fontSize: 12,
                  ),
                ),
                const Spacer(),
                Row(
                  children: [
                    Icon(
                      Icons.trending_up_rounded,
                      size: 18,
                      color: isDark ? AppColors.accent : AppColors.lightPrimary,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'Smart picks',
                      style: TextStyle(
                        color: isDark
                            ? AppColors.accent
                            : AppColors.lightPrimary,
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
    final isDark = !themeController.isLight;
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient: LinearGradient(
          colors: isDark
              ? [AppColors.primary, AppColors.accent]
              : [AppColors.lightPrimary, AppColors.lightSecondary],
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
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700),
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
    final isDark = !themeController.isLight;
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
                colors: isDark
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
    final isDark = !themeController.isLight;
    final divider = Divider(
      height: 1,
      color: isDark
          ? Colors.white.withValues(alpha: .06)
          : AppColors.lightAccent.withValues(alpha: .1),
    );

    return Container(
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withValues(alpha: .03)
            : AppColors.lightCard,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: .06)
              : AppColors.lightAccent.withValues(alpha: .1),
        ),
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
        : (isDark ? Colors.white : AppColors.lightTextPrimary);

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
              color: isDark
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
