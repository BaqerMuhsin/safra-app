import 'package:flutter/material.dart';

import '../theme/app_fonts.dart';
import '../theme/app_theme.dart';
import 'app_circle_icon_button.dart';

class AppPageHeader extends StatelessWidget implements PreferredSizeWidget {
  const AppPageHeader({
    super.key,
    required this.title,
    this.actions,
    this.onBack,
    this.backgroundColor,
    this.showBack = true,
  });

  final String title;
  final List<Widget>? actions;
  final VoidCallback? onBack;
  final Color? backgroundColor;
  final bool showBack;

  static const double pagePadding = 20;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.transparent,
      ),
      child: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        automaticallyImplyLeading: false,
        leadingWidth: showBack ? 60 : 0,
        titleSpacing: showBack ? 12 : 28,
        leading: showBack
            ? Padding(
                padding: const EdgeInsetsDirectional.only(start: pagePadding),
                child: AppCircleIconButton.back(
                  onPressed: onBack,
                  borderColor: AppTheme.primarySoft.withValues(alpha: 0.12),
                ),
              )
            : null,
        title: Text(
          title,
          style: const TextStyle(
            fontFamily: AppFonts.elMessiri,
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppTheme.textStrong,
          ),
        ),
        actions: actions,
      ),
    );
  }
}
