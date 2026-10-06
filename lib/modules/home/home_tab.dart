import 'package:hugeicons/styles/stroke_rounded.dart';

enum HomeTab {
  home(icon: HugeIconsStrokeRounded.home01, label: 'الرئيسية', pillWidth: 121),
  trips(icon: HugeIconsStrokeRounded.ticket01, label: 'رحلاتي', pillWidth: 108),
  companies(
    icon: HugeIconsStrokeRounded.building03,
    label: 'الشركات',
    pillWidth: 110,
  ),
  more(icon: HugeIconsStrokeRounded.settings01, label: 'المزيد', pillWidth: 96);

  const HomeTab({
    required this.icon,
    required this.label,
    required this.pillWidth,
  });

  final List<List<dynamic>> icon;
  final String label;
  final double pillWidth;

  static HomeTab fromIndex(int index) => HomeTab.values[index];

  static int get count => HomeTab.values.length;
}
