import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/styles/stroke_rounded.dart';

import '../../../app/routes/app_routes.dart';
import '../../../core/theme/app_fonts.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/app_choice_chips.dart';
import '../../../core/widgets/app_empty_state.dart';
import '../../../core/widgets/app_page_header.dart';
import '../../../core/widgets/app_search_field.dart';
import '../../../core/widgets/custom_scaffold.dart';
import '../../../core/widgets/trip_card.dart';
import '../../../data/models/trip.dart';
import '../controllers/trips_list_controller.dart';

class TripsListView extends GetView<TripsListController> {
  const TripsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: AppPageHeader(title: 'الرحلات', onBack: Get.back),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppPageHeader.pagePadding,
              8,
              AppPageHeader.pagePadding,
              12,
            ),
            child: AppSearchField(
              controller: controller.searchController,
              hintText: 'ابحث عن وجهة أو رحلة أو شركة...',
              autofocus: controller.focusSearch,
              onChanged: controller.onQueryChanged,
            ),
          ),
          SizedBox(
            height: 40,
            child: Obx(
              () => ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppPageHeader.pagePadding,
                ),
                children: [
                  AppChoiceChip(
                    label: 'الكل',
                    selected: controller.category.value == null,
                    onTap: () => controller.selectCategory(null),
                  ),
                  for (final category in TripCategory.values) ...[
                    const SizedBox(width: 8),
                    AppChoiceChip(
                      label: category.shortLabel,
                      selected: controller.category.value == category,
                      onTap: () => controller.selectCategory(category),
                    ),
                  ],
                ],
              ),
            ),
          ),
          Expanded(
            child: Obx(() {
              final trips = controller.results;

              if (trips.isEmpty) {
                return SingleChildScrollView(
                  padding: const EdgeInsets.all(AppPageHeader.pagePadding),
                  child: AppEmptyState(
                    icon: HugeIconsStrokeRounded.search01,
                    title: 'لا توجد رحلات مطابقة',
                    message: 'جرّب كلمة أخرى أو غيّر التصنيف',
                    actionLabel: 'عرض كل الرحلات',
                    onAction: controller.clearFilters,
                  ),
                );
              }

              return ListView.separated(
                padding: EdgeInsets.fromLTRB(
                  AppPageHeader.pagePadding,
                  16,
                  AppPageHeader.pagePadding,
                  MediaQuery.paddingOf(context).bottom + 24,
                ),
                itemCount: trips.length + 1,
                separatorBuilder: (_, _) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Text(
                      tripsCountLabel(trips.length),
                      style: const TextStyle(
                        fontFamily: AppFonts.somarSans,
                        fontSize: 13,
                        color: AppTheme.textSecondary,
                      ),
                    );
                  }
                  final trip = trips[index - 1];
                  return TripCard(
                    title: trip.title,
                    location: trip.location,
                    durationLabel: trip.durationLabel,
                    dateLabel: trip.dateLabel,
                    priceLabel: trip.priceLabel,
                    ratingLabel: trip.rating,
                    imageUrl: trip.imageUrl,
                    onTap: () =>
                        Get.toNamed(AppRoutes.tripDetails, arguments: trip),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
