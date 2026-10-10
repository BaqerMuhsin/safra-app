import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/styles/stroke_rounded.dart';

import '../../../core/services/notifications_service.dart';
import '../../../core/theme/app_fonts.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/app_empty_state.dart';
import '../../../core/widgets/app_huge_icon.dart';
import '../../../core/widgets/app_page_header.dart';
import '../../../core/widgets/app_surface.dart';
import '../../../core/widgets/custom_scaffold.dart';
import '../../../data/models/app_notification.dart';

class NotificationsView extends StatelessWidget {
  const NotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    final service = Get.find<NotificationsService>();

    return CustomScaffold(
      appBar: AppPageHeader(
        title: 'الإشعارات',
        onBack: Get.back,
        actions: [
          Obx(
            () => service.unreadCount == 0
                ? const SizedBox.shrink()
                : Padding(
                    padding: const EdgeInsetsDirectional.only(end: 12),
                    child: TextButton(
                      onPressed: service.markAllRead,
                      child: const Text('قراءة الكل'),
                    ),
                  ),
          ),
        ],
      ),
      body: Obx(() {
        final items = service.items;

        if (items.isEmpty) {
          return const Center(
            child: AppEmptyState(
              icon: HugeIconsStrokeRounded.notification01,
              title: 'لا توجد إشعارات',
              message: 'ستصلك هنا تحديثات حجوزاتك والعروض الجديدة',
            ),
          );
        }

        return ListView.separated(
          padding: EdgeInsets.fromLTRB(
            AppPageHeader.pagePadding,
            12,
            AppPageHeader.pagePadding,
            MediaQuery.paddingOf(context).bottom + 24,
          ),
          itemCount: items.length,
          separatorBuilder: (_, _) => const SizedBox(height: 10),
          itemBuilder: (context, index) => _NotificationTile(
            item: items[index],
            onTap: () => service.markRead(items[index].id),
          ),
        );
      }),
    );
  }
}

class _NotificationTile extends StatelessWidget {
  const _NotificationTile({required this.item, required this.onTap});

  final AppNotification item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AppSurface(
      padding: const EdgeInsets.all(14),
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: item.isRead ? AppTheme.background : AppTheme.primaryLight,
              borderRadius: BorderRadius.circular(13),
            ),
            child: Center(
              child: AppHugeIcon(
                icon: item.kind.icon,
                size: 20,
                color: item.isRead ? AppTheme.textSecondary : AppTheme.primary,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        item.title,
                        style: TextStyle(
                          fontFamily: AppFonts.elMessiri,
                          fontSize: 15,
                          fontWeight: item.isRead
                              ? FontWeight.w600
                              : FontWeight.w700,
                          color: AppTheme.textStrong,
                        ),
                      ),
                    ),
                    if (!item.isRead)
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: AppTheme.secondary,
                          shape: BoxShape.circle,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(item.body, style: Theme.of(context).textTheme.bodyMedium),
                const SizedBox(height: 6),
                Text(
                  item.timeLabel,
                  style: const TextStyle(
                    fontFamily: AppFonts.somarSans,
                    fontSize: 12,
                    color: AppTheme.textHint,
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
