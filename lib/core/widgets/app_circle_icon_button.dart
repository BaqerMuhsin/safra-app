import 'package:flutter/material.dart';
import 'package:hugeicons/styles/stroke_rounded.dart';

import '../theme/app_theme.dart';
import 'app_huge_icon.dart';

class AppCircleIconButton extends StatelessWidget {
  const AppCircleIconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.size = 40,
    this.iconSize = 20,
    this.backgroundColor = Colors.white,
    this.iconColor,
    this.borderColor,
    this.borderWidth = 1,
  });

  const AppCircleIconButton.back({
    super.key,
    this.onPressed,
    this.size = 40,
    this.iconSize = 20,
    this.backgroundColor = Colors.white,
    this.iconColor,
    this.borderColor,
    this.borderWidth = 1,
  }) : icon = HugeIconsStrokeRounded.arrowRight01;

  final List<List<dynamic>> icon;
  final VoidCallback? onPressed;
  final double size;
  final double iconSize;
  final Color backgroundColor;
  final Color? iconColor;
  final Color? borderColor;
  final double borderWidth;

  @override
  Widget build(BuildContext context) {
    final resolvedIconColor = iconColor ?? AppTheme.textStrong;

    final shape = CircleBorder(
      side: borderColor != null
          ? BorderSide(color: borderColor!, width: borderWidth)
          : BorderSide.none,
    );

    return Material(
      color: backgroundColor,
      shape: shape,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onPressed,
        customBorder: shape,
        splashColor: AppTheme.primary.withValues(alpha: 0.14),
        highlightColor: AppTheme.primary.withValues(alpha: 0.08),
        child: SizedBox(
          width: size,
          height: size,
          child: Center(
            child: AppHugeIcon(
              icon: icon,
              size: iconSize,
              color: resolvedIconColor,
            ),
          ),
        ),
      ),
    );
  }
}
