import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:hugeicons/styles/stroke_rounded.dart';

import '../theme/app_theme.dart';
import 'app_huge_icon.dart';

/// Branded gradient background with floating travel motifs — header & splash.
class BrandGradientBackdrop extends StatelessWidget {
  const BrandGradientBackdrop({
    super.key,
    required this.child,
    this.padding,
    this.expand = false,
    this.showTravelMotifs = true,
    this.borderRadius,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final bool expand;
  final bool showTravelMotifs;
  final BorderRadiusGeometry? borderRadius;

  static BoxDecoration decoration({BorderRadiusGeometry? borderRadius}) =>
      BoxDecoration(
        borderRadius: borderRadius,
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppTheme.primaryDark,
            AppTheme.primary,
            AppTheme.primarySoft,
            AppTheme.headerGlow,
          ],
          stops: [0.0, 0.38, 0.72, 1.0],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: expand ? double.infinity : null,
      padding: padding,
      clipBehavior: borderRadius != null ? Clip.antiAlias : Clip.none,
      decoration: decoration(borderRadius: borderRadius),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          const _FloatingBrandOrb(
            top: -10,
            right: -36,
            size: 140,
            opacity: 0.18,
            phase: 0,
            duration: Duration(milliseconds: 5200),
          ),
          const _FloatingBrandOrb(
            top: 58,
            left: -30,
            size: 100,
            opacity: 0.12,
            phase: 1.7,
            duration: Duration(milliseconds: 6600),
          ),
          if (showTravelMotifs) ...[
            const _FloatingTravelIcon(
              icon: HugeIconsStrokeRounded.airplaneTakeOff01,
              top: 8,
              right: 64,
              size: 34,
              opacity: 0.16,
              phase: 0.4,
              duration: Duration(milliseconds: 7400),
              driftX: 10,
              driftY: 6,
            ),
            const _FloatingTravelIcon(
              icon: HugeIconsStrokeRounded.mapsLocation01,
              top: 52,
              left: -4,
              size: 28,
              opacity: 0.14,
              phase: 1.2,
              duration: Duration(milliseconds: 8200),
              driftX: 7,
              driftY: 9,
            ),
            const _FloatingTravelIcon(
              icon: HugeIconsStrokeRounded.bus01,
              bottom: 36,
              right: 110,
              size: 30,
              opacity: 0.12,
              phase: 2.1,
              duration: Duration(milliseconds: 9000),
              driftX: 8,
              driftY: 5,
            ),
          ],
          child,
        ],
      ),
    );
  }
}

class _FloatingBrandOrb extends StatefulWidget {
  const _FloatingBrandOrb({
    this.top,
    this.left,
    this.right,
    required this.size,
    required this.opacity,
    required this.phase,
    required this.duration,
  });

  final double? top;
  final double? left;
  final double? right;
  final double size;
  final double opacity;
  final double phase;
  final Duration duration;

  @override
  State<_FloatingBrandOrb> createState() => _FloatingBrandOrbState();
}

class _FloatingBrandOrbState extends State<_FloatingBrandOrb>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: widget.top,
      left: widget.left,
      right: widget.right,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          final t = (_controller.value * 2 * math.pi) + widget.phase;
          return Transform.translate(
            offset: Offset(math.cos(t) * 6, math.sin(t) * 8),
            child: child,
          );
        },
        child: IgnorePointer(
          child: Container(
            width: widget.size,
            height: widget.size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withValues(alpha: widget.opacity),
            ),
          ),
        ),
      ),
    );
  }
}

class _FloatingTravelIcon extends StatefulWidget {
  const _FloatingTravelIcon({
    required this.icon,
    this.top,
    this.left,
    this.right,
    this.bottom,
    required this.size,
    required this.opacity,
    required this.phase,
    required this.duration,
    this.driftX = 8,
    this.driftY = 6,
  });

  final List<List<dynamic>> icon;
  final double? top;
  final double? left;
  final double? right;
  final double? bottom;
  final double size;
  final double opacity;
  final double phase;
  final Duration duration;
  final double driftX;
  final double driftY;

  @override
  State<_FloatingTravelIcon> createState() => _FloatingTravelIconState();
}

class _FloatingTravelIconState extends State<_FloatingTravelIcon>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: widget.top,
      left: widget.left,
      right: widget.right,
      bottom: widget.bottom,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          final t = (_controller.value * 2 * math.pi) + widget.phase;
          return Transform.translate(
            offset: Offset(
              math.cos(t) * widget.driftX,
              math.sin(t) * widget.driftY,
            ),
            child: Transform.rotate(angle: math.sin(t) * 0.08, child: child),
          );
        },
        child: IgnorePointer(
          child: Opacity(
            opacity: widget.opacity,
            child: AppHugeIcon(
              icon: widget.icon,
              size: widget.size,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
