import 'package:flutter/material.dart';
import 'package:hugeicons/styles/stroke_rounded.dart';

import '../theme/app_theme.dart';
import 'app_huge_icon.dart';

/// Network image with the branded placeholder while loading or on failure.
class AppNetworkImage extends StatelessWidget {
  const AppNetworkImage({super.key, required this.url, this.iconSize = 36});

  final String url;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    final placeholder = ColoredBox(
      color: AppTheme.primaryLight,
      child: Center(
        child: AppHugeIcon(
          icon: HugeIconsStrokeRounded.airplaneTakeOff01,
          size: iconSize,
          color: AppTheme.primary,
        ),
      ),
    );

    if (url.trim().isEmpty) return placeholder;

    return Image.network(
      url,
      fit: BoxFit.cover,
      errorBuilder: (_, _, _) => placeholder,
      loadingBuilder: (context, child, progress) =>
          progress == null ? child : placeholder,
    );
  }
}
