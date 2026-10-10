import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/styles/stroke_rounded.dart';

import '../../../app/routes/app_routes.dart';
import '../../../core/services/trips_service.dart';
import '../../../core/theme/app_fonts.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/app_feedback.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/app_contact_row.dart';
import '../../../core/widgets/app_empty_state.dart';
import '../../../core/widgets/app_huge_icon.dart';
import '../../../core/widgets/app_network_image.dart';
import '../../../core/widgets/app_page_header.dart';
import '../../../core/widgets/app_surface.dart';
import '../../../core/widgets/custom_scaffold.dart';
import '../../../core/widgets/trip_card.dart';
import '../../../data/models/company.dart';

class CompanyDetailsView extends StatelessWidget {
  const CompanyDetailsView({super.key, required this.company});

  final Company company;

  @override
  Widget build(BuildContext context) {
    final trips = Get.find<TripsService>().byCompany(company.id);
    final textTheme = Theme.of(context).textTheme;

    return CustomScaffold(
      appBar: AppPageHeader(title: 'تفاصيل الشركة', onBack: Get.back),
      body: ListView(
        padding: EdgeInsets.fromLTRB(
          AppPageHeader.pagePadding,
          12,
          AppPageHeader.pagePadding,
          MediaQuery.paddingOf(context).bottom + 24,
        ),
        children: [
          AppSurface(
            child: Column(
              children: [
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(18),
                      child: SizedBox(
                        width: 72,
                        height: 72,
                        child: AppNetworkImage(
                          url: company.imageUrl,
                          iconSize: 28,
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(company.name, style: textTheme.titleMedium),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const AppHugeIcon(
                                icon: HugeIconsStrokeRounded.mapsLocation01,
                                size: 14,
                                color: AppTheme.primary,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                company.location,
                                style: const TextStyle(
                                  fontFamily: AppFonts.somarSans,
                                  fontSize: 13,
                                  color: AppTheme.textBody,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: AppTheme.primaryLight,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              company.specialty,
                              style: const TextStyle(
                                fontFamily: AppFonts.somarSans,
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: AppTheme.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Divider(height: 1, color: AppTheme.border),
                const SizedBox(height: 14),
                Row(
                  children: [
                    Expanded(
                      child: _Stat(value: company.rating, label: 'التقييم'),
                    ),
                    Expanded(
                      child: _Stat(
                        value: '${trips.length}',
                        label: 'رحلات متاحة',
                      ),
                    ),
                    Expanded(
                      child: _Stat(
                        value: '${company.foundedYear}',
                        label: 'سنة التأسيس',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Text('عن الشركة', style: textTheme.titleMedium),
          const SizedBox(height: 8),
          Text(company.about, style: textTheme.bodyMedium),
          const SizedBox(height: 16),
          OutlinedButton.icon(
            onPressed: _showContactSheet,
            style: OutlinedButton.styleFrom(
              foregroundColor: AppTheme.primary,
              minimumSize: const Size.fromHeight(50),
              side: const BorderSide(color: AppTheme.primary),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              textStyle: const TextStyle(
                fontFamily: AppFonts.somarSans,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
            icon: const AppHugeIcon(
              icon: HugeIconsStrokeRounded.call02,
              size: 18,
              color: AppTheme.primary,
            ),
            label: const Text('تواصل مع الشركة'),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: Text('رحلات الشركة', style: textTheme.titleMedium),
              ),
              Text(
                tripsCountLabel(trips.length),
                style: const TextStyle(
                  fontFamily: AppFonts.somarSans,
                  fontSize: 12,
                  color: AppTheme.textSecondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (trips.isEmpty)
            const AppEmptyState(
              icon: HugeIconsStrokeRounded.ticket01,
              title: 'لا توجد رحلات حالياً',
              message: 'ستظهر رحلات الشركة هنا عند إضافتها',
            )
          else
            for (var i = 0; i < trips.length; i++) ...[
              if (i > 0) const SizedBox(height: 12),
              TripCard(
                title: trips[i].title,
                location: trips[i].location,
                durationLabel: trips[i].durationLabel,
                dateLabel: trips[i].dateLabel,
                priceLabel: trips[i].priceLabel,
                ratingLabel: trips[i].rating,
                imageUrl: trips[i].imageUrl,
                onTap: () => Get.toNamed(
                  AppRoutes.tripDetails,
                  arguments: trips[i],
                  preventDuplicates: false,
                ),
              ),
            ],
        ],
      ),
    );
  }

  void _showContactSheet() {
    Get.bottomSheet(
      AppSheet(
        title: company.name,
        children: [
          AppContactRow(
            icon: HugeIconsStrokeRounded.call02,
            label: 'الهاتف وواتساب',
            value: company.phone,
          ),
        ],
      ),
      isScrollControlled: true,
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontFamily: AppFonts.elMessiri,
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppTheme.textStrong,
            height: 1.2,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(
            fontFamily: AppFonts.somarSans,
            fontSize: 12,
            color: AppTheme.textSecondary,
          ),
        ),
      ],
    );
  }
}
