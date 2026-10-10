import 'package:hugeicons/styles/stroke_rounded.dart';

import '../../core/utils/formatters.dart' as fmt;

enum TripCategory {
  north(
    title: 'رحلات شمال العراق',
    shortLabel: 'الشمال',
    subtitle: 'أربيل، سليمانية، دهوك والمزيد',
  ),
  shrines(
    title: 'رحلات العتبات المقدسة',
    shortLabel: 'العتبات',
    subtitle: 'النجف، كربلاء، الكاظمين وسامراء',
  ),
  south(
    title: 'رحلات جنوب العراق',
    shortLabel: 'الجنوب',
    subtitle: 'الأهوار، البصرة والفاو',
  ),
  nature(
    title: 'رحلات الطبيعة',
    shortLabel: 'الطبيعة',
    subtitle: 'شلالات وبحيرات ومناظر خلابة',
  );

  const TripCategory({
    required this.title,
    required this.shortLabel,
    required this.subtitle,
  });

  final String title;
  final String shortLabel;
  final String subtitle;
}

typedef ItineraryStep = ({String title, String details});
typedef TripInclude = ({List<List<dynamic>> icon, String label});

class Trip {
  const Trip({
    required this.id,
    required this.title,
    required this.location,
    required this.category,
    required this.companyId,
    required this.days,
    required this.dateLabel,
    required this.price,
    required this.rating,
    required this.imageUrl,
    required this.description,
    required this.highlights,
    required this.itinerary,
    required this.meetingPoint,
    this.seatsLeft = 12,
  });

  final String id;
  final String title;
  final String location;
  final TripCategory category;
  final String companyId;
  final int days;
  final String dateLabel;

  /// Price per traveler in Iraqi dinars.
  final int price;
  final String rating;
  final String imageUrl;
  final String description;
  final List<String> highlights;
  final List<ItineraryStep> itinerary;
  final String meetingPoint;
  final int seatsLeft;

  String get priceLabel => fmt.formatPrice(price);

  String get durationLabel => fmt.durationLabel(days);

  List<TripInclude> get includes => [
    (icon: HugeIconsStrokeRounded.bus01, label: 'نقل سياحي مكيّف'),
    (icon: HugeIconsStrokeRounded.userGroup, label: 'مرشد سياحي'),
    (icon: HugeIconsStrokeRounded.restaurant01, label: 'وجبات الطعام'),
    if (days > 1) (icon: HugeIconsStrokeRounded.hotel01, label: 'إقامة فندقية'),
    (icon: HugeIconsStrokeRounded.securityCheck, label: 'تأمين الرحلة'),
  ];
}
