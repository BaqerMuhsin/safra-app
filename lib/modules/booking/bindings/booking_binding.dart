import 'package:get/get.dart';

import '../controllers/booking_controller.dart';

class BookingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => BookingController(bookings: Get.find(), session: Get.find()),
    );
  }
}
