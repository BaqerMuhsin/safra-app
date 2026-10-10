import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/styles/stroke_rounded.dart';

import '../../../../app/routes/app_routes.dart';
import '../../../../core/services/trips_service.dart';
import '../../../../core/theme/app_fonts.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/app_huge_icon.dart';
import '../../../../core/widgets/app_page_header.dart';
import '../../../../core/widgets/app_surface.dart';
import '../../../../data/models/trip.dart';
import '../widgets/trip_section.dart';

class HomeTabView extends StatelessWidget {
  const HomeTabView({super.key});

  @override
  Widget build(BuildContext context) {
    final trips = Get.find<TripsService>();

    return ListView(
      padding: const EdgeInsets.only(top: 24, bottom: 120),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppPageHeader.pagePadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'اكتشف رحلتك',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 8),
              Text(
                'رحلات سياحية داخل العراق تناسب كل الأذواق',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 24),
              AppSurface(
                padding: const EdgeInsets.all(20),
                onTap: () => Get.toNamed(
                  AppRoutes.trips,
                  arguments: {'focusSearch': true},
                ),
                child: Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: AppTheme.primaryLight,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Center(
                        child: AppHugeIcon(
                          icon: HugeIconsStrokeRounded.mapsLocation01,
                          size: 22,
                          color: AppTheme.primary,
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'ابحث عن رحلة سياحية',
                            style: TextStyle(
                              fontFamily: AppFonts.elMessiri,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: AppTheme.textStrong,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'الوجهة · الشركة · نوع الرحلة',
                            style: TextStyle(
                              fontFamily: AppFonts.somarSans,
                              fontSize: 13,
                              color: AppTheme.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const AppHugeIcon(
                      icon: HugeIconsStrokeRounded.search01,
                      size: 20,
                      color: AppTheme.textHint,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        for (final category in TripCategory.values) ...[
          const SizedBox(height: 28),
          TripSection(
            title: category.title,
            subtitle: category.subtitle,
            trips: trips.byCategory(category),
            onSeeAll: () =>
                Get.toNamed(AppRoutes.trips, arguments: {'category': category}),
            onTripTap: (trip) =>
                Get.toNamed(AppRoutes.tripDetails, arguments: trip),
          ),
        ],
      ],
    );
  }
}
