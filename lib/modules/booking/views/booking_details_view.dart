import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/styles/stroke_rounded.dart';

import '../../../app/routes/app_routes.dart';
import '../../../core/services/bookings_service.dart';
import '../../../core/theme/app_fonts.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/app_feedback.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/app_empty_state.dart';
import '../../../core/widgets/app_info_row.dart';
import '../../../core/widgets/app_page_header.dart';
import '../../../core/widgets/app_surface.dart';
import '../../../core/widgets/custom_scaffold.dart';
import '../../../core/widgets/trip_card.dart';
import '../../../data/models/booking.dart';

class BookingDetailsView extends StatelessWidget {
  const BookingDetailsView({super.key, required this.bookingId});

  final String bookingId;

  Future<void> _cancel(BookingsService service, Booking booking) async {
    final confirmed = await showAppConfirm(
      title: 'إلغاء الحجز',
      message:
          'هل تريد إلغاء حجز «${booking.trip.title}»؟ لا يمكن التراجع عن هذا الإجراء.',
      confirmLabel: 'إلغاء الحجز',
      destructive: true,
    );
    if (!confirmed) return;
    service.cancel(booking.id);
    showAppSnack('تم إلغاء الحجز');
  }

  @override
  Widget build(BuildContext context) {
    final service = Get.find<BookingsService>();
    final textTheme = Theme.of(context).textTheme;

    return CustomScaffold(
      appBar: AppPageHeader(title: 'تفاصيل الحجز', onBack: Get.back),
      body: Obx(() {
        final booking = service.byId(bookingId);

        if (booking == null) {
          return const Center(
            child: AppEmptyState(
              icon: HugeIconsStrokeRounded.ticket01,
              title: 'الحجز غير موجود',
            ),
          );
        }

        final trip = booking.trip;

        return ListView(
          padding: EdgeInsets.fromLTRB(
            AppPageHeader.pagePadding,
            12,
            AppPageHeader.pagePadding,
            MediaQuery.paddingOf(context).bottom + 24,
          ),
          children: [
            TripCard(
              title: trip.title,
              location: trip.location,
              durationLabel: trip.durationLabel,
              dateLabel: booking.dateLabel,
              priceLabel: booking.totalLabel,
              ratingLabel: trip.rating,
              statusLabel: booking.status.label,
              statusColor: booking.status.color,
              imageUrl: trip.imageUrl,
              onTap: () => Get.toNamed(AppRoutes.tripDetails, arguments: trip),
            ),
            const SizedBox(height: 24),
            Text('معلومات الحجز', style: textTheme.titleMedium),
            const SizedBox(height: 10),
            AppSurface(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              child: Column(
                children: [
                  AppInfoRow(
                    icon: HugeIconsStrokeRounded.ticket01,
                    label: 'رقم الحجز',
                    value: booking.reference,
                    ltrValue: true,
                  ),
                  AppInfoRow(
                    icon: HugeIconsStrokeRounded.user,
                    label: 'المسافر الرئيسي',
                    value: booking.passengerName,
                  ),
                  AppInfoRow(
                    icon: HugeIconsStrokeRounded.userGroup,
                    label: 'عدد المسافرين',
                    value: travelersLabel(booking.travelers),
                  ),
                  AppInfoRow(
                    icon: HugeIconsStrokeRounded.calendar03,
                    label: 'الموعد',
                    value: booking.dateLabel,
                  ),
                  AppInfoRow(
                    icon: HugeIconsStrokeRounded.location01,
                    label: 'نقطة التجمّع',
                    value: trip.meetingPoint,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Text('الدفع', style: textTheme.titleMedium),
            const SizedBox(height: 10),
            AppSurface(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              child: Column(
                children: [
                  AppInfoRow(
                    icon: booking.paymentMethod.icon,
                    label: 'طريقة الدفع',
                    value: booking.paymentMethod.label,
                  ),
                  AppInfoRow(label: 'السعر للشخص', value: trip.priceLabel),
                  const Divider(height: 12, color: AppTheme.border),
                  AppInfoRow(
                    label: 'الإجمالي',
                    value: booking.totalLabel,
                    emphasized: true,
                  ),
                ],
              ),
            ),
            if (booking.status == BookingStatus.upcoming) ...[
              const SizedBox(height: 24),
              OutlinedButton(
                onPressed: () => _cancel(service, booking),
                style: OutlinedButton.styleFrom(
                  foregroundColor: BookingStatus.cancelled.color,
                  minimumSize: const Size.fromHeight(50),
                  side: BorderSide(color: BookingStatus.cancelled.color),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  textStyle: const TextStyle(
                    fontFamily: AppFonts.somarSans,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                child: const Text('إلغاء الحجز'),
              ),
            ],
          ],
        );
      }),
    );
  }
}
