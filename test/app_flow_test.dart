import 'dart:io';

import 'package:app_temp/app/routes/app_routes.dart';
import 'package:app_temp/core/services/bookings_service.dart';
import 'package:app_temp/core/services/notifications_service.dart';
import 'package:app_temp/core/services/trips_service.dart';
import 'package:app_temp/core/widgets/trip_card.dart';
import 'package:app_temp/main.dart';
import 'package:app_temp/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

Future<void> _loadFont(String family, List<String> files) async {
  final loader = FontLoader(family);
  for (final file in files) {
    final bytes = File('assets/fonts/$file').readAsBytesSync();
    loader.addFont(Future.value(ByteData.view(bytes.buffer)));
  }
  await loader.load();
}

/// The header backdrop animates forever, so `pumpAndSettle` never returns.
Future<void> _settle(WidgetTester tester) async {
  for (var i = 0; i < 6; i++) {
    await tester.pump(const Duration(milliseconds: 300));
  }
}

void main() {
  setUpAll(() async {
    await _loadFont('SomarSans', [
      'SomarSans-Regular.otf',
      'SomarSans-Medium.otf',
      'SomarSans-SemiBold.otf',
      'SomarSans-Bold.otf',
    ]);
    await _loadFont('ElMessiri', ['ElMessiri-Variable.ttf']);
  });

  tearDown(Get.reset);

  for (final size in const [Size(390, 844), Size(320, 568)]) {
    testWidgets('sign in, book a trip and browse every screen at $size', (
      tester,
    ) async {
      tester.view.physicalSize = size;
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);

      await tester.pumpWidget(const App());
      await _settle(tester);

      // Login: phone, then OTP.
      await tester.enterText(find.byType(TextField), '7701234567');
      await tester.pump();
      await tester.tap(find.text('متابعة'));
      await _settle(tester);
      expect(find.text('أدخل رمز التحقق'), findsOneWidget);
      expect(find.textContaining('إعادة الإرسال'), findsOneWidget);

      await tester.enterText(find.byType(TextField), '123456');
      await tester.pump();
      await tester.tap(find.text('تأكيد'));
      await _settle(tester);
      expect(find.text('اكتشف رحلتك'), findsOneWidget);

      // Home → trip details → booking → success.
      await tester.tap(find.byType(TripCard).first);
      await _settle(tester);
      expect(find.text('برنامج الرحلة'), findsOneWidget);

      await tester.tap(find.text('احجز الآن'));
      await _settle(tester);
      expect(find.text('إتمام الحجز'), findsOneWidget);

      await tester.enterText(find.byType(TextField), 'علي حسن');
      await tester.pump();
      await tester.tap(find.textContaining('تأكيد الحجز'));
      await _settle(tester);
      expect(find.text('تم تأكيد حجزك!'), findsOneWidget);

      final bookings = Get.find<BookingsService>();
      expect(bookings.upcoming.length, 2);
      expect(Get.find<NotificationsService>().unreadCount, 3);

      await tester.tap(find.text('عرض رحلاتي'));
      await _settle(tester);
      expect(Get.find<HomeController>().currentTabIndex.value, 1);
      expect(find.text('أهلاً، علي!'), findsOneWidget);

      // Remaining tabs.
      for (final index in [2, 3, 0]) {
        Get.find<HomeController>().selectTab(index);
        await _settle(tester);
      }

      // Secondary screens.
      final trips = Get.find<TripsService>();
      final routes = <String, Object?>{
        AppRoutes.trips: {'focusSearch': true},
        AppRoutes.companyDetails: trips.companies.first,
        AppRoutes.bookingDetails: bookings.upcoming.first.id,
        AppRoutes.notifications: null,
        AppRoutes.profile: null,
        AppRoutes.terms: null,
      };
      for (final entry in routes.entries) {
        Get.toNamed(entry.key, arguments: entry.value);
        await _settle(tester);
        await tester.drag(find.byType(Scrollable).last, const Offset(0, -600));
        await _settle(tester);
        Get.back();
        await _settle(tester);
      }

      // Scroll the long trip page end to end.
      Get.toNamed(AppRoutes.tripDetails, arguments: trips.trips.first);
      await _settle(tester);
      await tester.drag(find.byType(Scrollable).first, const Offset(0, -1500));
      await _settle(tester);
      expect(find.text('نقطة التجمّع'), findsOneWidget);
    });
  }
}
