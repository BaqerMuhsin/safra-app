import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../theme/app_fonts.dart';
import '../theme/app_theme.dart';
import '../utils/app_feedback.dart';
import 'app_huge_icon.dart';

/// Contact detail that copies its value when tapped (inside a bottom sheet).
class AppContactRow extends StatelessWidget {
  const AppContactRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  final List<List<dynamic>> icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await Clipboard.setData(ClipboardData(text: value));
        Get.back();
        showAppSnack('تم النسخ: $value');
      },
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            AppHugeIcon(icon: icon, size: 20, color: AppTheme.primary),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      fontFamily: AppFonts.somarSans,
                      fontSize: 12,
                      color: AppTheme.textSecondary,
                    ),
                  ),
                  Text(
                    value,
                    textDirection: TextDirection.ltr,
                    style: const TextStyle(
                      fontFamily: AppFonts.somarSans,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.textStrong,
                    ),
                  ),
                ],
              ),
            ),
            const Text(
              'نسخ',
              style: TextStyle(
                fontFamily: AppFonts.somarSans,
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppTheme.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
