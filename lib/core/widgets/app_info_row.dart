import 'package:flutter/material.dart';

import '../theme/app_fonts.dart';
import '../theme/app_theme.dart';
import 'app_huge_icon.dart';

/// Label on one side, value on the other — receipts and summaries.
class AppInfoRow extends StatelessWidget {
  const AppInfoRow({
    super.key,
    required this.label,
    required this.value,
    this.icon,
    this.emphasized = false,
    this.ltrValue = false,
  });

  final String label;
  final String value;
  final List<List<dynamic>>? icon;
  final bool emphasized;

  /// Phone numbers and codes read left-to-right even in Arabic layouts.
  final bool ltrValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Row(
        children: [
          if (icon != null) ...[
            AppHugeIcon(icon: icon!, size: 16, color: AppTheme.textSecondary),
            const SizedBox(width: 8),
          ],
          Text(
            label,
            style: const TextStyle(
              fontFamily: AppFonts.somarSans,
              fontSize: 13,
              color: AppTheme.textSecondary,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              value,
              textAlign: ltrValue ? TextAlign.left : TextAlign.end,
              textDirection: ltrValue ? TextDirection.ltr : null,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontFamily: emphasized
                    ? AppFonts.elMessiri
                    : AppFonts.somarSans,
                fontSize: emphasized ? 17 : 14,
                fontWeight: emphasized ? FontWeight.w700 : FontWeight.w600,
                color: emphasized ? AppTheme.secondary : AppTheme.textStrong,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
