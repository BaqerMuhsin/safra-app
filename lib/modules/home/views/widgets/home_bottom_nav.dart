import 'dart:io';
import 'dart:ui' show ImageFilter, lerpDouble;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/app_huge_icon.dart';
import '../../controllers/home_controller.dart';
import '../../home_tab.dart';

class HomeBottomNav extends GetView<HomeController> {
  const HomeBottomNav({super.key});

  static const double _pillHeight = 64;
  static const double _maxWidth = 310;
  static const Duration _animDuration = Duration(milliseconds: 300);
  static const Curve _animCurve = Curves.easeOutCubic;

  @override
  Widget build(BuildContext context) {
    final androidSpacing = !Platform.isAndroid ? 12 : 0;
    final bottomInset = MediaQuery.of(context).padding.bottom + androidSpacing;

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.transparent, Colors.transparent],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      padding: EdgeInsets.only(bottom: bottomInset),
      child: SizedBox(
        height: _pillHeight,
        child: Obx(
          () => _AnimatedHomeBottomNav(
            currentIndex: controller.currentTabIndex.value,
            onTap: (index) {
              if (index == controller.currentTabIndex.value) return;
              HapticFeedback.selectionClick();
              controller.selectTab(index);
            },
          ),
        ),
      ),
    );
  }
}

class _AnimatedHomeBottomNav extends StatelessWidget {
  const _AnimatedHomeBottomNav({
    required this.currentIndex,
    required this.onTap,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: HomeBottomNav._maxWidth),
        child: AnimatedSize(
          duration: HomeBottomNav._animDuration,
          curve: HomeBottomNav._animCurve,
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          child: _GlassNavBar(
            height: HomeBottomNav._pillHeight,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(HomeTab.count, (i) {
                final tab = HomeTab.fromIndex(i);
                return _NavSlot(
                  tab: tab,
                  selected: i == currentIndex,
                  onTap: () => onTap(i),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}

class _GlassNavBar extends StatelessWidget {
  const _GlassNavBar({required this.height, required this.child});

  final double height;
  final Widget child;

  static const _blurSigma = 18.0;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(height / 2);

    return ClipRRect(
      borderRadius: radius,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: _blurSigma, sigmaY: _blurSigma),
        child: Container(
          height: height,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: radius,
            color: AppTheme.primary.withValues(alpha: 0.72),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.22),
            ),
            boxShadow: [
              BoxShadow(
                color: AppTheme.primaryDark.withValues(alpha: 0.28),
                blurRadius: 24,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: child,
        ),
      ),
    );
  }
}

class _NavSlot extends StatelessWidget {
  const _NavSlot({
    required this.tab,
    required this.selected,
    required this.onTap,
  });

  final HomeTab tab;
  final bool selected;
  final VoidCallback onTap;

  static const _kCircle = 44.0;
  static const _kPillH = 44.0;
  static const _kDur = HomeBottomNav._animDuration;
  static const _kCurve = HomeBottomNav._animCurve;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: selected ? 1 : 0),
      duration: _kDur,
      curve: _kCurve,
      builder: (context, t, _) {
        final width = lerpDouble(_kCircle, tab.pillWidth, t)!;
        final radius = Radius.circular(lerpDouble(_kCircle / 2, 28, t)!);

        final iconSize = lerpDouble(22, 20, t)!;
        final iconColor = Color.lerp(Colors.white, AppTheme.primary, t)!;
        final backgroundColor = Color.lerp(
          Colors.transparent,
          AppTheme.surface,
          t,
        )!;
        final labelOpacity = t;
        final spacerWidth = 8.0 * t;

        return Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.all(radius),
            splashColor: AppTheme.primary.withValues(alpha: 0.08),
            highlightColor: AppTheme.primary.withValues(alpha: 0.04),
            child: Center(
              child: Container(
                width: width,
                height: _kPillH,
                margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                padding: EdgeInsets.all(lerpDouble(0, 3, t)!),
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.all(radius),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppHugeIcon(
                      icon: tab.icon,
                      size: iconSize,
                      color: iconColor,
                    ),
                    SizedBox(width: spacerWidth),
                    ClipRect(
                      child: Align(
                        widthFactor: t,
                        alignment: AlignmentDirectional.centerStart,
                        child: Opacity(
                          opacity: labelOpacity,
                          child: Text(
                            tab.label,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.labelLarge?.copyWith(
                              color: AppTheme.primary,
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
