import 'dart:async';
import 'dart:convert';
import 'package:eqamah/models/dashboard/mosque_model.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class PrayerTimeProvider {
  // Future<DashboardMosqueModel> getPrayerTimes(String params) async {
  //   final response = await http.get('http://api.aladhan.com/v1' + params);
  //   return DashboardMosqueModel.fromJson(json.decode(response.body));
  // }  
  
  Future<DashboardMosqueModel> getPrayerTimes(double lat, double long) async {
    final response = await http.get('http://api.aladhan.com/v1/timings?latitude=${lat.toStringAsPrecision(7)}&longitude=${long.toStringAsPrecision(7)}&method=2&timezonestring=Europe/London');
    return DashboardMosqueModel.fromJson(json.decode(response.body));
  }

  Future<DashboardMosqueModel> getPrayerTimesTomorrow(double lat, double long) async {
    int tomorrow =DateTime.now().add(Duration(days: 1)).millisecondsSinceEpoch;
    final response = await http.get('http://api.aladhan.com/v1/timings/${tomorrow}?latitude=${lat.toStringAsPrecision(7)}&longitude=${long.toStringAsPrecision(7)}&method=2&timezonestring=Europe/London');
    return DashboardMosqueModel.fromJson(json.decode(response.body));
  }
}
