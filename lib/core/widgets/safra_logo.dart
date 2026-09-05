import 'package:flutter/material.dart';
import 'package:hugeicons/styles/stroke_rounded.dart';

import '../theme/app_fonts.dart';
import '../theme/app_theme.dart';
import 'app_huge_icon.dart';

class SafraLogo extends StatelessWidget {
  const SafraLogo({super.key, this.iconSize = 40, this.fontSize = 32});

  final double iconSize;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppHugeIcon(
          icon: HugeIconsStrokeRounded.airplaneTakeOff01,
          color: AppTheme.secondary,
          size: iconSize,
        ),
        const SizedBox(width: 8),
        Text(
          'سفره',
          style: TextStyle(
            fontFamily: AppFonts.elMessiri,
            fontSize: fontSize,
            fontWeight: FontWeight.w700,
            color: AppTheme.primary,
            height: 1,
          ),
        ),
      ],
    );
  }
}
