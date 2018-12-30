import 'package:eqamah/api/api_service.dart';
import 'package:eqamah/models/dashboard/mosque_model.dart';

class PrayerTimeRepository {
  final prayerTimeProvider = PrayerTimeProvider();

  Future<DashboardMosqueModel> fetchPrayerTimes(double lat, double long) =>
      prayerTimeProvider.getPrayerTimes(lat, long);
}
