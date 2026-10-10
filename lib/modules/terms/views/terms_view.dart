import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/widgets/app_page_header.dart';
import '../../../core/widgets/custom_scaffold.dart';

class TermsView extends StatelessWidget {
  const TermsView({super.key});

  static const _sections = <({String title, String body})>[
    (
      title: 'عن الخدمة',
      body:
          'سفره منصة وسيطة تعرض رحلات شركات السياحة داخل العراق وتتيح حجز المقاعد فيها. الشركة المنظمة هي المسؤولة عن تنفيذ الرحلة وبرنامجها.',
    ),
    (
      title: 'الحساب',
      body:
          'يتم تسجيل الدخول برقم هاتف عراقي ورمز تحقق. أنت مسؤول عن صحة بياناتك وعن أي حجز يتم من حسابك.',
    ),
    (
      title: 'الحجز والدفع',
      body:
          'يُعتبر الحجز مؤكداً عند ظهور رقم الحجز. الأسعار المعروضة للشخص الواحد بالدينار العراقي وتشمل ما هو مذكور في صفحة الرحلة فقط.',
    ),
    (
      title: 'الإلغاء والاسترجاع',
      body:
          'يمكنك إلغاء الحجز من صفحة «رحلاتي» قبل موعد الرحلة. تخضع المبالغ المستردة لسياسة الشركة المنظمة.',
    ),
    (
      title: 'الخصوصية',
      body:
          'نستخدم رقم هاتفك واسمك لإتمام الحجوزات والتواصل معك بخصوصها، ونشاركها مع الشركة المنظمة لرحلتك فقط.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return CustomScaffold(
      appBar: AppPageHeader(title: 'الشروط والأحكام', onBack: Get.back),
      body: ListView(
        padding: EdgeInsets.fromLTRB(
          AppPageHeader.pagePadding,
          12,
          AppPageHeader.pagePadding,
          MediaQuery.paddingOf(context).bottom + 24,
        ),
        children: [
          for (final section in _sections) ...[
            Text(section.title, style: textTheme.titleMedium),
            const SizedBox(height: 6),
            Text(section.body, style: textTheme.bodyMedium),
            const SizedBox(height: 20),
          ],
        ],
      ),
    );
  }
}
