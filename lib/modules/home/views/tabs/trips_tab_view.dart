import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/app_page_header.dart';
import '../../../../core/widgets/trip_card.dart';

class TripsTabView extends StatelessWidget {
  const TripsTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(
        AppPageHeader.pagePadding,
        24,
        AppPageHeader.pagePadding,
        120,
      ),
      children: [
        Text(
          'رحلاتي',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 8),
        Text(
          'حجوزاتك السياحية الحالية والسابقة',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 20),
        TripCard(
          title: 'جولة الأهوار الجنوبية',
          location: 'الأهوار · ذي قار',
          durationLabel: 'يومان',
          dateLabel: 'الجمعة · 12 أيلول',
          priceLabel: '85,000 د.ع',
          ratingLabel: '4.8',
          statusLabel: 'قادمة',
          statusColor: AppTheme.primary,
          imageUrl:
              'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800&q=80',
          onTap: () {},
        ),
        const SizedBox(height: 12),
        TripCard(
          title: 'رحلة أربيل التاريخية',
          location: 'أربيل · كردستان',
          durationLabel: '3 أيام',
          dateLabel: 'الثلاثاء · 2 أيلول',
          priceLabel: '120,000 د.ع',
          ratingLabel: '4.9',
          statusLabel: 'مكتملة',
          statusColor: const Color(0xFF2A9D8F),
          imageUrl:
              'https://images.unsplash.com/photo-1469854523086-cc02fe5d8800?w=800&q=80',
          onTap: () {},
        ),
      ],
    );
  }
}
