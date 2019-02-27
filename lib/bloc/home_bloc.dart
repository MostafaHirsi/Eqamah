import 'package:eqamah/models/dashboard/mosque_model.dart';
import 'package:eqamah/utils/calculations.dart';
import 'package:rxdart/rxdart.dart';
import 'package:eqamah/resources/prayer_time_resources.dart';
import 'package:location/location.dart';

class PrayerTimeBloc {
  final _prayerTimeRepository = PrayerTimeRepository();
  final _prayerTimeFetcher = PublishSubject<DashboardMosqueModel>();

  DashboardMosqueModel mosqueModel;

  Observable<DashboardMosqueModel> get allPrayers => _prayerTimeFetcher.stream;

  fetchAllPrayers() async {
    double lat, long;
    var location = new Location();
    Future<Map<String, double>> currentLocation = location.getLocation();
    currentLocation.then((obj) async {
      lat = obj["latitude"];
      long = obj["longitude"];
      double direction = qiblaDirection(lat,long);
      DashboardMosqueModel mosqueModel =
          await _prayerTimeRepository.fetchPrayerTimes(lat, long);
      _prayerTimeFetcher.sink.add(mosqueModel);
    });
  }

  dispose() {
    _prayerTimeFetcher.close();
  }
}

final prayerTimeBloc = PrayerTimeBloc();
