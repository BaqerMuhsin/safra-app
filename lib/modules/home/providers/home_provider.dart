class HomeProvider {
  Future<String> fetchWelcomeMessage() async {
    await Future<void>.delayed(const Duration(milliseconds: 300));
    return 'Welcome to app_temp';
  }
}
