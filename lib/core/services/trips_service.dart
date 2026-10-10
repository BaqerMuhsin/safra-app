import 'package:get/get.dart';

import '../../data/mock_data.dart';
import '../../data/models/company.dart';
import '../../data/models/trip.dart';

/// Read access to trips and companies. Backed by [MockData] for now.
class TripsService extends GetxService {
  List<Trip> get trips => MockData.trips;

  List<Company> get companies => MockData.companies;

  List<Trip> byCategory(TripCategory category) =>
      trips.where((t) => t.category == category).toList();

  List<Trip> byCompany(String companyId) =>
      trips.where((t) => t.companyId == companyId).toList();

  Trip tripById(String id) => trips.firstWhere((t) => t.id == id);

  Company companyById(String id) => companies.firstWhere((c) => c.id == id);

  List<Trip> search({String query = '', TripCategory? category}) {
    final q = query.trim();
    return trips.where((t) {
      if (category != null && t.category != category) return false;
      if (q.isEmpty) return true;
      return t.title.contains(q) ||
          t.location.contains(q) ||
          companyById(t.companyId).name.contains(q);
    }).toList();
  }
}
