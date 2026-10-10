import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import 'app_page_header.dart';

/// Pinned bottom area for a screen's primary action.
class AppBottomActionBar extends StatelessWidget {
  const AppBottomActionBar({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.paddingOf(context).bottom;

    return Container(
      padding: EdgeInsets.fromLTRB(
        AppPageHeader.pagePadding,
        14,
        AppPageHeader.pagePadding,
        bottom + 14,
      ),
      decoration: const BoxDecoration(
        color: AppTheme.surface,
        border: Border(top: BorderSide(color: AppTheme.border)),
      ),
      child: child,
    );
  }
}
