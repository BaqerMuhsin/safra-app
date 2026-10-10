import 'package:get/get.dart';

import '../../core/services/bookings_service.dart';
import '../../core/services/notifications_service.dart';
import '../../core/services/session_service.dart';
import '../../core/services/trips_service.dart';

/// App-wide services that outlive individual routes.
class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SessionService(), permanent: true);
    final trips = Get.put(TripsService(), permanent: true);
    final notifications = Get.put(NotificationsService(), permanent: true);
    Get.put(
      BookingsService(trips: trips, notifications: notifications),
      permanent: true,
    );
  }
}
