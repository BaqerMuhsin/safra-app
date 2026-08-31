import 'package:get/get.dart';

import '../providers/home_provider.dart';

class HomeController extends GetxController {
  HomeController({required HomeProvider provider}) : _provider = provider;

  final HomeProvider _provider;

  final RxBool isLoading = true.obs;
  final RxString welcomeMessage = ''.obs;
  final RxInt counter = 0.obs;

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

  void incrementCounter() => counter.value++;
}
