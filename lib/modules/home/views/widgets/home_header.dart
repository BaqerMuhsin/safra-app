import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/styles/stroke_rounded.dart';

import '../../../../app/routes/app_routes.dart';
import '../../../../core/theme/app_fonts.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/app_circle_icon_button.dart';
import '../../../../core/widgets/brand_gradient_backdrop.dart';
import '../../controllers/home_controller.dart';

class HomeHeader extends GetView<HomeController> {
  const HomeHeader({super.key});

  static const bottomRadius = 24.0;

  @override
  Widget build(BuildContext context) {
    final top = MediaQuery.paddingOf(context).top;
    final theme = Theme.of(context);

    return Obx(() {
      final t = controller.headerCollapse;
      final topPad = HomeController.headerTopPadding - (4 * t);
      final bottomPad = HomeController.headerBottomPadding - (8 * t);
      final avatarRadius = 24.0 - (5 * t);
      final titleSize = 18.0 - (1.5 * t);
      final iconSize = 46.0 - (4 * t);
      final subtitleOpacity = (1.0 - t).clamp(0.0, 1.0);

      return BrandGradientBackdrop(
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.circular(bottomRadius),
        ),
        padding: EdgeInsets.fromLTRB(16, top + topPad, 16, bottomPad),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Row(
                children: [
                  _AvatarRing(
                    child: CircleAvatar(
                      radius: avatarRadius,
                      backgroundColor: Colors.white.withValues(alpha: 0.22),
                      child: Text(
                        controller.avatarInitial,
                        style: TextStyle(
                          fontFamily: AppFonts.elMessiri,
                          fontSize: 20 - (3 * t),
                          fontWeight: FontWeight.w700,
                          color: AppTheme.onPrimary,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          controller.greetingTitle,
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontFamily: AppFonts.elMessiri,
                            fontWeight: FontWeight.w700,
                            fontSize: titleSize,
                            color: AppTheme.onPrimary,
                            height: 1.15,
                          ),
                        ),
                        ClipRect(
                          child: Align(
                            alignment: Alignment.topRight,
                            heightFactor: subtitleOpacity,
                            child: Opacity(
                              opacity: subtitleOpacity,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 2),
                                child: Text(
                                  controller.greetingSubtitle,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: AppTheme.onPrimary.withValues(
                                      alpha: 0.88,
                                    ),
                                    fontSize: 13,
                                    height: 1.35,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Stack(
              children: [
                _GlassIconButton(
                  child: AppCircleIconButton(
                    icon: HugeIconsStrokeRounded.notification01,
                    size: iconSize,
                    iconSize: 22 - (2 * t),
                    backgroundColor: Colors.white.withValues(alpha: 0.18),
                    iconColor: AppTheme.onPrimary,
                    borderWidth: 0,
                    onPressed: () => Get.toNamed(AppRoutes.notifications),
                  ),
                ),
                if (controller.hasUnreadNotifications)
                  PositionedDirectional(
                    top: 2,
                    end: 2,
                    child: IgnorePointer(
                      child: Container(
                        width: 11,
                        height: 11,
                        decoration: BoxDecoration(
                          color: AppTheme.secondary,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 1.5),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      );
    });
  }
}

class _AvatarRing extends StatelessWidget {
  const _AvatarRing({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2.5),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white.withValues(alpha: 0.95),
            Colors.white.withValues(alpha: 0.45),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryDark.withValues(alpha: 0.35),
            blurRadius: 0,
            offset: const Offset(2, 6),
          ),
        ],
      ),
      child: child,
    );
  }
}

class _GlassIconButton extends StatelessWidget {
  const _GlassIconButton({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
        child: child,
      ),
    );
  }
}
