import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/primary_button.dart';

class ItineraryFormScreen extends StatelessWidget {
  const ItineraryFormScreen({super.key});

  static const String routeName = '/itinerary-form';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create AI Itinerary'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Tell TravelWise about your trip',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'For now this form is non-functional, but it shows how your AI planner page will look.',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 20),
              _FieldLabel('Destination'),
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
              _FieldLabel('Budget'),
              const SizedBox(height: 8),
              const _OutlinedInput(
                hintText: 'e.g. \$500 - \$1,000',
                icon: Icons.payments_outlined,
              ),
              const SizedBox(height: 16),
              _FieldLabel('Travel style'),
              const SizedBox(height: 8),
              const _ChoiceChips(
                options: ['Relaxed', 'Packed', 'Adventure', 'Romantic'],
              ),
              const SizedBox(height: 16),
              _FieldLabel('Trip length'),
              const SizedBox(height: 8),
              const _OutlinedInput(
                hintText: 'Number of days',
                icon: Icons.calendar_today_outlined,
              ),
              const SizedBox(height: 16),
              _FieldLabel('Travelers'),
              const SizedBox(height: 8),
              const _OutlinedInput(
                hintText: 'Solo, couple, family, friends...',
                icon: Icons.group_outlined,
              ),
              const SizedBox(height: 16),
              _FieldLabel('Must‑do experiences'),
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
  }
}

class _FieldLabel extends StatelessWidget {
  final String text;

  const _FieldLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 13,
        fontWeight: FontWeight.w600,
      ),
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
    return TextField(
      maxLines: maxLines,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: AppColors.accent),
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.white70),
        filled: true,
        fillColor: Colors.white.withValues(alpha: .05),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(
            color: Colors.white.withValues(alpha: .2),
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(18)),
          borderSide: BorderSide(
            color: AppColors.accent,
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

  const _DateInput({
    required this.label,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _FieldLabel(label),
        const SizedBox(height: 8),
        const _OutlinedInput(
          hintText: 'Select',
          icon: Icons.event_outlined,
        ),
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
              color: _selected == i ? Colors.white : Colors.white70,
              fontWeight: FontWeight.w500,
            ),
            selectedColor: AppColors.accent,
            backgroundColor: Colors.white.withValues(alpha: .06),
            side: BorderSide(
              color: _selected == i
                  ? AppColors.accent
                  : Colors.white.withValues(alpha: .18),
            ),
          ),
      ],
    );
  }
}


