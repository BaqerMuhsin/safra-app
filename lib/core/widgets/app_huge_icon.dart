import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class AppHugeIcon extends StatelessWidget {
  const AppHugeIcon({
    super.key,
    required this.icon,
    this.size = 24,
    this.color,
    this.strokeWidth,
  });

  final List<List<dynamic>> icon;
  final double size;
  final Color? color;
  final double? strokeWidth;

  @override
  Widget build(BuildContext context) {
    return HugeIcon(
      icon: icon,
      size: size,
      color: color,
      strokeWidth: strokeWidth,
    );
  }
}
