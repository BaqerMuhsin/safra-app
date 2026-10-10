import 'package:get/get.dart';

import '../../../core/services/notifications_service.dart';
import '../../../core/services/session_service.dart';
import '../home_tab.dart';
import '../providers/home_provider.dart';

class HomeController extends GetxController {
  HomeController({required HomeProvider provider}) : _provider = provider;

  final HomeProvider _provider;
  final SessionService _session = Get.find();
  final NotificationsService _notifications = Get.find();

  final RxInt currentTabIndex = 0.obs;
  final RxBool isLoading = true.obs;
  final RxString welcomeMessage = ''.obs;
  final RxDouble scrollOffset = 0.0.obs;

  static const headerRowHeight = 58.0;
  static const headerTopPadding = 10.0;
  static const headerBottomPadding = 18.0;
  static const headerCollapseRange = 56.0;

  static const _titles = ['أهلاً !', 'مرحباً بك!', 'يلا نسافر!'];
  static const _subtitles = [
    'وين تبي تسافر اليوم؟',
    'اكتشف أجمل الرحلات السياحية',
    'سافر بأمان مع سفره',
    'رحلات سياحية داخل العراق',
  ];

  HomeTab get currentTab => HomeTab.fromIndex(currentTabIndex.value);

  /// 0 = fully expanded, 1 = modestly collapsed.
  double get headerCollapse =>
      (scrollOffset.value / headerCollapseRange).clamp(0.0, 1.0);

  String get greetingTitle {
    if (_session.name.value.trim().isNotEmpty) {
      return 'أهلاً، ${_session.firstName}!';
    }
    return _titles[DateTime.now().day % _titles.length];
  }

  String get greetingSubtitle {
    return _subtitles[DateTime.now().day % _subtitles.length];
  }

  String get avatarInitial =>
      _session.name.value.trim().isEmpty ? 'س' : _session.initial;

  bool get hasUnreadNotifications => _notifications.unreadCount > 0;

  void onScrollOffset(double offset) {
    final next = offset < 0 ? 0.0 : offset;
    if ((scrollOffset.value - next).abs() < 0.5) return;
    scrollOffset.value = next;
  }

  @override
  void onInit() {
    super.onInit();
    _loadWelcomeMessage();
  }

  Future<void> _loadWelcomeMessage() async {
    isLoading.value = true;
    welcomeMessage.value = await _provider.fetchWelcomeMessage();
    isLoading.value = false;
  }

  void selectTab(int index) {
    if (index == currentTabIndex.value) return;
    if (index < 0 || index >= HomeTab.count) return;
    currentTabIndex.value = index;
    scrollOffset.value = 0;
  }
}
