import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hugeicons/styles/stroke_rounded.dart';

import '../../../app/routes/app_routes.dart';
import '../../../core/services/trips_service.dart';
import '../../../core/theme/app_fonts.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/app_bottom_action_bar.dart';
import '../../../core/widgets/app_circle_icon_button.dart';
import '../../../core/widgets/app_huge_icon.dart';
import '../../../core/widgets/app_network_image.dart';
import '../../../core/widgets/app_page_header.dart';
import '../../../core/widgets/app_surface.dart';
import '../../../core/widgets/custom_scaffold.dart';
import '../../../data/models/trip.dart';

class TripDetailsView extends StatelessWidget {
  const TripDetailsView({super.key, required this.trip});

  final Trip trip;

  static const _imageHeight = 300.0;

  @override
  Widget build(BuildContext context) {
    final company = Get.find<TripsService>().companyById(trip.companyId);
    final textTheme = Theme.of(context).textTheme;
    final soldOut = trip.seatsLeft == 0;

    return CustomScaffold(
      useGradientBackground: false,
      backgroundColor: AppTheme.background,
      systemUiOverlayStyle: SystemUiOverlayStyle.light,
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.only(bottom: 24),
              children: [
                _Hero(trip: trip, height: _imageHeight),
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    AppPageHeader.pagePadding,
                    20,
                    AppPageHeader.pagePadding,
                    0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(trip.title, style: textTheme.headlineMedium),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const AppHugeIcon(
                            icon: HugeIconsStrokeRounded.mapsLocation01,
                            size: 16,
                            color: AppTheme.primary,
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              trip.location,
                              style: textTheme.bodyMedium,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: _FactTile(
                              icon: HugeIconsStrokeRounded.clock01,
                              label: 'المدة',
                              value: trip.durationLabel,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: _FactTile(
                              icon: HugeIconsStrokeRounded.calendar03,
                              label: 'الموعد',
                              value: trip.dateLabel.split(' · ').last,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: _FactTile(
                              icon: HugeIconsStrokeRounded.userGroup,
                              label: 'المقاعد',
                              value: '${trip.seatsLeft} متاح',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      AppSurface(
                        padding: const EdgeInsets.all(12),
                        onTap: () => Get.toNamed(
                          AppRoutes.companyDetails,
                          arguments: company,
                        ),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: SizedBox(
                                width: 44,
                                height: 44,
                                child: AppNetworkImage(
                                  url: company.imageUrl,
                                  iconSize: 20,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'الشركة المنظمة',
                                    style: TextStyle(
                                      fontFamily: AppFonts.somarSans,
                                      fontSize: 12,
                                      color: AppTheme.textSecondary,
                                    ),
                                  ),
                                  Text(
                                    company.name,
                                    style: const TextStyle(
                                      fontFamily: AppFonts.elMessiri,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                      color: AppTheme.textStrong,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const AppHugeIcon(
                              icon: HugeIconsStrokeRounded.arrowLeft01,
                              size: 18,
                              color: AppTheme.textHint,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text('عن الرحلة', style: textTheme.titleMedium),
                      const SizedBox(height: 8),
                      Text(trip.description, style: textTheme.bodyMedium),
                      const SizedBox(height: 24),
                      Text('أبرز المحطات', style: textTheme.titleMedium),
                      const SizedBox(height: 10),
                      for (final highlight in trip.highlights)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Row(
                            children: [
                              const AppHugeIcon(
                                icon: HugeIconsStrokeRounded.checkmarkCircle02,
                                size: 18,
                                color: AppTheme.primary,
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  highlight,
                                  style: const TextStyle(
                                    fontFamily: AppFonts.somarSans,
                                    fontSize: 14,
                                    color: AppTheme.textStrong,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      const SizedBox(height: 16),
                      Text('برنامج الرحلة', style: textTheme.titleMedium),
                      const SizedBox(height: 12),
                      for (var i = 0; i < trip.itinerary.length; i++)
                        _ItineraryRow(
                          index: i + 1,
                          step: trip.itinerary[i],
                          isLast: i == trip.itinerary.length - 1,
                        ),
                      const SizedBox(height: 16),
                      Text('تشمل الرحلة', style: textTheme.titleMedium),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          for (final item in trip.includes)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: AppTheme.primaryLight,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  AppHugeIcon(
                                    icon: item.icon,
                                    size: 16,
                                    color: AppTheme.primary,
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    item.label,
                                    style: const TextStyle(
                                      fontFamily: AppFonts.somarSans,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: AppTheme.primaryDark,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Text('نقطة التجمّع', style: textTheme.titleMedium),
                      const SizedBox(height: 10),
                      AppSurface(
                        padding: const EdgeInsets.all(14),
                        child: Row(
                          children: [
                            const AppHugeIcon(
                              icon: HugeIconsStrokeRounded.location01,
                              size: 20,
                              color: AppTheme.secondary,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                trip.meetingPoint,
                                style: const TextStyle(
                                  fontFamily: AppFonts.somarSans,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: AppTheme.textStrong,
                                ),
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
          AppBottomActionBar(
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'السعر للشخص',
                        style: TextStyle(
                          fontFamily: AppFonts.somarSans,
                          fontSize: 12,
                          color: AppTheme.textSecondary,
                        ),
                      ),
                      Text(
                        trip.priceLabel,
                        style: const TextStyle(
                          fontFamily: AppFonts.elMessiri,
                          fontSize: 19,
                          fontWeight: FontWeight.w700,
                          color: AppTheme.secondary,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 170,
                  child: FilledButton(
                    onPressed: soldOut
                        ? null
                        : () => Get.toNamed(AppRoutes.booking, arguments: trip),
                    child: Text(soldOut ? seatsLeftLabel(0) : 'احجز الآن'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Hero extends StatelessWidget {
  const _Hero({required this.trip, required this.height});

  final Trip trip;
  final double height;

  @override
  Widget build(BuildContext context) {
    final top = MediaQuery.paddingOf(context).top;

    return SizedBox(
      height: height,
      child: Stack(
        fit: StackFit.expand,
        children: [
          AppNetworkImage(url: trip.imageUrl, iconSize: 48),
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0x73000000), Color(0x00000000)],
                stops: [0, 0.5],
              ),
            ),
          ),
          PositionedDirectional(
            top: top + 8,
            start: AppPageHeader.pagePadding,
            child: AppCircleIconButton.back(onPressed: Get.back),
          ),
          PositionedDirectional(
            top: top + 14,
            end: AppPageHeader.pagePadding,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.94),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const AppHugeIcon(
                    icon: HugeIconsStrokeRounded.star,
                    size: 14,
                    color: Color(0xFFF4A261),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    trip.rating,
                    style: const TextStyle(
                      fontFamily: AppFonts.somarSans,
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.textStrong,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FactTile extends StatelessWidget {
  const _FactTile({
    required this.icon,
    required this.label,
    required this.value,
  });

  final List<List<dynamic>> icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return AppSurface(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppHugeIcon(icon: icon, size: 18, color: AppTheme.primary),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              fontFamily: AppFonts.somarSans,
              fontSize: 11,
              color: AppTheme.textSecondary,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontFamily: AppFonts.somarSans,
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: AppTheme.textStrong,
            ),
          ),
        ],
      ),
    );
  }
}

class _ItineraryRow extends StatelessWidget {
  const _ItineraryRow({
    required this.index,
    required this.step,
    required this.isLast,
  });

  final int index;
  final ItineraryStep step;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            children: [
              Container(
                width: 28,
                height: 28,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: AppTheme.primary,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  '$index',
                  style: const TextStyle(
                    fontFamily: AppFonts.somarSans,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    height: 1,
                  ),
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    color: AppTheme.border,
                  ),
                ),
            ],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: 2, bottom: isLast ? 0 : 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    step.title,
                    style: const TextStyle(
                      fontFamily: AppFonts.elMessiri,
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.textStrong,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    step.details,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
