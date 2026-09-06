import 'package:flutter/material.dart';

import '../../../../core/theme/app_fonts.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/app_page_header.dart';
import '../../../../core/widgets/trip_card.dart';

typedef TripSample = ({
  String title,
  String location,
  String duration,
  String date,
  String price,
  String rating,
  String image,
});

/// Horizontal trip carousel with section title + optional "عرض الكل".
class TripSection extends StatelessWidget {
  const TripSection({
    super.key,
    required this.title,
    required this.trips,
    this.subtitle,
    this.onSeeAll,
    this.cardWidth = 268,
  });

  final String title;
  final String? subtitle;
  final List<TripSample> trips;
  final VoidCallback? onSeeAll;
  final double cardWidth;

  static const double _listHeight = 262;

  @override
  Widget build(BuildContext context) {
    if (trips.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppPageHeader.pagePadding,
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    if (subtitle != null && subtitle!.isNotEmpty) ...[
                      const SizedBox(height: 2),
                      Text(
                        subtitle!,
                        style: const TextStyle(
                          fontFamily: AppFonts.somarSans,
                          fontSize: 12,
                          color: AppTheme.textSecondary,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              if (onSeeAll != null)
                TextButton(
                  onPressed: onSeeAll,
                  style: TextButton.styleFrom(
                    foregroundColor: AppTheme.primary,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: const Text(
                    'عرض الكل',
                    style: TextStyle(
                      fontFamily: AppFonts.somarSans,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: _listHeight,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(
              horizontal: AppPageHeader.pagePadding,
            ),
            itemCount: trips.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final trip = trips[index];
              return Align(
                alignment: Alignment.topCenter,
                child: TripCard(
                  width: cardWidth,
                  imageHeight: 118,
                  title: trip.title,
                  location: trip.location,
                  durationLabel: trip.duration,
                  dateLabel: trip.date,
                  priceLabel: trip.price,
                  ratingLabel: trip.rating,
                  imageUrl: trip.image,
                  onTap: () {},
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
