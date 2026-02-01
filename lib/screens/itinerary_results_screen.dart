import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class ItineraryResultsScreen extends StatelessWidget {
  final Map<String, dynamic> itineraryData;
  final String destination;
  final int days;

  const ItineraryResultsScreen({
    super.key,
    required this.itineraryData,
    required this.destination,
    required this.days,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      appBar: AppBar(
        title: Text('$destination Itinerary'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: isDark
                    ? AppColors.primary.withValues(alpha: .15)
                    : AppColors.lightPrimary.withValues(alpha: .1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: isDark ? AppColors.accent : AppColors.lightPrimary,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        destination,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '$days-day itinerary',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Places to Visit
            if (itineraryData['places'] != null) ...[
              _SectionTitle('Places to Visit', Icons.place_outlined, context),
              const SizedBox(height: 12),
              ...((itineraryData['places'] as List).map((place) => _PlaceCard(
                    place: place,
                    isDark: isDark,
                  ))),
              const SizedBox(height: 24),
            ],

            // Hotels
            if (itineraryData['hotels'] != null) ...[
              _SectionTitle('Hotels', Icons.hotel_outlined, context),
              const SizedBox(height: 12),
              ...((itineraryData['hotels'] as List).map((hotel) => _HotelCard(
                    hotel: hotel,
                    isDark: isDark,
                  ))),
              const SizedBox(height: 24),
            ],

            // Itinerary by Day
            if (itineraryData['itinerary'] != null) ...[
              _SectionTitle('Daily Itinerary', Icons.calendar_today_outlined, context),
              const SizedBox(height: 12),
              ...((itineraryData['itinerary'] as List).map((day) => _DayCard(
                    day: day,
                    isDark: isDark,
                  ))),
              const SizedBox(height: 24),
            ],

            // Transportation
            if (itineraryData['transportation'] != null) ...[
              _SectionTitle('Transportation', Icons.directions_transit_outlined, context),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isDark
                      ? Colors.white.withValues(alpha: .05)
                      : AppColors.lightCard,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: (itineraryData['transportation'] as List)
                      .map((transport) => Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.check_circle_outline,
                                  size: 20,
                                  color: isDark ? AppColors.accent : AppColors.lightPrimary,
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    transport.toString(),
                                    style: Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ),
                              ],
                            ),
                          ))
                      .toList(),
                ),
              ),
              const SizedBox(height: 24),
            ],

            // Costs
            if (itineraryData['costs'] != null) ...[
              _SectionTitle('Estimated Costs', Icons.attach_money_outlined, context),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isDark
                      ? Colors.white.withValues(alpha: .05)
                      : AppColors.lightCard,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: (itineraryData['costs'] as List)
                      .map((cost) => Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Text(
                              cost.toString(),
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ))
                      .toList(),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  final IconData icon;
  final BuildContext context;

  const _SectionTitle(this.title, this.icon, this.context);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Row(
      children: [
        Icon(
          icon,
          color: isDark ? AppColors.accent : AppColors.lightPrimary,
          size: 24,
        ),
        const SizedBox(width: 8),
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
      ],
    );
  }
}

class _PlaceCard extends StatelessWidget {
  final dynamic place;
  final bool isDark;

  const _PlaceCard({required this.place, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withValues(alpha: .05)
            : AppColors.lightCard,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  place['name']?.toString() ?? 'Unknown Place',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              if (place['time'] != null)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: isDark
                        ? AppColors.primary.withValues(alpha: .2)
                        : AppColors.lightPrimary.withValues(alpha: .1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    place['time'].toString(),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: isDark ? AppColors.accent : AppColors.lightPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
            ],
          ),
          if (place['details'] != null) ...[
            const SizedBox(height: 8),
            Text(
              place['details'].toString(),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
          if (place['pricing'] != null) ...[
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(
                  Icons.payments_outlined,
                  size: 16,
                  color: isDark ? AppColors.accent : AppColors.lightPrimary,
                ),
                const SizedBox(width: 4),
                Text(
                  place['pricing'].toString(),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _HotelCard extends StatelessWidget {
  final dynamic hotel;
  final bool isDark;

  const _HotelCard({required this.hotel, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withValues(alpha: .05)
            : AppColors.lightCard,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  hotel['name']?.toString() ?? 'Unknown Hotel',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              if (hotel['rating'] != null)
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      size: 16,
                      color: isDark ? AppColors.accent : AppColors.lightPrimary,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      hotel['rating'].toString(),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ],
                ),
            ],
          ),
          if (hotel['address'] != null) ...[
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(
                  Icons.location_on_outlined,
                  size: 16,
                  color: isDark ? AppColors.accent : AppColors.lightPrimary,
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    hotel['address'].toString(),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              ],
            ),
          ],
          if (hotel['price'] != null) ...[
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(
                  Icons.attach_money,
                  size: 16,
                  color: isDark ? AppColors.accent : AppColors.lightPrimary,
                ),
                const SizedBox(width: 4),
                Text(
                  hotel['price'].toString(),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ],
            ),
          ],
          if (hotel['amenities'] != null && (hotel['amenities'] as List).isNotEmpty) ...[
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 4,
              children: (hotel['amenities'] as List)
                  .map((amenity) => Chip(
                        label: Text(
                          amenity.toString(),
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        backgroundColor: isDark
                            ? AppColors.primary.withValues(alpha: .15)
                            : AppColors.lightPrimary.withValues(alpha: .1),
                        padding: EdgeInsets.zero,
                        labelPadding: const EdgeInsets.symmetric(horizontal: 8),
                      ))
                  .toList(),
            ),
          ],
          if (hotel['description'] != null) ...[
            const SizedBox(height: 8),
            Text(
              hotel['description'].toString(),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ],
      ),
    );
  }
}

class _DayCard extends StatelessWidget {
  final dynamic day;
  final bool isDark;

  const _DayCard({required this.day, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withValues(alpha: .05)
            : AppColors.lightCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark
              ? AppColors.primary.withValues(alpha: .3)
              : AppColors.lightPrimary.withValues(alpha: .3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: isDark
                      ? AppColors.primary.withValues(alpha: .2)
                      : AppColors.lightPrimary.withValues(alpha: .1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Day ${day['day'] ?? '?'}',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: isDark ? AppColors.accent : AppColors.lightPrimary,
                      ),
                ),
              ),
            ],
          ),
          if (day['activities'] != null) ...[
            const SizedBox(height: 12),
            ...((day['activities'] as List).map((activity) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.check_circle_outline,
                        size: 18,
                        color: isDark ? AppColors.accent : AppColors.lightPrimary,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          activity.toString(),
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                ))),
          ],
        ],
      ),
    );
  }
}

