/// Arabic display helpers shared across screens.
String formatPrice(int amount) {
  final digits = amount.toString();
  final buffer = StringBuffer();
  for (var i = 0; i < digits.length; i++) {
    if (i > 0 && (digits.length - i) % 3 == 0) buffer.write(',');
    buffer.write(digits[i]);
  }
  return '$buffer د.ع';
}

String durationLabel(int days) => switch (days) {
  1 => 'يوم واحد',
  2 => 'يومان',
  _ => '$days أيام',
};

String tripsCountLabel(int count) => switch (count) {
  0 => 'لا توجد رحلات',
  1 => 'رحلة واحدة',
  2 => 'رحلتان',
  >= 3 && <= 10 => '$count رحلات',
  _ => '$count رحلة',
};

String travelersLabel(int count) => switch (count) {
  1 => 'مسافر واحد',
  2 => 'مسافران',
  >= 3 && <= 10 => '$count مسافرين',
  _ => '$count مسافراً',
};

String seatsLeftLabel(int count) => switch (count) {
  0 => 'اكتملت المقاعد',
  1 => 'مقعد واحد متاح',
  2 => 'مقعدان متاحان',
  >= 3 && <= 10 => '$count مقاعد متاحة',
  _ => '$count مقعداً متاحاً',
};
