import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/styles/stroke_rounded.dart';

import '../../../../core/theme/app_fonts.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/app_huge_icon.dart';
import '../../../../core/widgets/app_page_header.dart';
import '../../../../core/widgets/safra_logo.dart';
import '../../controllers/home_controller.dart';

class HomeTabView extends GetView<HomeController> {
  const HomeTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const AppPageHeader(title: 'الرئيسية', showBack: false),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(
              AppPageHeader.pagePadding,
              8,
              AppPageHeader.pagePadding,
              120,
            ),
            children: [
              const SafraLogo(iconSize: 32, fontSize: 26),
              const SizedBox(height: 20),
              Text(
                'مرحباً بك',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 8),
              Obx(
                () => Text(
                  controller.isLoading.value
                      ? 'جاري التحميل...'
                      : controller.welcomeMessage.value,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              const SizedBox(height: 28),
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
                            'ابحث عن رحلة',
                            style: TextStyle(
                              fontFamily: AppFonts.elMessiri,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: AppTheme.textStrong,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'من · إلى · تاريخ السفر',
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
      ],
    );
  }
}
