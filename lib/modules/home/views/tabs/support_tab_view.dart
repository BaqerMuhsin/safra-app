import 'package:flutter/material.dart';
import 'package:hugeicons/styles/stroke_rounded.dart';

import '../../../../core/theme/app_fonts.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/app_huge_icon.dart';
import '../../../../core/widgets/app_page_header.dart';

class SupportTabView extends StatelessWidget {
  const SupportTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const AppPageHeader(title: 'الدعم', showBack: false),
        Expanded(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 100),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  AppHugeIcon(
                    icon: HugeIconsStrokeRounded.customerSupport,
                    size: 40,
                    color: AppTheme.primary,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'تواصل مع فريق سفره للمساعدة',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: AppFonts.somarSans,
                      fontSize: 15,
                      color: AppTheme.textBody,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
