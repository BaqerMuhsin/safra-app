import 'package:get/get.dart';

import '../home_tab.dart';
import '../providers/home_provider.dart';

class HomeController extends GetxController {
  HomeController({required HomeProvider provider}) : _provider = provider;

  final HomeProvider _provider;

  final RxInt currentTabIndex = 0.obs;
  final RxBool isLoading = true.obs;
  final RxString welcomeMessage = ''.obs;

  HomeTab get currentTab => HomeTab.fromIndex(currentTabIndex.value);

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
  }
}
