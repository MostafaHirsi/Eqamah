import 'dart:async';
import 'dart:convert';
import 'package:eqamah/models/dashboard/mosque_model.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

Future<DashboardMosqueModel> getPrayerTimes(String params) async {
  final response = await http.get('http://api.aladhan.com/v1' + params);
  return DashboardMosqueModel.fromJson(json.decode(response.body));
}

//latitude=51.508515&longitude=-0.1254872&method=2&month=4&year=2017
