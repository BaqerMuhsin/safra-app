import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/custom_scaffold.dart';
import '../controllers/home_controller.dart';
import 'tabs/home_tab_view.dart';
import 'tabs/more_tab_view.dart';
import 'tabs/support_tab_view.dart';
import 'tabs/trips_tab_view.dart';
import 'widgets/home_bottom_nav.dart';
import 'widgets/home_header.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      extendBody: true,
      useGradientBackground: false,
      backgroundColor: AppTheme.background,
      systemUiOverlayStyle: SystemUiOverlayStyle.light,
      body: Column(
        children: [
          const HomeHeader(),
          Expanded(
            child: NotificationListener<ScrollNotification>(
              onNotification: (notification) {
                if (notification.metrics.axis != Axis.vertical) {
                  return false;
                }
                if (notification is ScrollUpdateNotification ||
                    notification is OverscrollNotification) {
                  controller.onScrollOffset(notification.metrics.pixels);
                }
                return false;
              },
              child: ColoredBox(
                color: AppTheme.background,
                child: Obx(
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
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const HomeBottomNav(),
    );
  }
}
