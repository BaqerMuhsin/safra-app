import 'package:flutter/material.dart';
import 'package:hugeicons/styles/stroke_rounded.dart';

import '../theme/app_fonts.dart';
import '../theme/app_theme.dart';
import 'app_huge_icon.dart';

/// Reusable card for tour companies / travel agencies.
class CompanyCard extends StatelessWidget {
  const CompanyCard({
    super.key,
    required this.name,
    required this.location,
    this.imageUrl,
    this.specialty,
    this.tripsCountLabel,
    this.ratingLabel,
    this.onTap,
    this.margin,
  });

  final String name;
  final String location;
  final String? imageUrl;
  final String? specialty;
  final String? tripsCountLabel;
  final String? ratingLabel;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? margin;

  static const double radius = 18;

  @override
  Widget build(BuildContext context) {
    final card = Container(
      margin: margin,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: AppTheme.border),
      ),
      child: Row(
        children: [
          _Logo(imageUrl: imageUrl, name: name),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontFamily: AppFonts.elMessiri,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppTheme.textStrong,
                        ),
                      ),
                    ),
                    if (ratingLabel != null && ratingLabel!.isNotEmpty) ...[
                      const SizedBox(width: 8),
                      const AppHugeIcon(
                        icon: HugeIconsStrokeRounded.star,
                        size: 13,
                        color: Color(0xFFF4A261),
                      ),
                      const SizedBox(width: 3),
                      Text(
                        ratingLabel!,
                        style: const TextStyle(
                          fontFamily: AppFonts.somarSans,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.textStrong,
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const AppHugeIcon(
                      icon: HugeIconsStrokeRounded.mapsLocation01,
                      size: 14,
                      color: AppTheme.primary,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        location,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontFamily: AppFonts.somarSans,
                          fontSize: 12,
                          color: AppTheme.textBody,
                        ),
                      ),
                    ),
                  ],
                ),
                if ((specialty != null && specialty!.isNotEmpty) ||
                    (tripsCountLabel != null &&
                        tripsCountLabel!.isNotEmpty)) ...[
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      if (specialty != null && specialty!.isNotEmpty)
                        Flexible(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: AppTheme.primaryLight,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              specialty!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontFamily: AppFonts.somarSans,
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: AppTheme.primary,
                              ),
                            ),
                          ),
                        ),
                      if (tripsCountLabel != null &&
                          tripsCountLabel!.isNotEmpty) ...[
                        const SizedBox(width: 8),
                        Text(
                          tripsCountLabel!,
                          style: const TextStyle(
                            fontFamily: AppFonts.somarSans,
                            fontSize: 11,
                            color: AppTheme.textSecondary,
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
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

class _Logo extends StatelessWidget {
  const _Logo({required this.name, this.imageUrl});

  final String name;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    final hasImage = imageUrl != null && imageUrl!.trim().isNotEmpty;

    return Container(
      width: 64,
      height: 64,
      decoration: BoxDecoration(
        color: AppTheme.primaryLight,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.border),
      ),
      clipBehavior: Clip.antiAlias,
      child: hasImage
          ? Image.network(
              imageUrl!,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => _Initials(name: name),
              loadingBuilder: (context, child, progress) {
                if (progress == null) return child;
                return _Initials(name: name);
              },
            )
          : _Initials(name: name),
    );
  }
}

class _Initials extends StatelessWidget {
  const _Initials({required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        name.isEmpty ? 'ش' : String.fromCharCodes(name.runes.take(1)),
        style: const TextStyle(
          fontFamily: AppFonts.elMessiri,
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: AppTheme.primary,
        ),
      ),
    );
  }
}
