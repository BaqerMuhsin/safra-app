import 'package:get/get.dart';

import '../../data/models/booking.dart';
import '../../data/models/company.dart';
import '../../data/models/trip.dart';
import '../../modules/booking/bindings/booking_binding.dart';
import '../../modules/booking/views/booking_details_view.dart';
import '../../modules/booking/views/booking_success_view.dart';
import '../../modules/booking/views/booking_view.dart';
import '../../modules/company_details/views/company_details_view.dart';
import '../../modules/home/bindings/home_binding.dart';
import '../../modules/home/views/home_view.dart';
import '../../modules/login/bindings/login_binding.dart';
import '../../modules/login/views/login_view.dart';
import '../../modules/notifications/views/notifications_view.dart';
import '../../modules/profile/views/profile_view.dart';
import '../../modules/terms/views/terms_view.dart';
import '../../modules/trip_details/views/trip_details_view.dart';
import '../../modules/trips_list/bindings/trips_list_binding.dart';
import '../../modules/trips_list/views/trips_list_view.dart';
import 'app_routes.dart';

abstract class AppPages {
  static const initial = AppRoutes.login;

  static final routes = <GetPage>[
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.trips,
      page: () => const TripsListView(),
      binding: TripsListBinding(),
    ),
    // Detail pages can stack (trip → company → trip), so they take their
    // subject through the constructor instead of a shared controller.
    GetPage(
      name: AppRoutes.tripDetails,
      page: () => TripDetailsView(trip: Get.arguments as Trip),
    ),
    GetPage(
      name: AppRoutes.companyDetails,
      page: () => CompanyDetailsView(company: Get.arguments as Company),
    ),
    GetPage(
      name: AppRoutes.booking,
      page: () => const BookingView(),
      binding: BookingBinding(),
    ),
    GetPage(
      name: AppRoutes.bookingSuccess,
      page: () => BookingSuccessView(booking: Get.arguments as Booking),
    ),
    GetPage(
      name: AppRoutes.bookingDetails,
      page: () => BookingDetailsView(bookingId: Get.arguments as String),
    ),
    GetPage(
      name: AppRoutes.notifications,
      page: () => const NotificationsView(),
    ),
    GetPage(name: AppRoutes.profile, page: () => const ProfileView()),
    GetPage(name: AppRoutes.terms, page: () => const TermsView()),
  ];
}
