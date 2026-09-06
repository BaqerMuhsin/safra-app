class HomeProvider {
  Future<String> fetchWelcomeMessage() async {
    await Future<void>.delayed(const Duration(milliseconds: 300));
    return 'وين تبي تسافر اليوم؟';
  }
}
