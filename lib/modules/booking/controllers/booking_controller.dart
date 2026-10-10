import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/routes/app_routes.dart';
import '../../../core/services/bookings_service.dart';
import '../../../core/services/session_service.dart';
import '../../../core/utils/formatters.dart';
import '../../../data/models/booking.dart';
import '../../../data/models/trip.dart';

class BookingController extends GetxController {
  BookingController({
    required BookingsService bookings,
    required SessionService session,
  }) : _bookings = bookings,
       _session = session;

  final BookingsService _bookings;
  final SessionService _session;

  static const _maxTravelersPerBooking = 10;

  late final Trip trip;
  late final TextEditingController nameController;

  final RxInt travelers = 1.obs;
  final Rx<PaymentMethod> paymentMethod = PaymentMethod.cash.obs;
  final RxBool isValidName = false.obs;
  final RxBool isLoading = false.obs;

  String get phone => _session.phone.value;

  int get maxTravelers => math.min(trip.seatsLeft, _maxTravelersPerBooking);

  int get total => trip.price * travelers.value;

  String get totalLabel => formatPrice(total);

  @override
  void onInit() {
    super.onInit();
    trip = Get.arguments as Trip;
    nameController = TextEditingController(text: _session.name.value);
    onNameChanged(nameController.text);
  }

  @override
  void onClose() {
    nameController.dispose();
    super.onClose();
  }

  void onNameChanged(String value) {
    isValidName.value = value.trim().length >= 3;
  }

  void increment() {
    if (travelers.value < maxTravelers) travelers.value++;
  }

  void decrement() {
    if (travelers.value > 1) travelers.value--;
  }

  void selectPayment(PaymentMethod method) => paymentMethod.value = method;

  Future<void> confirm() async {
    if (!isValidName.value || isLoading.value) return;

    isLoading.value = true;
    await Future<void>.delayed(const Duration(milliseconds: 700));

    final name = nameController.text.trim();
    if (_session.name.value.trim().isEmpty) _session.name.value = name;

    final booking = _bookings.book(
      trip: trip,
      travelers: travelers.value,
      passengerName: name,
      phone: phone,
      paymentMethod: paymentMethod.value,
    );
    isLoading.value = false;

    Get.offNamedUntil(
      AppRoutes.bookingSuccess,
      (route) => route.settings.name == AppRoutes.home,
      arguments: booking,
    );
  }
}
