import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/app_colors.dart';
import '../widgets/primary_button.dart';
import '../services/gemini_service.dart';
import 'itinerary_results_screen.dart';

class ItineraryFormScreen extends StatefulWidget {
  const ItineraryFormScreen({super.key});

  static const String routeName = '/itinerary-form';

  @override
  State<ItineraryFormScreen> createState() => _ItineraryFormScreenState();
}

class _ItineraryFormScreenState extends State<ItineraryFormScreen> {
  DateTime? _startDate;
  DateTime? _endDate;
  final TextEditingController _destinationController = TextEditingController();
  final TextEditingController _budgetController = TextEditingController();
  final TextEditingController _travelersController = TextEditingController();
  final TextEditingController _mustDoController = TextEditingController();
  final Set<int> _selectedTravelStyles = <int>{};
  bool _isGenerating = false;

  void _onStartDateChanged(DateTime? date) {
    setState(() {
      _startDate = date;
    });
  }

  void _onEndDateChanged(DateTime? date) {
    setState(() {
      _endDate = date;
    });
  }

  @override
  void dispose() {
    _destinationController.dispose();
    _budgetController.dispose();
    _travelersController.dispose();
    _mustDoController.dispose();
    super.dispose();
  }

  Future<void> _generateItinerary() async {
    // Validate required fields
    if (_destinationController.text.trim().isEmpty) {
      _showError('Please enter a destination');
      return;
    }
    if (_budgetController.text.trim().isEmpty) {
      _showError('Please enter a budget');
      return;
    }
    if (_travelersController.text.trim().isEmpty) {
      _showError('Please enter number of travelers');
      return;
    }
    if (_startDate == null || _endDate == null) {
      _showError('Please select start and end dates');
      return;
    }
    if (_selectedTravelStyles.isEmpty) {
      _showError('Please select at least one travel style');
      return;
    }

    setState(() {
      _isGenerating = true;
    });

    try {
      // Calculate days from selected dates
      final days = _endDate!.difference(_startDate!).inDays + 1;
      final travelStyles = ['Relaxed', 'Packed', 'Adventure', 'Romantic'];
      final travelWith = _selectedTravelStyles
          .map((i) => travelStyles[i])
          .join(', ');

      final result = await GeminiService.generateTripPlan(
        destination: _destinationController.text.trim(),
        budget: _budgetController.text.trim(),
        days: days,
        people: _travelersController.text.trim(),
        travelWith: travelWith,
      );

      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ItineraryResultsScreen(
              itineraryData: result,
              destination: _destinationController.text.trim(),
              days: days,
            ),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        _showError('Error generating itinerary: $e');
      }
    } finally {
      if (mounted) {
        setState(() {
          _isGenerating = false;
        });
      }
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(backgroundColor: AppColors.primary, content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    int? daysCount;
    int? nightsCount;

    if (_startDate != null &&
        _endDate != null &&
        (_endDate!.isAfter(_startDate!) ||
            _endDate!.isAtSameMomentAs(_startDate!))) {
      daysCount = _endDate!.difference(_startDate!).inDays + 1;
      nightsCount = daysCount > 1 ? daysCount - 1 : 0;
    }

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
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 6),
              Text(
                'Fill in the details below and we\'ll create a personalized itinerary for you.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 20),
              _FieldLabel('Destination'),
              const SizedBox(height: 8),
              _OutlinedInput(
                hintText: 'Where do you want to go?',
                icon: Icons.location_on_outlined,
                controller: _destinationController,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _DateInput(
                      label: 'Start date',
                      hintText: 'Select',
                      onDateChanged: _onStartDateChanged,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _DateInput(
                      label: 'End date',
                      hintText: 'Select',
                      onDateChanged: _onEndDateChanged,
                    ),
                  ),
                ],
              ),
              if (daysCount != null && nightsCount != null) ...[
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? AppColors.primary.withValues(alpha: .2)
                        : AppColors.lightPrimary.withValues(alpha: .1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.calendar_today_outlined,
                        size: 16,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? AppColors.accent
                            : AppColors.lightPrimary,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '$daysCount ${daysCount == 1 ? 'day' : 'days'}',
                        style: TextStyle(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? AppColors.accent
                              : AppColors.lightPrimary,
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                      if (nightsCount > 0) ...[
                        Text(
                          ' • ',
                          style: TextStyle(
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                ? AppColors.accent.withValues(alpha: .6)
                                : AppColors.lightPrimary.withValues(alpha: .6),
                            fontSize: 13,
                          ),
                        ),
                        Text(
                          '$nightsCount ${nightsCount == 1 ? 'night' : 'nights'}',
                          style: TextStyle(
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                ? AppColors.accent
                                : AppColors.lightPrimary,
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
              const SizedBox(height: 16),
              _FieldLabel('Budget'),
              const SizedBox(height: 8),
              _NumericInput(
                hintText: 'e.g. 500 or 1000',
                icon: Icons.payments_outlined,
                controller: _budgetController,
              ),
              const SizedBox(height: 16),
              _FieldLabel('Travel style'),
              const SizedBox(height: 8),
              _ChoiceChips(
                options: ['Relaxed', 'Packed', 'Adventure', 'Romantic'],
                onSelectionChanged: (selectedIndices) {
                  setState(() {
                    _selectedTravelStyles.clear();
                    _selectedTravelStyles.addAll(selectedIndices);
                  });
                },
              ),
              const SizedBox(height: 16),
              _FieldLabel('Travelers'),
              const SizedBox(height: 8),
              _OutlinedInput(
                hintText: 'Solo, couple, family, friends...',
                icon: Icons.group_outlined,
                controller: _travelersController,
              ),
              const SizedBox(height: 16),
              _FieldLabel('Must‑do experiences'),
              const SizedBox(height: 8),
              _OutlinedInput(
                hintText: 'Food, nightlife, museums, nature...',
                icon: Icons.lightbulb_outline,
                maxLines: 3,
                controller: _mustDoController,
              ),
              const SizedBox(height: 28),
              PrimaryButton(
                label: _isGenerating
                    ? 'Generating...'
                    : 'Generate AI Itinerary',
                onPressed: _isGenerating ? null : _generateItinerary,
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
      style: Theme.of(
        context,
      ).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600),
    );
  }
}

class _OutlinedInput extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final int maxLines;
  final TextEditingController? controller;

  const _OutlinedInput({
    required this.hintText,
    required this.icon,
    this.maxLines = 1,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return TextField(
      controller: controller,
      maxLines: maxLines,
      style: TextStyle(
        color: isDark ? Colors.white : AppColors.lightTextPrimary,
      ),
      decoration: InputDecoration(
        prefixIcon: Icon(
          icon,
          color: isDark ? AppColors.accent : AppColors.lightPrimary,
        ),
        hintText: hintText,
        hintStyle: TextStyle(
          color: isDark
              ? Colors.white.withValues(alpha: .7)
              : AppColors.lightTextSecondary,
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
                : AppColors.lightAccent.withValues(alpha: .3),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(18)),
          borderSide: BorderSide(
            color: isDark ? AppColors.accent : AppColors.lightPrimary,
            width: 1.4,
          ),
        ),
      ),
    );
  }
}

class _NumericInput extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final TextEditingController? controller;

  const _NumericInput({
    required this.hintText,
    required this.icon,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      style: TextStyle(
        color: isDark ? Colors.white : AppColors.lightTextPrimary,
      ),
      decoration: InputDecoration(
        prefixIcon: Icon(
          icon,
          color: isDark ? AppColors.accent : AppColors.lightPrimary,
        ),
        hintText: hintText,
        hintStyle: TextStyle(
          color: isDark
              ? Colors.white.withValues(alpha: .7)
              : AppColors.lightTextSecondary,
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
                : AppColors.lightAccent.withValues(alpha: .3),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(18)),
          borderSide: BorderSide(
            color: isDark ? AppColors.accent : AppColors.lightPrimary,
            width: 1.4,
          ),
        ),
      ),
    );
  }
}

class _DateInput extends StatefulWidget {
  final String label;
  final String hintText;
  final ValueChanged<DateTime?>? onDateChanged;

  const _DateInput({
    required this.label,
    required this.hintText,
    this.onDateChanged,
  });

  @override
  State<_DateInput> createState() => _DateInputState();
}

class _DateInputState extends State<_DateInput> {
  DateTime? _selectedDate;
  final TextEditingController _controller = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365 * 2)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(context).brightness == Brightness.dark
                ? ColorScheme.dark(
                    primary: AppColors.accent,
                    onPrimary: Colors.white,
                    surface: AppColors.dark,
                    onSurface: Colors.white,
                  )
                : ColorScheme.light(
                    primary: AppColors.lightPrimary,
                    onPrimary: Colors.white,
                    surface: Colors.white,
                    onSurface: AppColors.lightTextPrimary,
                  ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _controller.text = '${picked.day}/${picked.month}/${picked.year}';
      });
      widget.onDateChanged?.call(picked);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _FieldLabel(widget.label),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () => _selectDate(context),
          child: AbsorbPointer(
            child: TextField(
              controller: _controller,
              style: TextStyle(
                color: isDark ? Colors.white : AppColors.lightTextPrimary,
              ),
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.event_outlined,
                  color: isDark ? AppColors.accent : AppColors.lightPrimary,
                ),
                hintText: widget.hintText,
                hintStyle: TextStyle(
                  color: isDark
                      ? Colors.white.withValues(alpha: .7)
                      : AppColors.lightTextSecondary,
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
                        : AppColors.lightAccent.withValues(alpha: .3),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(18)),
                  borderSide: BorderSide(
                    color: isDark ? AppColors.accent : AppColors.lightPrimary,
                    width: 1.4,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ChoiceChips extends StatefulWidget {
  final List<String> options;
  final ValueChanged<Set<int>>? onSelectionChanged;

  const _ChoiceChips({required this.options, this.onSelectionChanged});

  @override
  State<_ChoiceChips> createState() => _ChoiceChipsState();
}

class _ChoiceChipsState extends State<_ChoiceChips> {
  final Set<int> _selectedIndices = <int>{};

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        for (var i = 0; i < widget.options.length; i++)
          ChoiceChip(
            label: Text(widget.options[i]),
            selected: _selectedIndices.contains(i),
            onSelected: (selected) {
              setState(() {
                if (selected) {
                  _selectedIndices.add(i);
                } else {
                  _selectedIndices.remove(i);
                }
              });
              widget.onSelectionChanged?.call(_selectedIndices);
            },
            labelStyle: TextStyle(
              color: _selectedIndices.contains(i)
                  ? Colors.white
                  : (isDark ? Colors.white70 : AppColors.lightTextPrimary),
              fontWeight: FontWeight.w500,
            ),
            selectedColor: isDark ? AppColors.accent : AppColors.lightPrimary,
            backgroundColor: isDark
                ? Colors.white.withValues(alpha: .06)
                : AppColors.lightCard,
            side: BorderSide(
              color: _selectedIndices.contains(i)
                  ? (isDark ? AppColors.accent : AppColors.lightPrimary)
                  : (isDark
                        ? Colors.white.withValues(alpha: .18)
                        : AppColors.lightAccent.withValues(alpha: .3)),
            ),
          ),
      ],
    );
  }
}
