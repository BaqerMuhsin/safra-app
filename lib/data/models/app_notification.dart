import 'package:hugeicons/styles/stroke_rounded.dart';

enum NotificationKind {
  booking(HugeIconsStrokeRounded.ticket01),
  offer(HugeIconsStrokeRounded.discount01),
  reminder(HugeIconsStrokeRounded.alarmClock),
  general(HugeIconsStrokeRounded.notification01);

  const NotificationKind(this.icon);

  final List<List<dynamic>> icon;
}

class AppNotification {
  const AppNotification({
    required this.id,
    required this.kind,
    required this.title,
    required this.body,
    required this.timeLabel,
    this.isRead = false,
  });

  final String id;
  final NotificationKind kind;
  final String title;
  final String body;
  final String timeLabel;
  final bool isRead;

  AppNotification copyWith({bool? isRead}) => AppNotification(
    id: id,
    kind: kind,
    title: title,
    body: body,
    timeLabel: timeLabel,
    isRead: isRead ?? this.isRead,
  );
}
