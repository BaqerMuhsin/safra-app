import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/services/trips_service.dart';
import '../../../data/models/trip.dart';

class TripsListController extends GetxController {
  TripsListController({required TripsService trips}) : _trips = trips;

  final TripsService _trips;

  final searchController = TextEditingController();
  final RxString query = ''.obs;
  final Rxn<TripCategory> category = Rxn<TripCategory>();

  bool focusSearch = false;

  List<Trip> get results =>
      _trips.search(query: query.value, category: category.value);

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args is Map) {
      category.value = args['category'] as TripCategory?;
      focusSearch = args['focusSearch'] == true;
    }
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  void onQueryChanged(String value) => query.value = value;

  void selectCategory(TripCategory? value) => category.value = value;

  void clearFilters() {
    searchController.clear();
    query.value = '';
    category.value = null;
  }
}
