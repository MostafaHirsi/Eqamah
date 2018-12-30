import 'dart:math' as math;

import 'package:vector_math/vector_math_64.dart';

double qiblaDirection(double lat, double long) {
  double meccaLat = 21.3891;
  double meccaLong = -39.8579;

  double top = math.sin(radians(119.0166) - radians(-39.75));

  double bottomLeft = math.cos(radians(lat)) * math.tan(radians(meccaLat));

  double bottomRight = math.sin(radians(lat)) * (math.cos(radians(long - meccaLong)));

  double untanned = top / (bottomLeft - bottomRight);

  double qiblaDirection = radians2Degrees*math.atan(untanned);

  return qiblaDirection;
}
