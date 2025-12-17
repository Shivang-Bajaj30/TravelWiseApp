import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
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
      backgroundColor: AppColors.dark,
      appBar: AppBar(
        backgroundColor: AppColors.dark,
        elevation: 0,
        titleSpacing: 8,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome,',
              style: Theme.of(
                context,
              ).textTheme.labelLarge?.copyWith(color: Colors.white70),
            ),
            Text(
              _username,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
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
        top: false, bottom: true,
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
                      color: AppColors.dark,
                    ),
                  ),
                  // Navigation row
                  Positioned.fill(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: List.generate(4, (i) => Expanded(
                        child: _BottomItem(
                          icon: [Icons.home_filled, Icons.card_travel_rounded, Icons.favorite, Icons.person_outline_rounded][i],
                          label: ['Home', 'My Trips', 'Favorites', 'Profile'][i],
                          selected: _currentIndex == i,
                          onTap: () => setState(() => _currentIndex = i),
                        ),
                      )),
                    ),
                  ),
                  // Floating FAB, half-overlapping above the nav bar
                  Positioned(
                    left: (width - fabSize) / 2,
                    bottom: -fabSize / 2 + 65, // Half above bar, 8px for a bit more visual cushion
                    child: GestureDetector(
                      onTap: () => Navigator.pushNamed(context, ItineraryFormScreen.routeName),
                      child: Container(
                        width: fabSize,
                        height: fabSize,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.accent,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black38,
                              blurRadius: 8,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: const Center(
                          child: Icon(Icons.auto_awesome, color: Colors.white, size: 24),
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
                chips: const ['Beach', 'Mountains', 'City Lights', 'Road Trips'],
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
    final color = selected ? AppColors.accent : Colors.white70;
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
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              subtitle,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: Colors.white70),
            ),
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
        color: Colors.white.withValues(alpha: .04),
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
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [AppColors.primary, AppColors.accent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: const Center(
              child: Icon(
                Icons.person,
                color: Colors.white,
                size: 40,
              ),
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
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: 6),
                Text(
                  'traveler@example.com',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white70,
                      ),
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
            onTap: () {},
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
    final color = isDestructive ? Colors.redAccent : Colors.white;
    final textColor = isDestructive ? Colors.redAccent : Colors.white;

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
              color: Colors.white.withValues(alpha: .6),
            ),
          ],
        ),
      ),
    );
  }
}
