import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/styles/stroke_rounded.dart';

import '../../../../app/routes/app_routes.dart';
import '../../../../core/services/bookings_service.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/app_choice_chips.dart';
import '../../../../core/widgets/app_empty_state.dart';
import '../../../../core/widgets/app_page_header.dart';
import '../../../../core/widgets/trip_card.dart';
import '../../controllers/home_controller.dart';

class TripsTabView extends StatefulWidget {
  const TripsTabView({super.key});

  @override
  State<TripsTabView> createState() => _TripsTabViewState();
}

class _TripsTabViewState extends State<TripsTabView> {
  var _segment = 0;

  @override
  Widget build(BuildContext context) {
    final service = Get.find<BookingsService>();

    return Obx(() {
      final bookings = _segment == 0 ? service.upcoming : service.past;

      return ListView(
        padding: const EdgeInsets.fromLTRB(
          AppPageHeader.pagePadding,
          24,
          AppPageHeader.pagePadding,
          120,
        ),
        children: [
          Text('رحلاتي', style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 8),
          Text(
            'حجوزاتك السياحية الحالية والسابقة',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 16),
          AppSegmentedTabs(
            labels: const ['القادمة', 'السابقة'],
            index: _segment,
            onChanged: (i) => setState(() => _segment = i),
          ),
          const SizedBox(height: 20),
          if (bookings.isEmpty)
            AppEmptyState(
              icon: HugeIconsStrokeRounded.ticket01,
              title: _segment == 0
                  ? 'لا توجد رحلات قادمة'
                  : 'لا توجد رحلات سابقة',
              message: _segment == 0
                  ? 'احجز رحلتك القادمة وستظهر هنا'
                  : 'رحلاتك المكتملة والملغاة تظهر هنا',
              actionLabel: _segment == 0 ? 'تصفّح الرحلات' : null,
              onAction: () => Get.find<HomeController>().selectTab(0),
            )
          else
            for (var i = 0; i < bookings.length; i++) ...[
              if (i > 0) const SizedBox(height: 12),
              TripCard(
                title: bookings[i].trip.title,
                location: bookings[i].trip.location,
                durationLabel: travelersLabel(bookings[i].travelers),
                dateLabel: bookings[i].dateLabel,
                priceLabel: bookings[i].totalLabel,
                ratingLabel: bookings[i].trip.rating,
                statusLabel: bookings[i].status.label,
                statusColor: bookings[i].status.color,
                imageUrl: bookings[i].trip.imageUrl,
                onTap: () => Get.toNamed(
                  AppRoutes.bookingDetails,
                  arguments: bookings[i].id,
                ),
              ),
            ],
        ],
      );
    });
  }
}
