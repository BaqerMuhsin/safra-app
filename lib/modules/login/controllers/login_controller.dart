import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/routes/app_routes.dart';
import '../../../core/services/session_service.dart';
import '../../../core/utils/app_feedback.dart';

class LoginController extends GetxController {
  final phoneController = TextEditingController();
  final otpController = TextEditingController();

  final RxBool isOtpStep = false.obs;
  final RxBool isLoading = false.obs;
  final RxBool isValidPhone = false.obs;
  final RxBool isValidOtp = false.obs;
  final RxnString errorMessage = RxnString();
  final RxInt resendSeconds = 0.obs;

  static const _resendDelay = 60;
  Timer? _resendTimer;

  static final _iraqiMobilePattern = RegExp(r'^7[3-9]\d{8}$');

  String get formattedPhone {
    final phone = _normalizePhone(phoneController.text);
    return phone.isEmpty ? '' : '+964$phone';
  }

  @override
  void onClose() {
    _resendTimer?.cancel();
    phoneController.dispose();
    otpController.dispose();
    super.onClose();
  }

  void onPhoneChanged(String value) {
    errorMessage.value = null;
    isValidPhone.value = _iraqiMobilePattern.hasMatch(_normalizePhone(value));
  }

  void onOtpChanged(String value) {
    errorMessage.value = null;
    isValidOtp.value = value.length == 6;
  }

  Future<void> submitPhone() async {
    if (!isValidPhone.value || isLoading.value) return;

    isLoading.value = true;
    errorMessage.value = null;
    await Future<void>.delayed(const Duration(milliseconds: 600));
    otpController.clear();
    isValidOtp.value = false;
    isOtpStep.value = true;
    isLoading.value = false;
    _startResendCountdown();
  }

  void resendOtp() {
    if (resendSeconds.value > 0 || isLoading.value) return;
    otpController.clear();
    isValidOtp.value = false;
    errorMessage.value = null;
    _startResendCountdown();
    showAppSnack('تم إرسال رمز جديد');
  }

  void _startResendCountdown() {
    _resendTimer?.cancel();
    resendSeconds.value = _resendDelay;
    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (resendSeconds.value <= 1) {
        resendSeconds.value = 0;
        timer.cancel();
      } else {
        resendSeconds.value--;
      }
    });
  }

  Future<void> submitOtp() async {
    if (isLoading.value) return;

    if (otpController.text.length != 6) {
      errorMessage.value = 'يرجى إدخال رمز التحقق المكون من 6 أرقام';
      return;
    }

    isLoading.value = true;
    errorMessage.value = null;
    await Future<void>.delayed(const Duration(milliseconds: 600));
    isLoading.value = false;
    Get.find<SessionService>().signIn(formattedPhone);
    Get.offAllNamed(AppRoutes.home);
  }

  void backToPhoneStep() {
    _resendTimer?.cancel();
    isOtpStep.value = false;
    otpController.clear();
    isValidOtp.value = false;
    errorMessage.value = null;
  }

  String _normalizePhone(String value) {
    var digits = value.replaceAll(RegExp(r'\D'), '');
    if (digits.startsWith('964')) {
      digits = digits.substring(3);
    }
    if (digits.startsWith('0')) {
      digits = digits.substring(1);
    }
    return digits;
  }
}
