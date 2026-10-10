import 'package:get/get.dart';

import '../../data/models/app_notification.dart';
import '../../data/models/booking.dart';
import '../../data/models/trip.dart';
import 'notifications_service.dart';
import 'trips_service.dart';

/// The traveler's bookings. In-memory until the backend API is connected.
class BookingsService extends GetxService {
  BookingsService({
    required TripsService trips,
    required NotificationsService notifications,
  }) : _trips = trips,
       _notifications = notifications;

  final TripsService _trips;
  final NotificationsService _notifications;

  final RxList<Booking> bookings = <Booking>[].obs;

  var _sequence = 48213;

  @override
  void onInit() {
    super.onInit();
    bookings.assignAll([
      Booking(
        id: 'b1',
        reference: 'SF-048211',
        trip: _trips.tripById('southern-marshes'),
        travelers: 2,
        passengerName: 'مسافر سفره',
        phone: '',
        paymentMethod: PaymentMethod.cash,
        status: BookingStatus.upcoming,
      ),
      Booking(
        id: 'b2',
        reference: 'SF-048102',
        trip: _trips.tripById('erbil-historic'),
        travelers: 1,
        passengerName: 'مسافر سفره',
        phone: '',
        paymentMethod: PaymentMethod.zainCash,
        status: BookingStatus.completed,
        dateLabelOverride: 'الثلاثاء · 29 أيلول',
      ),
    ]);
  }

  List<Booking> get upcoming =>
      bookings.where((b) => b.status == BookingStatus.upcoming).toList();

  List<Booking> get past =>
      bookings.where((b) => b.status != BookingStatus.upcoming).toList();

  Booking? byId(String id) => bookings.firstWhereOrNull((b) => b.id == id);

  Booking book({
    required Trip trip,
    required int travelers,
    required String passengerName,
    required String phone,
    required PaymentMethod paymentMethod,
  }) {
    _sequence++;
    final booking = Booking(
      id: 'b$_sequence',
      reference: 'SF-${_sequence.toString().padLeft(6, '0')}',
      trip: trip,
      travelers: travelers,
      passengerName: passengerName,
      phone: phone,
      paymentMethod: paymentMethod,
      status: BookingStatus.upcoming,
    );
    bookings.insert(0, booking);
    _notifications.add(
      kind: NotificationKind.booking,
      title: 'تم تأكيد حجزك',
      body: '${trip.title} · رقم الحجز ${booking.reference}',
    );
    return booking;
  }

  void cancel(String id) {
    final index = bookings.indexWhere((b) => b.id == id);
    if (index == -1) return;
    final booking = bookings[index];
    bookings[index] = booking.copyWith(status: BookingStatus.cancelled);
    _notifications.add(
      kind: NotificationKind.booking,
      title: 'تم إلغاء الحجز',
      body: '${booking.trip.title} · رقم الحجز ${booking.reference}',
    );
  }
}
