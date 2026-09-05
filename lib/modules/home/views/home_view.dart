import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/widgets/custom_scaffold.dart';
import '../controllers/home_controller.dart';
import 'tabs/home_tab_view.dart';
import 'tabs/more_tab_view.dart';
import 'tabs/support_tab_view.dart';
import 'tabs/trips_tab_view.dart';
import 'widgets/home_bottom_nav.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      extendBody: true,
      body: Obx(
        () => IndexedStack(
          index: controller.currentTabIndex.value,
          children: const [
            HomeTabView(),
            TripsTabView(),
            SupportTabView(),
            MoreTabView(),
          ],
        ),
      ),
      bottomNavigationBar: const HomeBottomNav(),
    );
  }
}
