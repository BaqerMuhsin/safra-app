import 'package:flutter/material.dart';
import 'package:hugeicons/styles/stroke_rounded.dart';

import '../theme/app_fonts.dart';
import '../theme/app_theme.dart';
import 'app_huge_icon.dart';

/// Reusable card for tourist trip packages (search, home, bookings).
class TripCard extends StatelessWidget {
  const TripCard({
    super.key,
    required this.title,
    required this.location,
    required this.priceLabel,
    this.imageUrl,
    this.durationLabel,
    this.dateLabel,
    this.ratingLabel,
    this.statusLabel,
    this.statusColor,
    this.spotsLabel,
    this.onTap,
    this.margin,
    this.width,
    this.imageHeight = defaultImageHeight,
  });

  final String title;
  final String location;
  final String priceLabel;
  final String? imageUrl;
  final String? durationLabel;
  final String? dateLabel;
  final String? ratingLabel;
  final String? statusLabel;
  final Color? statusColor;
  final String? spotsLabel;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? margin;
  final double? width;
  final double imageHeight;

  static const double radius = 18;
  static const double defaultImageHeight = 148;

  @override
  Widget build(BuildContext context) {
    final card = Container(
      width: width,
      margin: margin,
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: AppTheme.border),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          _TripImage(
            imageUrl: imageUrl,
            imageHeight: imageHeight,
            statusLabel: statusLabel,
            statusColor: statusColor,
            ratingLabel: ratingLabel,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 12, 14, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontFamily: AppFonts.elMessiri,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.textStrong,
                    height: 1.25,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const AppHugeIcon(
                      icon: HugeIconsStrokeRounded.mapsLocation01,
                      size: 15,
                      color: AppTheme.primary,
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: Text(
                        location,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontFamily: AppFonts.somarSans,
                          fontSize: 13,
                          color: AppTheme.textBody,
                        ),
                      ),
                    ),
                    if (durationLabel != null && durationLabel!.isNotEmpty) ...[
                      const SizedBox(width: 8),
                      const AppHugeIcon(
                        icon: HugeIconsStrokeRounded.clock01,
                        size: 14,
                        color: AppTheme.textSecondary,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        durationLabel!,
                        style: const TextStyle(
                          fontFamily: AppFonts.somarSans,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.textSecondary,
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 12),
                const Divider(height: 1, color: AppTheme.border),
                const SizedBox(height: 12),
                Row(
                  children: [
                    if (dateLabel != null && dateLabel!.isNotEmpty)
                      Expanded(
                        child: Row(
                          children: [
                            const AppHugeIcon(
                              icon: HugeIconsStrokeRounded.calendar03,
                              size: 15,
                              color: AppTheme.textSecondary,
                            ),
                            const SizedBox(width: 6),
                            Flexible(
                              child: Text(
                                dateLabel!,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontFamily: AppFonts.somarSans,
                                  fontSize: 12,
                                  color: AppTheme.textSecondary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    else if (spotsLabel != null && spotsLabel!.isNotEmpty)
                      Expanded(
                        child: Text(
                          spotsLabel!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontFamily: AppFonts.somarSans,
                            fontSize: 12,
                            color: AppTheme.textSecondary,
                          ),
                        ),
                      )
                    else
                      const Spacer(),
                    Text(
                      priceLabel,
                      style: const TextStyle(
                        fontFamily: AppFonts.elMessiri,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.secondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );

    if (onTap == null) return card;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(radius),
        child: card,
      ),
    );
  }
}

class _TripImage extends StatelessWidget {
  const _TripImage({
    this.imageUrl,
    required this.imageHeight,
    this.statusLabel,
    this.statusColor,
    this.ratingLabel,
  });

  final String? imageUrl;
  final double imageHeight;
  final String? statusLabel;
  final Color? statusColor;
  final String? ratingLabel;

  @override
  Widget build(BuildContext context) {
    final hasImage = imageUrl != null && imageUrl!.trim().isNotEmpty;

    return SizedBox(
      height: imageHeight,
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (hasImage)
            Image.network(
              imageUrl!,
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) => const _ImagePlaceholder(),
              loadingBuilder: (context, child, progress) {
                if (progress == null) return child;
                return const _ImagePlaceholder();
              },
            )
          else
            const _ImagePlaceholder(),
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0x33000000),
                  Color(0x00000000),
                  Color(0x22000000),
                ],
                stops: [0, 0.45, 1],
              ),
            ),
          ),
          if (statusLabel != null && statusLabel!.isNotEmpty)
            Positioned(
              top: 10,
              right: 10,
              child: _Chip(
                label: statusLabel!,
                foreground: Colors.white,
                background: (statusColor ?? AppTheme.primary).withValues(
                  alpha: 0.92,
                ),
              ),
            ),
          if (ratingLabel != null && ratingLabel!.isNotEmpty)
            Positioned(
              top: 10,
              left: 10,
              child: _Chip(
                label: ratingLabel!,
                foreground: AppTheme.textStrong,
                background: Colors.white.withValues(alpha: 0.92),
                leading: const AppHugeIcon(
                  icon: HugeIconsStrokeRounded.star,
                  size: 12,
                  color: Color(0xFFF4A261),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _ImagePlaceholder extends StatelessWidget {
  const _ImagePlaceholder();

  @override
  Widget build(BuildContext context) {
    return const ColoredBox(
      color: AppTheme.primaryLight,
      child: Center(
        child: AppHugeIcon(
          icon: HugeIconsStrokeRounded.airplaneTakeOff01,
          size: 36,
          color: AppTheme.primary,
        ),
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({
    required this.label,
    required this.foreground,
    required this.background,
    this.leading,
  });

  final String label;
  final Color foreground;
  final Color background;
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (leading != null) ...[leading!, const SizedBox(width: 4)],
          Text(
            label,
            style: TextStyle(
              fontFamily: AppFonts.somarSans,
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: foreground,
            ),
          ),
        ],
      ),
    );
  }
}
