import 'dart:async';
import 'dart:convert';
import 'package:eqamah/models/dashboard/mosque_model.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

Future<DashboardMosqueModel> getPrayerTimes(String params) async {
  final response = await http.get('http://api.aladhan.com/v1' + params);
  return DashboardMosqueModel.fromJson(json.decode(response.body));
}

