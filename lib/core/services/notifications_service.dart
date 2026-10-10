import 'package:get/get.dart';

import '../../data/mock_data.dart';
import '../../data/models/app_notification.dart';

class NotificationsService extends GetxService {
  final RxList<AppNotification> items = <AppNotification>[
    ...MockData.notifications,
  ].obs;

  int get unreadCount => items.where((n) => !n.isRead).length;

  void add({
    required NotificationKind kind,
    required String title,
    required String body,
  }) {
    items.insert(
      0,
      AppNotification(
        id: 'n${DateTime.now().microsecondsSinceEpoch}',
        kind: kind,
        title: title,
        body: body,
        timeLabel: 'الآن',
      ),
    );
  }

  void markRead(String id) {
    final index = items.indexWhere((n) => n.id == id);
    if (index == -1 || items[index].isRead) return;
    items[index] = items[index].copyWith(isRead: true);
  }

  void markAllRead() {
    items.assignAll(items.map((n) => n.copyWith(isRead: true)).toList());
  }
}
