import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hugeicons/styles/stroke_rounded.dart';

import '../../../app/routes/app_routes.dart';
import '../../../core/theme/app_fonts.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/app_huge_icon.dart';
import '../../../core/widgets/app_page_header.dart';
import '../../../core/widgets/custom_scaffold.dart';
import '../../../core/widgets/otp_code_boxes.dart';
import '../../../core/widgets/safra_logo.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.paddingOf(context).bottom;

    return Obx(() {
      final isOtp = controller.isOtpStep.value;
      final canPop = Get.key.currentState?.canPop() == true;

      return CustomScaffold(
        appBar: AppPageHeader(
          title: 'تسجيل الدخول',
          onBack: isOtp
              ? controller.backToPhoneStep
              : (canPop ? Get.back : null),
          showBack: isOtp || canPop,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(
                  AppPageHeader.pagePadding,
                  28,
                  AppPageHeader.pagePadding,
                  20,
                ),
                children: [
                  const SafraLogo(iconSize: 34, fontSize: 28),
                  const SizedBox(height: 28),
                  Text(
                    isOtp ? 'أدخل رمز التحقق' : 'مرحباً بك',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    isOtp
                        ? 'تم إرسال رمز التحقق إلى واتساب ورسالة نصية على \u2066${controller.formattedPhone}\u2069'
                        : 'قم بتسجيل الدخول لإكمال حجزك وإدارة رحلاتك والحصول على دعم مباشر!',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 28),
                  if (!isOtp) ...[
                    _buildPhoneField(context),
                    const SizedBox(height: 12),
                    _buildCountryHint(),
                  ] else ...[
                    _buildOtpField(context),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: controller.isLoading.value
                              ? null
                              : controller.backToPhoneStep,
                          child: const Text('تغيير رقم الهاتف'),
                        ),
                        TextButton(
                          onPressed: controller.resendSeconds.value > 0
                              ? null
                              : controller.resendOtp,
                          child: Text(
                            controller.resendSeconds.value > 0
                                ? 'إعادة الإرسال (${controller.resendSeconds.value})'
                                : 'إعادة إرسال الرمز',
                          ),
                        ),
                      ],
                    ),
                  ],
                  if (controller.errorMessage.value != null) ...[
                    const SizedBox(height: 8),
                    Text(
                      controller.errorMessage.value!,
                      style: const TextStyle(
                        fontFamily: AppFonts.somarSans,
                        color: Color(0xFFDC2626),
                        fontSize: 13,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                AppPageHeader.pagePadding,
                12,
                AppPageHeader.pagePadding,
                bottom + 12,
              ),
              child: Column(
                children: [
                  if (!isOtp) ...[
                    _buildTermsRow(context),
                    const SizedBox(height: 16),
                  ],
                  _buildContinueButton(isOtp),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildPhoneField(BuildContext context) {
    return TextField(
      key: const ValueKey('login-phone'),
      controller: controller.phoneController,
      keyboardType: TextInputType.phone,
      textAlign: TextAlign.right,
      onChanged: controller.onPhoneChanged,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(11),
        _IraqiPhoneFormatter(),
      ],
      style: const TextStyle(
        fontFamily: AppFonts.somarSans,
        fontSize: 15,
        color: AppTheme.textStrong,
      ),
      decoration: InputDecoration(
        labelText: 'رقم الهاتف',
        hintText: '7XXXXXXXXX',
        prefixIcon: Padding(
          padding: const EdgeInsetsDirectional.only(start: 14, end: 8),
          child: AppHugeIcon(
            icon: HugeIconsStrokeRounded.smartPhone01,
            color: AppTheme.textHint,
            size: 18,
          ),
        ),
        prefixIconConstraints: const BoxConstraints(
          minWidth: 40,
          minHeight: 24,
        ),
      ),
    );
  }

  Widget _buildOtpField(BuildContext context) {
    return OtpCodeBoxes(
      key: const ValueKey('login-otp'),
      controller: controller.otpController,
      autofocus: true,
      onChanged: controller.onOtpChanged,
    );
  }

  Widget _buildCountryHint() {
    return const Row(
      children: [
        Text('🇮🇶', style: TextStyle(fontSize: 18)),
        SizedBox(width: 8),
        Text(
          'العراق (+964) فقط',
          style: TextStyle(
            fontFamily: AppFonts.somarSans,
            fontSize: 13,
            color: AppTheme.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildTermsRow(BuildContext context) {
    return InkWell(
      onTap: () => Get.toNamed(AppRoutes.terms),
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppHugeIcon(
              icon: HugeIconsStrokeRounded.informationCircle,
              size: 16,
              color: AppTheme.textSecondary,
            ),
            const SizedBox(width: 6),
            Text(
              'اطلع على شروط وأحكام سفره',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: 13,
                color: AppTheme.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContinueButton(bool isOtp) {
    final loading = controller.isLoading.value;
    final enabled = isOtp
        ? controller.isValidOtp.value
        : controller.isValidPhone.value;
    final active = loading || enabled;

    return FilledButton(
      onPressed: loading
          ? null
          : enabled
          ? (isOtp ? controller.submitOtp : controller.submitPhone)
          : null,
      style: FilledButton.styleFrom(
        backgroundColor: active ? AppTheme.primary : AppTheme.border,
        foregroundColor: active ? Colors.white : AppTheme.textHint,
        disabledBackgroundColor: active ? AppTheme.primary : AppTheme.border,
        disabledForegroundColor: active ? Colors.white : AppTheme.textHint,
      ),
      child: loading
          ? const SizedBox(
              width: 22,
              height: 22,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.white,
              ),
            )
          : Text(isOtp ? 'تأكيد' : 'متابعة'),
    );
  }
}

class _IraqiPhoneFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    var digits = newValue.text.replaceAll(RegExp(r'\D'), '');

    if (digits.startsWith('964')) {
      digits = digits.substring(3);
    }
    if (digits.startsWith('0')) {
      digits = digits.substring(1);
    }
    if (digits.length > 10) {
      digits = digits.substring(0, 10);
    }

    return TextEditingValue(
      text: digits,
      selection: TextSelection.collapsed(offset: digits.length),
    );
  }
}
