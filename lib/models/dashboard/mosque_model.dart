class DashboardMosqueModel {
  final String mosqueName;

  final List<PrayerModel> prayerTimes;

  DashboardMosqueModel({this.mosqueName, this.prayerTimes});

  factory DashboardMosqueModel.fromJson(Map<String, dynamic> json) {
    var data = json["data"]["timings"];
    List<PrayerModel> _prayerTimes = [];
    data.forEach((key, value) {
      PrayerModel g = parseTime(key, value);
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
    return new PrayerModel(
        prayerName: key,
        prayerTime: new DateTime.utc(
            todayDate.year, todayDate.month, todayDate.day, hours, minutes,));
  }
}

class PrayerModel {
  final DateTime prayerTime;
  final String prayerName;

  PrayerModel({this.prayerName, this.prayerTime});

  factory PrayerModel.fromJson(Map<String, dynamic> json) {
    return PrayerModel();
  }
}
