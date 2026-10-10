import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/styles/stroke_rounded.dart';

import '../../../core/theme/app_fonts.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/app_huge_icon.dart';
import '../../../core/widgets/app_info_row.dart';
import '../../../core/widgets/app_page_header.dart';
import '../../../core/widgets/app_surface.dart';
import '../../../core/widgets/custom_scaffold.dart';
import '../../../data/models/booking.dart';
import '../../home/controllers/home_controller.dart';

class BookingSuccessView extends StatelessWidget {
  const BookingSuccessView({super.key, required this.booking});

  final Booking booking;

  void _backToHome(int tabIndex) {
    Get.find<HomeController>().selectTab(tabIndex);
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.paddingOf(context).bottom;

    return CustomScaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(
                  AppPageHeader.pagePadding,
                  48,
                  AppPageHeader.pagePadding,
                  24,
                ),
                children: [
                  Center(
                    child: Container(
                      width: 96,
                      height: 96,
                      decoration: const BoxDecoration(
                        color: AppTheme.primaryLight,
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: AppHugeIcon(
                          icon: HugeIconsStrokeRounded.checkmarkCircle02,
                          size: 48,
                          color: AppTheme.primary,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'تم تأكيد حجزك!',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'احتفظ برقم الحجز وأبرزه للمشرف عند نقطة التجمّع.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 28),
                  AppSurface(
                    child: Column(
                      children: [
                        const Text(
                          'رقم الحجز',
                          style: TextStyle(
                            fontFamily: AppFonts.somarSans,
                            fontSize: 12,
                            color: AppTheme.textSecondary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          booking.reference,
                          textDirection: TextDirection.ltr,
                          style: const TextStyle(
                            fontFamily: AppFonts.somarSans,
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 2,
                            color: AppTheme.primary,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Divider(height: 1, color: AppTheme.border),
                        const SizedBox(height: 6),
                        AppInfoRow(label: 'الرحلة', value: booking.trip.title),
                        AppInfoRow(label: 'الموعد', value: booking.dateLabel),
                        AppInfoRow(
                          label: 'المسافرون',
                          value: travelersLabel(booking.travelers),
                        ),
                        AppInfoRow(
                          label: 'التجمّع',
                          value: booking.trip.meetingPoint,
                        ),
                        AppInfoRow(
                          label: 'الإجمالي',
                          value: booking.totalLabel,
                          emphasized: true,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                AppPageHeader.pagePadding,
                12,
                AppPageHeader.pagePadding,
                bottom + 12,
              ),
              child: Column(
                children: [
                  FilledButton(
                    onPressed: () => _backToHome(1),
                    child: const Text('عرض رحلاتي'),
                  ),
                  const SizedBox(height: 4),
                  TextButton(
                    onPressed: () => _backToHome(0),
                    child: const Text('العودة للرئيسية'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
