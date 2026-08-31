import 'package:get/get.dart';

import '../../modules/home/bindings/home_binding.dart';
import '../../modules/home/views/home_view.dart';
import 'app_routes.dart';

abstract class AppPages {
  static const initial = AppRoutes.home;

  static final routes = <GetPage>[
    GetPage(
      name: AppRoutes.home,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
  ];
}
