import 'package:forecast_pro/features/home_screen_weather/domain/entities/location.dart';

class LocationModel extends Location {
  const LocationModel({
    required super.name,
    required super.region,
    required super.country,
    required super.timezone,
    required super.localTimeEpoch,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      name: json['name'],
      region: json['region'],
      country: json['country'],
      timezone: json['tz_id'],
      localTimeEpoch: json['localtime_epoch'],
    );
  }
}
