import 'dart:math' as math;

class CalculationUtil {
  static double calculateDistanceInMeters(double lat2, double lon2) {
    const double earthRadiusKm = 6371.0;
    double lat1 = 0.74347;
    double lon1 = 33.74347;
    double lat1Rad = lat1 * (math.pi / 180.0);
    double lon1Rad = lon1 * (math.pi / 180.0);
    double lat2Rad = lat2 * (math.pi / 180.0);
    double lon2Rad = lon2 * (math.pi / 180.0);

    double dlat = lat2Rad - lat1Rad;
    double dlon = lon2Rad - lon1Rad;

    double a = math.sin(dlat / 2) * math.sin(dlat / 2) +
        math.cos(lat1Rad) *
            math.cos(lat2Rad) *
            math.sin(dlon / 2) *
            math.sin(dlon / 2);
    double c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));
    double distanceKm = earthRadiusKm * c;
    double distanceMeters = distanceKm * 1000;

    return distanceMeters;
  }
}
