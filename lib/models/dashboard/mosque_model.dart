class DashboardMosqueModel {
  final String mosqueName;

  final List<PrayerTime> prayerTimes;

  DashboardMosqueModel({this.mosqueName, this.prayerTimes});

  factory DashboardMosqueModel.fromJson(Map<String, dynamic> json) {
    var data = json["data"]["timings"];
    List<PrayerTime> _prayerTimes = [];
    data.forEach((key, value) {
      PrayerTime g = parseTime(key, value);
      _prayerTimes.add(g);
    });
    return DashboardMosqueModel(
        prayerTimes: _prayerTimes, mosqueName: "Blue Mosque");
  }

  static parseTime(dynamic key, dynamic value) {
    String val = value.toString();
    DateTime todayDate = DateTime.now();
    int hours = int.parse(val.split(":")[0]);
    int minutes = int.parse(val.split(":")[1]);
    return new PrayerTime(
        prayerName: key,
        prayerTime: new DateTime(
            todayDate.year, todayDate.month, todayDate.day, hours, minutes));
  }
}

class PrayerTime {
  final DateTime prayerTime;
  final String prayerName;

  PrayerTime({this.prayerName, this.prayerTime});

  factory PrayerTime.fromJson(Map<String, dynamic> json) {
    return PrayerTime();
  }
}
