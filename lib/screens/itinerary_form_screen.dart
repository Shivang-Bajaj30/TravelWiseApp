import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/theme_controller.dart';
import '../widgets/primary_button.dart';

class ItineraryFormScreen extends StatelessWidget {
  const ItineraryFormScreen({super.key});

  static const String routeName = '/itinerary-form';

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: themeController,
      builder: (context, child) {
        final isDark = !themeController.isLight;

        return Scaffold(
          appBar: AppBar(title: const Text('Create AI Itinerary')),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tell TravelWise about your trip',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'For now this form is non-functional, but it shows how your AI planner page will look.',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: isDark
                          ? Colors.white70
                          : AppColors.lightTextSecondary,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const _FieldLabel('Destination'),
                  const SizedBox(height: 8),
                  const _OutlinedInput(
                    hintText: 'Where do you want to go?',
                    icon: Icons.location_on_outlined,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: const [
                      Expanded(
                        child: _DateInput(
                          label: 'Start date',
                          hintText: 'Select',
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: _DateInput(
                          label: 'End date',
                          hintText: 'Select',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const _FieldLabel('Budget'),
                  const SizedBox(height: 8),
                  const _OutlinedInput(
                    hintText: 'e.g. \$500 - \$1,000',
                    icon: Icons.payments_outlined,
                  ),
                  const SizedBox(height: 16),
                  const _FieldLabel('Travel style'),
                  const SizedBox(height: 8),
                  const _ChoiceChips(
                    options: ['Relaxed', 'Packed', 'Adventure', 'Romantic'],
                  ),
                  const SizedBox(height: 16),
                  const _FieldLabel('Trip length'),
                  const SizedBox(height: 8),
                  const _OutlinedInput(
                    hintText: 'Number of days',
                    icon: Icons.calendar_today_outlined,
                  ),
                  const SizedBox(height: 16),
                  const _FieldLabel('Travelers'),
                  const SizedBox(height: 8),
                  const _OutlinedInput(
                    hintText: 'Solo, couple, family, friends...',
                    icon: Icons.group_outlined,
                  ),
                  const SizedBox(height: 16),
                  const _FieldLabel('Must‑do experiences'),
                  const SizedBox(height: 8),
                  const _OutlinedInput(
                    hintText: 'Food, nightlife, museums, nature...',
                    icon: Icons.lightbulb_outline,
                    maxLines: 3,
                  ),
                  const SizedBox(height: 28),
                  PrimaryButton(
                    label: 'Generate AI Itinerary',
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: AppColors.primary,
                          content: Text(
                            'AI generation will be wired here later. For now this is just the layout.',
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _FieldLabel extends StatelessWidget {
  final String text;

  const _FieldLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(
        context,
      ).textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w600),
    );
  }
}

class _OutlinedInput extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final int maxLines;

  const _OutlinedInput({
    required this.hintText,
    required this.icon,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = !themeController.isLight;

    return TextField(
      maxLines: maxLines,
      style: Theme.of(context).textTheme.bodyMedium,
      decoration: InputDecoration(
        prefixIcon: Icon(
          icon,
          color: isDark ? AppColors.accent : AppColors.lightAccent,
        ),
        hintText: hintText,
        hintStyle: TextStyle(
          color: isDark ? Colors.white70 : AppColors.lightTextSecondary,
        ),
        filled: true,
        fillColor: isDark
            ? Colors.white.withValues(alpha: .05)
            : AppColors.lightCard,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(
            color: isDark
                ? Colors.white.withValues(alpha: .2)
                : AppColors.lightAccent.withValues(alpha: .2),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(
            color: isDark ? AppColors.accent : AppColors.lightPrimary,
            width: 1.4,
          ),
        ),
      ),
    );
  }
}

class _DateInput extends StatelessWidget {
  final String label;
  final String hintText;

  const _DateInput({required this.label, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _FieldLabel(label),
        const SizedBox(height: 8),
        const _OutlinedInput(hintText: 'Select', icon: Icons.event_outlined),
      ],
    );
  }
}

class _ChoiceChips extends StatefulWidget {
  final List<String> options;

  const _ChoiceChips({required this.options});

  @override
  State<_ChoiceChips> createState() => _ChoiceChipsState();
}

class _ChoiceChipsState extends State<_ChoiceChips> {
  int? _selected;

  @override
  Widget build(BuildContext context) {
    final isDark = !themeController.isLight;

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        for (var i = 0; i < widget.options.length; i++)
          ChoiceChip(
            label: Text(widget.options[i]),
            selected: _selected == i,
            onSelected: (_) {
              setState(() => _selected = i);
            },
            labelStyle: TextStyle(
              color: _selected == i
                  ? Colors.white
                  : (isDark ? Colors.white70 : AppColors.lightTextSecondary),
              fontWeight: FontWeight.w500,
            ),
            selectedColor: isDark ? AppColors.accent : AppColors.lightPrimary,
            backgroundColor: isDark
                ? Colors.white.withValues(alpha: .06)
                : AppColors.lightCard,
            side: BorderSide(
              color: _selected == i
                  ? (isDark ? AppColors.accent : AppColors.lightPrimary)
                  : (isDark
                        ? Colors.white.withValues(alpha: .18)
                        : AppColors.lightAccent.withValues(alpha: .2)),
            ),
          ),
      ],
    );
  }
}
