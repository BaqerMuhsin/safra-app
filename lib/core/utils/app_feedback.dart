import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../theme/app_fonts.dart';
import '../theme/app_theme.dart';

void showAppSnack(String message) {
  Get.rawSnackbar(
    messageText: Text(
      message,
      style: const TextStyle(
        fontFamily: AppFonts.somarSans,
        fontSize: 14,
        color: Colors.white,
      ),
    ),
    snackPosition: SnackPosition.BOTTOM,
    margin: const EdgeInsets.all(16),
    borderRadius: 14,
    backgroundColor: AppTheme.textStrong,
    duration: const Duration(seconds: 2),
  );
}

/// Bottom sheet shell shared by confirmations and info sheets.
class AppSheet extends StatelessWidget {
  const AppSheet({super.key, required this.title, required this.children});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.paddingOf(context).bottom;

    return Container(
      padding: EdgeInsets.fromLTRB(20, 12, 20, bottom + 20),
      decoration: const BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppTheme.border,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 18),
          Text(title, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          ...children,
        ],
      ),
    );
  }
}

Future<bool> showAppConfirm({
  required String title,
  required String message,
  required String confirmLabel,
  String cancelLabel = 'تراجع',
  bool destructive = false,
}) async {
  final accent = destructive ? const Color(0xFFE63946) : AppTheme.primary;

  final result = await Get.bottomSheet<bool>(
    Builder(
      builder: (context) => AppSheet(
        title: title,
        children: [
          Text(message, style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Get.back(result: false),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppTheme.textStrong,
                    minimumSize: const Size.fromHeight(50),
                    side: const BorderSide(color: AppTheme.border),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(cancelLabel),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: FilledButton(
                  onPressed: () => Get.back(result: true),
                  style: FilledButton.styleFrom(
                    backgroundColor: accent,
                    minimumSize: const Size.fromHeight(50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(confirmLabel),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
    isScrollControlled: true,
  );
  return result ?? false;
}
