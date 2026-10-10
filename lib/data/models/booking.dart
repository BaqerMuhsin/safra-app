import 'package:flutter/material.dart';
import 'package:hugeicons/styles/stroke_rounded.dart';

import '../../core/theme/app_theme.dart';
import '../../core/utils/formatters.dart';
import 'trip.dart';

enum BookingStatus {
  upcoming(label: 'قادمة', color: AppTheme.primary),
  completed(label: 'مكتملة', color: Color(0xFF2A9D8F)),
  cancelled(label: 'ملغاة', color: Color(0xFFE63946));

  const BookingStatus({required this.label, required this.color});

  final String label;
  final Color color;
}

enum PaymentMethod {
  cash(
    label: 'نقداً عند الصعود',
    hint: 'ادفع للمشرف يوم الرحلة',
    icon: HugeIconsStrokeRounded.cash01,
  ),
  zainCash(
    label: 'زين كاش',
    hint: 'محفظة إلكترونية',
    icon: HugeIconsStrokeRounded.wallet01,
  ),
  card(
    label: 'بطاقة مصرفية',
    hint: 'ماستر كارد · فيزا',
    icon: HugeIconsStrokeRounded.creditCard,
  );

  const PaymentMethod({
    required this.label,
    required this.hint,
    required this.icon,
  });

  final String label;
  final String hint;
  final List<List<dynamic>> icon;
}

class Booking {
  const Booking({
    required this.id,
    required this.reference,
    required this.trip,
    required this.travelers,
    required this.passengerName,
    required this.phone,
    required this.paymentMethod,
    required this.status,
    this.dateLabelOverride,
  });

  final String id;
  final String reference;
  final Trip trip;
  final int travelers;
  final String passengerName;
  final String phone;
  final PaymentMethod paymentMethod;
  final BookingStatus status;
  final String? dateLabelOverride;

  int get total => trip.price * travelers;

  String get totalLabel => formatPrice(total);

  String get dateLabel => dateLabelOverride ?? trip.dateLabel;

  Booking copyWith({BookingStatus? status}) => Booking(
    id: id,
    reference: reference,
    trip: trip,
    travelers: travelers,
    passengerName: passengerName,
    phone: phone,
    paymentMethod: paymentMethod,
    status: status ?? this.status,
    dateLabelOverride: dateLabelOverride,
  );
}
