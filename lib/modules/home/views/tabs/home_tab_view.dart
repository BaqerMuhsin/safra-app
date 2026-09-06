import 'package:flutter/material.dart';
import 'package:hugeicons/styles/stroke_rounded.dart';

import '../../../../core/theme/app_fonts.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/app_huge_icon.dart';
import '../../../../core/widgets/app_page_header.dart';
import '../widgets/trip_section.dart';

class HomeTabView extends StatelessWidget {
  const HomeTabView({super.key});

  static const _northTrips = <TripSample>[
    (
      title: 'رحلة أربيل التاريخية',
      location: 'أربيل · كردستان',
      duration: '3 أيام',
      date: 'السبت · 13 أيلول',
      price: '120,000 د.ع',
      rating: '4.9',
      image:
          'https://images.unsplash.com/photo-1469854523086-cc02fe5d8800?w=800&q=80',
    ),
    (
      title: 'سليمانية والجبال',
      location: 'سليمانية · كردستان',
      duration: 'يومان',
      date: 'الأحد · 14 أيلول',
      price: '110,000 د.ع',
      rating: '4.8',
      image:
          'https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?w=800&q=80',
    ),
    (
      title: 'دهوك والطبيعة',
      location: 'دهوك · كردستان',
      duration: 'يومان',
      date: 'الإثنين · 15 أيلول',
      price: '95,000 د.ع',
      rating: '4.7',
      image:
          'https://images.unsplash.com/photo-1501785888041-af3ef285b470?w=800&q=80',
    ),
  ];

  static const _shrinesTrips = <TripSample>[
    (
      title: 'زيارة العتبات المقدسة',
      location: 'النجف · كربلاء',
      duration: 'يوم واحد',
      date: 'الأحد · 14 أيلول',
      price: '45,000 د.ع',
      rating: '4.7',
      image:
          'https://images.unsplash.com/photo-1488646953014-85cb44e25828?w=800&q=80',
    ),
    (
      title: 'مسار الكاظمين وسامراء',
      location: 'بغداد · سامراء',
      duration: 'يوم واحد',
      date: 'الثلاثاء · 16 أيلول',
      price: '35,000 د.ع',
      rating: '4.6',
      image:
          'https://images.unsplash.com/photo-1523906834658-6e24ef2386f9?w=800&q=80',
    ),
    (
      title: 'رحلة العتبات الشاملة',
      location: 'النجف · كربلاء · الكاظمين',
      duration: '3 أيام',
      date: 'الخميس · 18 أيلول',
      price: '90,000 د.ع',
      rating: '4.9',
      image:
          'https://images.unsplash.com/photo-1476514525535-07fb3b4ae5f1?w=800&q=80',
    ),
  ];

  static const _southTrips = <TripSample>[
    (
      title: 'جولة الأهوار الجنوبية',
      location: 'الأهوار · ذي قار',
      duration: 'يومان',
      date: 'الجمعة · 12 أيلول',
      price: '85,000 د.ع',
      rating: '4.8',
      image:
          'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800&q=80',
    ),
    (
      title: 'شاطئ الفاو واسترخاء',
      location: 'البصرة · الفاو',
      duration: 'يومان',
      date: 'الإثنين · 15 أيلول',
      price: '95,000 د.ع',
      rating: '4.6',
      image:
          'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=800&q=80',
    ),
    (
      title: 'البصرة التاريخية',
      location: 'البصرة',
      duration: 'يوم واحد',
      date: 'الأربعاء · 17 أيلول',
      price: '55,000 د.ع',
      rating: '4.5',
      image:
          'https://images.unsplash.com/photo-1500530855697-b586d89ba3ee?w=800&q=80',
    ),
  ];

  static const _natureTrips = <TripSample>[
    (
      title: 'شلالات بيخال',
      location: 'أربيل · شقلاوة',
      duration: 'يوم واحد',
      date: 'السبت · 20 أيلول',
      price: '40,000 د.ع',
      rating: '4.8',
      image:
          'https://images.unsplash.com/photo-1432405972618-c60b0225b8f9?w=800&q=80',
    ),
    (
      title: 'بحيرة دوكان',
      location: 'السليمانية',
      duration: 'يومان',
      date: 'الجمعة · 19 أيلول',
      price: '75,000 د.ع',
      rating: '4.7',
      image:
          'https://images.unsplash.com/photo-1439066615861-d1af74d74000?w=800&q=80',
    ),
  ];

  @override
  Widget build(BuildContext context) {
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
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppTheme.surface,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: AppTheme.border),
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
                            'الوجهة · التاريخ · عدد الأشخاص',
                            style: TextStyle(
                              fontFamily: AppFonts.somarSans,
                              fontSize: 13,
                              color: AppTheme.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 28),
        TripSection(
          title: 'رحلات شمال العراق',
          subtitle: 'أربيل، سليمانية، دهوك والمزيد',
          trips: _northTrips,
          onSeeAll: () {},
        ),
        const SizedBox(height: 28),
        TripSection(
          title: 'رحلات العتبات المقدسة',
          subtitle: 'النجف، كربلاء، الكاظمين وسامراء',
          trips: _shrinesTrips,
          onSeeAll: () {},
        ),
        const SizedBox(height: 28),
        TripSection(
          title: 'رحلات جنوب العراق',
          subtitle: 'الأهوار، البصرة والفاو',
          trips: _southTrips,
          onSeeAll: () {},
        ),
        const SizedBox(height: 28),
        TripSection(
          title: 'رحلات الطبيعة',
          subtitle: 'شلالات وبحيرات ومناظر خلابة',
          trips: _natureTrips,
          onSeeAll: () {},
        ),
      ],
    );
  }
}
