import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/styles/stroke_rounded.dart';

import '../../../../app/routes/app_routes.dart';
import '../../../../core/services/bookings_service.dart';
import '../../../../core/services/notifications_service.dart';
import '../../../../core/services/session_service.dart';
import '../../../../core/theme/app_fonts.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/app_feedback.dart';
import '../../../../core/widgets/app_contact_row.dart';
import '../../../../core/widgets/app_huge_icon.dart';
import '../../../../core/widgets/app_page_header.dart';
import '../../../../core/widgets/app_surface.dart';

class MoreTabView extends StatelessWidget {
  const MoreTabView({super.key});

  static const supportPhone = '+964 770 000 0000';
  static const supportEmail = 'support@safra.app';

  @override
  Widget build(BuildContext context) {
    final session = Get.find<SessionService>();
    final bookings = Get.find<BookingsService>();
    final notifications = Get.find<NotificationsService>();

    return ListView(
      padding: const EdgeInsets.fromLTRB(
        AppPageHeader.pagePadding,
        24,
        AppPageHeader.pagePadding,
        120,
      ),
      children: [
        Obx(
          () => AppSurface(
            onTap: () => Get.toNamed(AppRoutes.profile),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: AppTheme.primaryLight,
                  child: Text(
                    session.initial,
                    style: const TextStyle(
                      fontFamily: AppFonts.elMessiri,
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.primary,
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        session.displayName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      if (session.phone.value.isNotEmpty) ...[
                        const SizedBox(height: 2),
                        Text(
                          session.phone.value,
                          textDirection: TextDirection.ltr,
                          style: const TextStyle(
                            fontFamily: AppFonts.somarSans,
                            fontSize: 13,
                            color: AppTheme.textSecondary,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                const AppHugeIcon(
                  icon: HugeIconsStrokeRounded.edit02,
                  size: 20,
                  color: AppTheme.primary,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        Obx(
          () => Row(
            children: [
              Expanded(
                child: _StatTile(
                  value: '${bookings.upcoming.length}',
                  label: 'رحلات قادمة',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _StatTile(
                  value: '${bookings.bookings.length}',
                  label: 'إجمالي الحجوزات',
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        const _GroupLabel('الحساب'),
        AppSurface(
          padding: EdgeInsets.zero,
          child: Column(
            children: [
              _MenuTile(
                icon: HugeIconsStrokeRounded.userCircle,
                label: 'الملف الشخصي',
                onTap: () => Get.toNamed(AppRoutes.profile),
              ),
              const Divider(height: 1, indent: 60, color: AppTheme.border),
              Obx(
                () => _MenuTile(
                  icon: HugeIconsStrokeRounded.notification01,
                  label: 'الإشعارات',
                  badge: notifications.unreadCount > 0
                      ? '${notifications.unreadCount}'
                      : null,
                  onTap: () => Get.toNamed(AppRoutes.notifications),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        const _GroupLabel('الدعم والمعلومات'),
        AppSurface(
          padding: EdgeInsets.zero,
          child: Column(
            children: [
              _MenuTile(
                icon: HugeIconsStrokeRounded.customerSupport,
                label: 'تواصل معنا',
                onTap: _showSupportSheet,
              ),
              const Divider(height: 1, indent: 60, color: AppTheme.border),
              _MenuTile(
                icon: HugeIconsStrokeRounded.file02,
                label: 'الشروط والأحكام',
                onTap: () => Get.toNamed(AppRoutes.terms),
              ),
              const Divider(height: 1, indent: 60, color: AppTheme.border),
              _MenuTile(
                icon: HugeIconsStrokeRounded.informationCircle,
                label: 'عن سفره',
                onTap: _showAboutSheet,
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        AppSurface(
          padding: EdgeInsets.zero,
          child: _MenuTile(
            icon: HugeIconsStrokeRounded.logout01,
            label: 'تسجيل الخروج',
            color: const Color(0xFFE63946),
            showChevron: false,
            onTap: () => _confirmSignOut(session),
          ),
        ),
        const SizedBox(height: 20),
        const Center(
          child: Text(
            'سفره · الإصدار 0.1.0',
            style: TextStyle(
              fontFamily: AppFonts.somarSans,
              fontSize: 12,
              color: AppTheme.textHint,
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _confirmSignOut(SessionService session) async {
    final confirmed = await showAppConfirm(
      title: 'تسجيل الخروج',
      message: 'هل تريد تسجيل الخروج من حسابك؟',
      confirmLabel: 'تسجيل الخروج',
      destructive: true,
    );
    if (!confirmed) return;
    session.signOut();
    Get.offAllNamed(AppRoutes.login);
  }

  void _showSupportSheet() {
    Get.bottomSheet(
      Builder(
        builder: (context) => AppSheet(
          title: 'تواصل معنا',
          children: [
            Text(
              'فريق الدعم متاح يومياً من 9 صباحاً حتى 9 مساءً.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 12),
            const AppContactRow(
              icon: HugeIconsStrokeRounded.call02,
              label: 'الهاتف وواتساب',
              value: supportPhone,
            ),
            const AppContactRow(
              icon: HugeIconsStrokeRounded.mail01,
              label: 'البريد الإلكتروني',
              value: supportEmail,
            ),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }

  void _showAboutSheet() {
    Get.bottomSheet(
      Builder(
        builder: (context) => AppSheet(
          title: 'عن سفره',
          children: [
            Text(
              'سفره تطبيق لحجز الرحلات السياحية داخل العراق. نجمع لك رحلات شركات السياحة الموثوقة في مكان واحد: من جبال كردستان إلى أهوار الجنوب والعتبات المقدسة، لتختار رحلتك وتحجز مقعدك بخطوات بسيطة.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }
}

class _GroupLabel extends StatelessWidget {
  const _GroupLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(start: 4, bottom: 8),
      child: Text(
        text,
        style: const TextStyle(
          fontFamily: AppFonts.somarSans,
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: AppTheme.textSecondary,
        ),
      ),
    );
  }
}

class _StatTile extends StatelessWidget {
  const _StatTile({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return AppSurface(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: const TextStyle(
              fontFamily: AppFonts.elMessiri,
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: AppTheme.primary,
              height: 1.1,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              fontFamily: AppFonts.somarSans,
              fontSize: 12,
              color: AppTheme.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

class _MenuTile extends StatelessWidget {
  const _MenuTile({
    required this.icon,
    required this.label,
    required this.onTap,
    this.color,
    this.badge,
    this.showChevron = true,
  });

  final List<List<dynamic>> icon;
  final String label;
  final VoidCallback onTap;
  final Color? color;
  final String? badge;
  final bool showChevron;

  @override
  Widget build(BuildContext context) {
    final accent = color ?? AppTheme.primary;

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: accent.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(11),
              ),
              child: Center(
                child: AppHugeIcon(icon: icon, size: 18, color: accent),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontFamily: AppFonts.somarSans,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: color ?? AppTheme.textStrong,
                ),
              ),
            ),
            if (badge != null) ...[
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: AppTheme.secondary,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  badge!,
                  style: const TextStyle(
                    fontFamily: AppFonts.somarSans,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 8),
            ],
            if (showChevron)
              const AppHugeIcon(
                icon: HugeIconsStrokeRounded.arrowLeft01,
                size: 18,
                color: AppTheme.textHint,
              ),
          ],
        ),
      ),
    );
  }
}
