import 'package:get/get.dart';

/// Signed-in traveler details, kept in memory for the app session.
class SessionService extends GetxService {
  final RxString phone = ''.obs;
  final RxString name = ''.obs;

  String get displayName =>
      name.value.trim().isEmpty ? 'مسافر سفره' : name.value.trim();

  String get firstName => displayName.split(' ').first;

  String get initial => String.fromCharCodes(displayName.runes.take(1));

  void signIn(String phoneNumber) => phone.value = phoneNumber;

  void signOut() {
    phone.value = '';
    name.value = '';
  }
}
